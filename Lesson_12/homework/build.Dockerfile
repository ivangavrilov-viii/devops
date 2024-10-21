FROM ubuntu:18.04
RUN apt update && apt install default-jdk maven git -y
RUN mkdir /app
WORKDIR /app
RUN git clone https://github.com/shephertz/App42PaaS-Java-MySQL-Sample.git .
COPY ./Config.properties /app/WebContent/Config.properties
RUN mvn package