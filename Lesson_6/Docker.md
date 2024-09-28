# ***DESCRIPTION***

## [[DevOps]]


## Created by [Ivan Gavrilov](https://github.com/ivangavrilov-viii)
---
## Summary of Content:
This section describes


---
## Useful links:
[[Использование Docker|Book about Docker (Using Docker)]]
[[Docker Up&Runing(en)|Book about Docker (Up&Running)]]
[Zoom](https://us06web.zoom.us/rec/share/VkUW8OGm1G5O_fsJNho_2w1TDgaQrTf1UsvD41PLQt4slLS4JVo10LLbf-_z8BLi.7-V3I4L2wz_s8N3T) Access code: ```z*!E^H4Z```


## Content:
---


---
### Report
![[]]

---
### Homework
![[homework_6.pdf]]

---
### Lesson command list
#### Install docker
```
sudo su
apt update
apt install docker.io
```
#### Help
```
docker start --help
```
#### Info about Docker
```
docker info
```
#### Start container on base Ubuntu 18.04 and fall into
```
docker run -i -t ubuntu:18.04 /bin/bash
```
#### List of starting containers
```
docker ps
```
#### List of all containers
```
docker ps -a
```
#### See all images
```
docker images
```
#### Start container by its ID
```
docker start {docker_id}
```
#### Delete container 
```
docker rm c008d931d959
```
---
#### Dockerfile
```
nano Dockerfile
```

```
FROM ubuntu:18.04
RUN apt update
RUN apt install nginx -y
EXPOSE 80
RUN rm -rf /var/www/html/*
ADD index.html /var/www/html/
CMD ["nginx", "-g", "daemon off;"]
```

```
docker build -t {image_name} .
```
> . - 
---
#### Start docker image
```
docker run -d -p 80:80 {image_name}
```
> -d - чтобы не провалиться в этот контейнер, а просто запустить
> -p 80:80 - открываем порты для докера
---

```
docker image tag my_index_1 gavril23/myfirstwebapp1
```

```
docker login -u gavril23
```
---

#### Pushing on docker hub
```
docker push gavril23/firstapp
```


---
Update server and install requirements
```
sudo apt update
sudo apt install default-jdk
apt-cache policy tomcat*
sudo apt install tomcat9
sudo apt install maven
sudo apt install git
```

Install and start "boxfuse-sample-java-war-hello" project with Java and Maven
```
git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
cd boxfuse-sample-java-war-hello/
mvn package
cd target/
sudo cp hello-1.0.war /var/lib/tomcat9/webapps/
cd /var/lib/tomcat9/webapps/
ss -tupln
```



```
docker run -i -t test
```
