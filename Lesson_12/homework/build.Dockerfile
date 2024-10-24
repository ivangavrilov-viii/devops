FROM ubuntu:18.04
RUN apt update && apt install default-jdk maven git -y
RUN mkdir /app
WORKDIR /app
ARG CACHEBUST=1
RUN git clone https://github.com/ivangavrilov-viii/app-for-compose.git .
RUN mvn package
RUN mv WebContent target/WebContent