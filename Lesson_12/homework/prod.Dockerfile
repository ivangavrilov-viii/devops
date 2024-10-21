FROM openjdk:11-jre-slim
WORKDIR /app
EXPOSE 8080

ENV DB_USERNAME=root
ENV DB_PORT=5432
ENV DB_PASSWORD=rootpassword
ENV DB_IP=158.160.79.92
ENV DB_NAME=db

CMD ["java", "-jar", "App42PaaS-Java-MySQL-Sample.jar"]