FROM openjdk:11-jre-slim
WORKDIR /app
EXPOSE 8080

ENV MYSQL_USER=root
ENV MYSQL_PORT=5432
ENV MYSQL_PASSWORD=rootpassword
ENV MYSQL_HOST=158.160.79.92
ENV MYSQL_DATABASE=db

CMD ["java", "-jar", "App42PaaS-Java-MySQL-Sample.jar"]