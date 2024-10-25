FROM ubuntu:18.04

RUN apt update && apt install -y default-jdk wget  && \
    wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.96/bin/apache-tomcat-9.0.96.tar.gz>
    tar xzf apache-tomcat-9.0.96.tar.gz && \
    mv apache-tomcat-9.0.96 /var/lib/tomcat9 && \
    rm -r apache-tomcat-9.0.96.tar.gz

EXPOSE 8080
CMD ["/var/lib/tomcat9/bin/catalina.sh", "run"]