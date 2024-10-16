# ***Continuous Integration & Continuous Deployment

## [[DevOps]]


## Created by [Ivan Gavrilov](https://github.com/ivangavrilov-viii)
---
## Summary of Content:
This section describes about CI/CD, Jenkins.


---
## Useful links:
[Catlight](https://catlight.io/) - Action center for developers
[Jenkins builds](https://ci.xwiki.org)
[Версионирование](https://semver.org/lang/ru/)


## Content:
---
> CI/CD - Continuous Integration & Continuous Deployment

> Jenkins - инструмент автоматизации

> Принципиальное различие Ansible от Jenkins – 

---
### View
![[GMT20241010-171216_Recording_1280x1024.mp4]]

---
### Report
![[]]

---
### Homework
![[homework_10.pdf]]

---
### Lesson steps
#### Prepare server  
```bash
sudo su 
apt update
apt install docker.io -y
```
---
#### Install docker container Jenkins
```bash
docker run -d -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 --restart=on-failure jenkins/jenkins:lts-jdk17
```
---
#### Search container_id for Jenkins
```bash
docker ps
```
---
#### Copy auth-code for Jenkins from logs
```bash
docker logs a013303598db 
```
---
#### Go to server IP and insert auth-code in web page
---
#### Create First Admin User in Jenkins
```
user
12345
12345
User Admin
gavrilovivan2001@gmail.com
```
---
#### Install plugins in Jenkins
```
SSH
SSH Agent
```
---
#### Add VM in Credentional
---
#### Add host
Go to system
Hostname: input IP
Port: 22
Credentional: root
Press check connection

---
#### Create Job