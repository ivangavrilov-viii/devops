# ***Homework task***

## [[DevOps]]


## Created by [Ivan Gavrilov](https://github.com/ivangavrilov-viii)
---
## Useful links:



## TASK:
---
> Создать 2 задачи Jenkins: Первая задача должна собирать Docker образ с заданным тегом (например v1.0), на сборочной ноде, и пушить его в registry. Вторая Job должна пулить (подтягивать) Docker образ с требуемым тегом из registry и запускать контейнер на продовой ноде.

## Solution
---
### Requirements

4 Виртуальных машины:
1. Nexus (4RAM 4vCPU) - Docker registry
2. Jenkins
3. Build
4. Prod
---
### Start Nexus
```
nano docker-compose.yml
```

```
---
version: '3'
services:
  nexus:
    image: sonatype/nexus3
    ports:
      - '8081:8081'
      - "8123:8123"
    volumes:
      - ./data:/nexus-data
...
```

Собираем docker
```
docker-compose up -d
```

Даем права на созданный volume
```
chown -R 200:200 data/
```

Снова собираем docker
```
docker-compose up -d
```
---
### Create docker registry in Nexus
![[GMT20200620-151449_Dmitry----_1280x1024.mp4]]

```
docker build -t build_app .
docker image tag build_app 158.160.13.136:8123/build_app
docker login 158.160.13.136:8123
docker push 158.160.13.136:8123/build_app
```

```
docker build -t build_app:2 .
docker image tag build_app:2 158.160.13.136:8123/build_app:2
docker push 158.160.13.136:8123/build_app:2
```

```
nano /etc/docker/daemon.json
```

```JSON
{
	"insecure-registries": ["158.160.13.136:8123"]
}
```
---
### Prepare Jenkins
```bash
sudo su 
apt update
apt install docker.io -y
```

Install docker container Jenkins
```bash
docker run -d -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 --restart=on-failure jenkins/jenkins:lts-jdk17
```

Search container_id for Jenkins
```bash
docker ps
```

Copy auth-code for Jenkins from logs
```bash
docker logs a013303598db 
```

```
da247796fc724124b4a4cfc62d546684
```

Install SSH and SSH Agent plugins for Jenkins

---
### Prepare Build server
```bash
apt install docker.io -y
docker login 158.160.13.136:8123
```

```bash
nano /etc/docker/daemon.json
```

```JSON
{
	"insecure-registries": ["158.160.13.136:8123"]
}
```

```
nano Dockerfile
```

```
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
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git  
WORKDIR /boxfuse-sample-java-war-hello/  
RUN mvn package  
RUN cp /boxfuse-sample-java-war-hello/target/hello-1.0.war /var/lib/tomcat9/webapps/  
EXPOSE 8080  
CMD ["/var/lib/tomcat9/bin/catalina.sh", "run"]
```

Jenkins commands
```
cd /home/ivan
docker build -t build_app:$version_tag .
docker image tag build_app:$version_tag 158.160.13.136:8123/build_app:$version_tag
docker push 158.160.13.136:8123/build_app:$version_tag
```
---
### Prepare Prod server
```bash
apt install docker.io -y
docker login 158.160.13.136:8123
```

```bash
nano /etc/docker/daemon.json
```

```JSON
{
	"insecure-registries": ["158.160.13.136:8123"]
}
```

---
```
docker image pull 158.160.13.136:8123/build_app:$version_tag
docker run -d -p 8080:8080 158.160.13.136:8123/build_app:$version_tag
```
---
