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




## Content:
---

---
### View (13 минута)
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





