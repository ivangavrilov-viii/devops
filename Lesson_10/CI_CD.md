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


## Content:
---
> CI/CD - Continuous Integration & Continuous Deployment

> Jenkins - инструмент автоматизации


---
### View
![[]]

---
### Report
![[]]

---
### Homework
![[]]

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
#### 

