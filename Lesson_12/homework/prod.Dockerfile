FROM ubuntu:18.04
RUN apt update
RUN apt install default-jdk -y
RUN apt install maven -y
RUN apt install git -y
RUN apt install wget -y
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.96/>
RUN tar xzf apache-tomcat-9.0.96.tar.gz
RUN mv apache-tomcat-9.0.96 /var/lib/tomcat9
RUN rm -r apache-tomcat-9.0.96.tar.gz
RUN mkdir /app
WORKDIR /app
RUN git clone https://github.com/shephertz/App42PaaS-Java-MySQL-Sample.git .
RUN mvn package
RUN cp /boxfuse-sample-java-war-hello/target/hello-1.0.war /var/lib/tomcat9/webapps/
EXPOSE 8080
CMD ["/var/lib/tomcat9/bin/catalina.sh", "run"]