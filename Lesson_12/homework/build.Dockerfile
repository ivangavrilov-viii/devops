FROM ubuntu:18.04
RUN apt update && apt install default-jdk maven git -y
RUN mkdir /app
WORKDIR /app
RUN git clone https://github.com/shephertz/App42PaaS-Java-MySQL-Sample.git .
RUN mvn package



# RUN apt install wget -y
# RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.96/bin/apache-tomcat-9.0.96.tar.gz
# RUN tar xzf apache-tomcat-9.0.96.tar.gz
# RUN mv apache-tomcat-9.0.96 /var/lib/tomcat9
# RUN rm -r apache-tomcat-9.0.96.tar.gz
#
#
#
# RUN cp /app/target/App42PaaS-Java-MySQL-Sample-0.0.1-SNAPSHOT.war /var/lib/tomcat9/webapps/app.war
# EXPOSE 8080
# CMD ["/var/lib/tomcat9/bin/catalina.sh", "run"]