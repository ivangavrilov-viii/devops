

RUN apt install wget -y
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.95/bin/apache-tomcat-9.0.95.tar.gz
RUN tar xzf apache-tomcat-9.0.95.tar.gz
RUN mv apache-tomcat-9.0.95 /var/lib/tomcat9
RUN rm -r apache-tomcat-9.0.95.tar.gz

COPY --from=build /app/target/App42PaaS-Java-MySQL-Sample-0.0.1-SNAPSHOT.war /var/lib/tomcat9/webapps/app.war
# EXPOSE 8080
