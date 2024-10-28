FROM ubuntu:18.04
RUN apt update && apt install default-jdk maven git -y

RUN mkdir app
WORKDIR /app
RUN git clone https://github.com/ivangavrilov-viii/boxfuse-app.git .
RUN mvn package
