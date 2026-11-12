FROM tomcat:9.0-jdk11-temurin

# 免费实例内存有限，收紧 Tomcat 与 MariaDB 的内存占用
ENV CATALINA_OPTS="-Xms32m -Xmx160m -XX:MaxMetaspaceSize=96m -Djava.net.preferIPv4Stack=true"

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends mariadb-server mariadb-client \
 && rm -rf /var/lib/apt/lists/* /var/lib/mysql/*

RUN printf '[mysqld]\ninnodb_buffer_pool_size=32M\ninnodb_log_buffer_size=8M\nperformance_schema=OFF\nmax_connections=30\ncharacter-set-server=utf8mb4\ncollation-server=utf8mb4_general_ci\n' > /etc/mysql/mariadb.conf.d/60-render.cnf

RUN rm -rf /usr/local/tomcat/webapps/*

# 应用名 shop.war => 上下文路径 /shop，与库中 /shop/images/... 图片地址一致
COPY shop.war /usr/local/tomcat/webapps/shop.war
COPY shop.sql /opt/shop.sql
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh && sed -i 's/\r$//' /usr/local/bin/entrypoint.sh

EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
