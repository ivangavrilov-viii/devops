# ***DESCRIPTION***

## [[DevOps]]


## Created by [Ivan Gavrilov](https://github.com/ivangavrilov-viii)
---
## Summary of Content:
This section describes virtualization, hypervisor types, build systems, and the installation and configuration of Apache Tomcat. The scope of this article included the task of deploying a basic JAVA application. 

---
## Useful links:
[Аренда выделенного сервера](https://selectel.ru/services/dedicated/)
[Облачные сервисы](https://selectel.ru/services/cloud/servers/?section=prices)
[Покупки серверов](https://trinity.ru/configurators/servers/trinity/23082/)
[Аренда выделенного сервера](https://netrack.ru/dedicated)
[Java App GitHub](https://github.com/boxfuse/boxfuse-sample-java-war-hello)
[Webapp #1](https://github.com/koddas/war-web-project)
[Webapp #2](https://github.com/cloud-dev-user/java-war-project)


## Content:
---

---
### Report
![[]]

---
### Homework content
![[homework_3.pdf]]

---
### Homework Results

[Webapp #0](https://github.com/boxfuse/boxfuse-sample-java-war-hello)
![[boxfuse_app.png]]

[Webapp #1](https://github.com/koddas/war-web-project)
![[war_web_service.png]]

[Webapp #2](https://github.com/cloud-dev-user/java-war-project)
![[my_app_project.png]]

---
### Cmd history and steps

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

Install and start "war-web-project" with Java and Maven
```
git clone https://github.com/koddas/war-web-project.git
cd war-web-project/
mvn package
cd target/
sudo cp wwp-1.0.0.war /var/lib/tomcat9/webapps/
```

Install and start "java-war-project" with Java and Maven
```
git clone https://github.com/cloud-dev-user/java-war-project.git
cd java-war-project/
mvn package
cd target/
sudo cp my-app.war /var/lib/tomcat9/webapps/
```
---
