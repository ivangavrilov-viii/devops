# ***Homework on Docker***

## [[DevOps]]


## Created by [Ivan Gavrilov](https://github.com/ivangavrilov-viii)
---
## Useful links:
[Tomcat containers](https://hub.docker.com/_/tomcat)
[Maven container](https://hub.docker.com/_/maven)
[Project in GitHub](https://github.com/boxfuse/boxfuse-sample-java-war-hello.git )
[[Dockerfile]]

## TASK:
---
> Упаковать Java приложение в Docker- контейнер. Процесс сборки производить также в контейнере.

## Solution
---
#### Install docker
```
sudo su
cd 
apt update
apt install docker.io
```
#### Dockerfile
```
git clone https://github.com/ivangavrilov-viii/devops.git
```

```
mv devops/Lesson_6/Dockerfile .
```

```
docker build -t test .
```
#### Start docker image
```
docker run -d -p 8080:8080 test
```
> -d - чтобы не провалиться в этот контейнер, а просто запустить
> -p 8080:8080 - открываем порты для докера

## Additional
---
#### Run docker container
```
docker run -i -t test
```
#### Pushing on docker hub
```
docker image tag test gavril23/start_boxfuse
```

```
docker login -u gavril23
```

```
docker push gavril23/start_boxfuse
```
---
