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

## Additional
---
```
docker run -i -t test
```
