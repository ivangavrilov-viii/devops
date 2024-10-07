# ***Lesson about cluster system, YAML and docker-compose***

## [[DevOps]]


## Created by [Ivan Gavrilov](https://github.com/ivangavrilov-viii)
---
## Summary of Content:
This section describes


---
## Useful links:
[Docker compose](https://github.com/docker/compose/releases/download/v2.29.7/docker-compose-linux-x86_64)
[Elastic stack (ELK) on Docker](https://github.com/deviantony/docker-elk)
 


## Content:
---
> YAML - человекочитаемый формат сериализации данных


### Homework
![[homework_7.pdf]]

---
### Lessons steps
#### First example of working with YAML
```bash
nano test1.yaml
```

```yaml
---
Fruits:
  - Apple
  - Banana
  - Mango
...
```
> 2 space = tab in YAML
---
#### Install YAML validator in CMD
```bash
apt install yamllint
```

```bash
yamllint test1.yaml
```
---
#### Second example of working with YAML
```bash
nano test2.yml
```

```YAML
---
# Employer records
- Ivan:
  name: Ivan
  job: Developer
  skills:
    - python
    - perl
    - pascal
- Vasya:
  name: Vasya
  job: Developer
  skills:
    - lisp
    - fortran
    - erland
...
```
---
#### Install docker-compose
```bash
sudo su
cd
apt update
apt install docker.io
wget https://github.com/docker/compose/releases/download/v2.29.7/docker-compose-linux-x86_64
cp docker-compose-linux-x86_64 /bin/docker-compose
chmod +x /bin/docker-compose
docker-compose --version
```
#### First docker-compose file
```
nano docker-compose.yaml
```

```YAML
---
version: '3'
services:
    php:
        build:
            context: ./docker
            dockerfile: php.Dockerfile
        volumes:
            - './app:/var/www/html'
        depends_on:
            - mariadb
    nginx:
        image: nginx:latest
        ports:
            - '80:80'
            - '443:443'
        links:
            - 'php'
        volumes:
            - './app:/var/www/html'
            - '.config/nginx:/etc/nginx/conf.d'
    mariadb:
        image: mariadb:11
        restart: 'on-failure'
        environment:
            MYSQL_ROOT_PASSWORD: 'secret'
        volumes:
            - './mysql:/var/lib/mysql'
...
```
---
#### Docker-compose commands
```bash
docker-compose up -d
docker-compose ps
docker-compose logs
docker-compose stop
docker-compose rm
```
