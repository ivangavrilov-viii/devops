# ***DESCRIPTION***

## [[DevOps]]


## Created by [Ivan Gavrilov](https://github.com/ivangavrilov-viii)
---
## Summary of Content:
This section describes


---
## Useful links:



## Content:
---

---
### Report
![[]]

---
### Homework
![[]]

---

## Lesson command list
### Install docker
```
sudo su
apt update
apt install docker.io
```
### Help
```
docker start --help
```
### Info about Docker
```
docker info
```
### Start container on base Ubuntu 18.04 and fall into
```
docker run -i -t ubuntu:18.04 /bin/bash
```
### List of starting containers
```
docker ps
```
### List of all containers
```
docker ps -a
```
### See all images
```
docker images
```
### Start container by its ID
```
docker start {docker_id}
```
### Delete container 
```
docker rm c008d931d959
```
---
### Dockerfile

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
### Start docker image
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
