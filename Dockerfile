FROM tomcat:9.0-jdk11-temurin

# 512MB 免费实例：Tomcat 堆 + Metaspace + MariaDB 合计控制在 512MB 内
ENV CATALINA_OPTS="-Xms32m -Xmx192m -XX:MaxMetaspaceSize=96m -XX:+UseSerialGC -Djava.net.preferIPv4Stack=true"
ENV PORT=8080

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends mariadb-server mariadb-client \
 && rm -rf /var/lib/apt/lists/* /var/lib/mysql/*

RUN printf '[mysqld]\ninnodb_buffer_pool_size=32M\ninnodb_log_buffer_size=8M\nperformance_schema=OFF\nmax_connections=30\ncharacter-set-server=utf8mb4\ncollation-server=utf8mb4_general_ci\n' > /etc/mysql/mariadb.conf.d/60-space.cnf

RUN rm -rf /usr/local/tomcat/webapps/*

# 应用名 shop.war => 上下文路径 /shop，与库中 /shop/images/... 图片地址一致
COPY shop.war /usr/local/tomcat/webapps/shop.war
COPY shop.sql /opt/shop.sql
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh \
 && sed -i 's/\r$//' /usr/local/bin/entrypoint.sh \
 && mkdir -p /run/mysqld /var/lib/mysql \
 && chown -R 1000:1000 /var/lib/mysql /run/mysqld /usr/local/tomcat

USER 1000
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
