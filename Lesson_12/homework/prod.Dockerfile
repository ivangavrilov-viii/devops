FROM tomcat:9.0-jdk11-openjdk-slim-buster
COPY --from=build /app/target/App42PaaS-Java-MySQL-Sample-0.0.1-SNAPSHOT.war /var/lib/tomcat9/webapps/
EXPOSE 8080

ENV MYSQL_USER=root
ENV MYSQL_PORT=5432
ENV MYSQL_PASSWORD=rootpassword
ENV MYSQL_HOST=158.160.79.92
ENV MYSQL_DATABASE=db