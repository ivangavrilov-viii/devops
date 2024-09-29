# ******

## [[DevOps]]


## Created by [Ivan Gavrilov](https://github.com/ivangavrilov-viii)
---
## Useful links:



## TASK:
---
> ...

## Solution
---
#### Install docker
```
sudo su
apt update
apt install docker.io
```
#### Dockerfile
```
nano Dockerfile
```

```
docker build -t test .
```
#### Start docker image
```
docker run -d -p 8080:8080 test
```
> -d - чтобы не провалиться в этот контейнер, а просто запустить
> -p 80:80 - открываем порты для докера

```
docker run -i -t test
```

```
FROM ubuntu:18.04  
RUN apt update  
RUN apt install default-jdk -y  
RUN apt install tomcat9 -y  
RUN apt install maven -y  
RUN apt install git -y  
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git  
WORKDIR /boxfuse-sample-java-war-hello/  
RUN mvn package  
RUN cp /boxfuse-sample-java-war-hello/target/hello-1.0.war /var/lib/tomcat9/webapps/  
EXPOSE 8080
```
## Additional
---
