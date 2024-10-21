FROM tomcat:9.0-jdk11-openjdk-slim-buster
EXPOSE 8080
WORKDIR /app
RUN cp /app/target/App42PaaS-Java-MySQL-Sample-0.0.1-SNAPSHOT.war /var/lib/tomcat9/webapps/

ENV MYSQL_USER=root
ENV MYSQL_PORT=5432
ENV MYSQL_PASSWORD=rootpassword
ENV MYSQL_HOST=158.160.79.92
ENV MYSQL_DATABASE=db