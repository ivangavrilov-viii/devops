# ***Jenkins. Pipeline***

## [[DevOps]]


## Created by [Ivan Gavrilov](https://github.com/ivangavrilov-viii)
---
## Summary of Content:
This section describes


---
## Useful links:
[Zoom](https://us06web.zoom.us/rec/share/0_P50cS3TLq1cDAKD0x8Wzwa_psYWUtU9N6hkxt2hDvKKHgBtgvpt2nlYfHgPQSe.ho_oLTHP_QW4qdBB) Access code: ```x^A6Ns*P```
[GitHub demo18](https://github.com/dkgnim/demo18)
[Jenkins Pipeline](https://www.jenkins.io/doc/book/pipeline/)




## Content:
---

---
### View (1.10 минута)
![[GMT20241014-172552_Recording_1600x1024.mp4]]

---
### Report
![[]]

---
### Homework
![[homework_11.pdf]]

---
### Lesson steps
#### Prepare build server
```bash
sudo su
apt update
apt install tomcat9 tomcat9-admin -y
```

Add user in Tomcat
```
nano /etc/tomcat9/tomcat-users.xml
```

```
<role rolename="manager-gui"/>
<role rolename="manager-script"/>
<user username="deployer" password="deploy" role="manager-script,manager-gui"/>
```

```
service tomcat9 restart
```
---
#### Settings Jenkins
1. Add credentionals (user with password)
   username: deployer
   password: deploy
2. Add tools - Maven
   m3
   last version
3. Add plugins
   - Deploy to container
   - 
---
#### Add new Job
---
#### Add webhooks from Git
Go to project settings -> Webhooks -> Add webhook
```
Payload_url: ip_jenkins:8080/github-webhook/
Content_type: application/json
```
---
#### Set webhooks in Jenkins
Go Job settings
triggers
Select "GitHub hook triger for GITScm polling"

---
#### Create a new job (type: pipeline)
```GROOVY
pipeline {
	agent any
	
	stages {
		stage ('git clone') {
			steps {
				echo 'git clone'
			}
		}
		stage ('build') {
			steps {
				echo 'build'
			}
		}
		stage ('deploy') {
			steps {
				echo 'deploy'
			}
		}
	}
}
```








