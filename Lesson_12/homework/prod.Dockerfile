FROM tomcat:9.0-jdk11
RUN cp /app/target/*.war /var/lib/tomcat9/webapps/app.war
EXPOSE 8080