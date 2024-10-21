FROM tomcat:9.0-jdk11-openjdk-slim-buster
COPY --from=builder /app/target/App42PaaS-Java-MySQL-Sample-0.0.1-SNAPSHOT.war /var/lib/tomcat9/webapps/app.war
EXPOSE 8080
