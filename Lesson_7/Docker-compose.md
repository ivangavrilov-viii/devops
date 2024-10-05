# ***Lesson about cluster system, YAML and docker-compose***

## [[DevOps]]


## Created by [Ivan Gavrilov](https://github.com/ivangavrilov-viii)
---
## Summary of Content:
This section describes


---
## Useful links:
[Docker compose](https://github.com/docker/compose/releases/download/v2.29.7/docker-compose-linux-x86_64)


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
#### 
```bash
sudo su
cd
apt update
apt install docker.io
wget https://github.com/docker/compose/releases/download/v2.29.7/docker-compose-linux-x86_64
cp docker-compose-linux-x86_64 /bin/docker-compose
chmod +x /bin/docker-compose
docker-compose --version
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
         
...
```
