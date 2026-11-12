#!/bin/sh
set -eu

DATADIR=/var/lib/mysql
SOCKET=/run/mysqld/mysqld.sock
PORT="${PORT:-8080}"

mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

if [ ! -d "$DATADIR/mysql" ]; then
  mariadb-install-db --user=mysql --datadir="$DATADIR" --auth-root-authentication-method=normal > /tmp/mariadb-install.log 2>&1
fi

mysqld_safe --user=mysql --datadir="$DATADIR" --socket="$SOCKET" --bind-address=127.0.0.1 > /tmp/mysqld.log 2>&1 &

echo "Waiting for MariaDB..."
i=0
while ! mysqladmin --socket="$SOCKET" ping > /dev/null 2>&1; do
  i=$((i + 1))
  if [ "$i" -ge 90 ]; then
    echo "MariaDB failed to start" >&2
    cat /tmp/mysqld.log >&2 || true
    exit 1
  fi
  sleep 1
done

# 与 WAR 内 WEB-INF/classes/db.properties 保持一致：root/123，仅容器内网可达
if ! mysql --socket="$SOCKET" -uroot -p123 -e "SELECT 1" > /dev/null 2>&1; then
  mysql --socket="$SOCKET" -uroot <<'SQL'
ALTER USER 'root'@'localhost' IDENTIFIED VIA mysql_native_password USING PASSWORD('123');
CREATE DATABASE IF NOT EXISTS shop DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
SQL
fi

TABLES=$(mysql --socket="$SOCKET" -uroot -p123 -N -e "SHOW TABLES FROM shop" 2>/dev/null || true)
case "$TABLES" in
  *product*) ;;
  *)
    echo "Importing shop.sql..."
    mysql --socket="$SOCKET" -uroot -p123 --default-character-set=utf8mb4 shop < /opt/shop.sql
    ;;
esac

# Render 通过 PORT 环境变量指定监听端口
sed -i "s/Connector port=\"8080\"/Connector port=\"${PORT}\"/" "$CATALINA_HOME/conf/server.xml"

exec catalina.sh run
