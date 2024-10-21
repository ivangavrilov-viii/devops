FROM maven:3.8.5-openjdk-11
WORKDIR /app
RUN git clone https://github.com/shephertz/App42PaaS-Java-MySQL-Sample.git .
RUN mvn package
