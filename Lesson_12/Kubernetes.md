# ***Kubernetes***

## [[DevOps]]


## Created by [Ivan Gavrilov](https://github.com/ivangavrilov-viii)
---
## Summary of Content:




---
## Useful links:
https://github.com/shephertz/App42PaaS-Java-MySQL-Sample



## Content:
---
```
docker run --privileged -d --restart=unless-stopped -p 80:80 -p 443:443 rancher/rancher:v2.4-head-linux-amd64
```

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: tomcat-deployment
  labels:
    app: tomcat
spec:
  replicas: 1
  selector:
    matchLabels:
      app: tomcat
  template:
    metadata:
      labels:
        app: tomcat
    spec:
      containers:
      - name: tomcat
        image: tomcat:latest
        ports:
        - containerPort: 8080
```

```
kind: Service
apiVersion: v1
metadata:
  name: tomcat-service
spec:
  type: NodePort
  selector:
    app: tomcat
  ports:
  - protocol: TCP
    port: 8080
    targetPort: 8080
```
---
### View
![[GMT20241017-171920_Recording_1280x1024.mp4]]

---
### Report
![[]]

---
### Homework
![[homework_12.pdf]]

---
### Lesson steps
#### Prepare server
```

```





