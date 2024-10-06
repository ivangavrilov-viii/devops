FROM tomcat:9.0-jdk11-openjdk-slim-buster
COPY --from=builder /app/target/hello-1.0.war /var/lib/tomcat9/webapps/
EXPOSE 8080
