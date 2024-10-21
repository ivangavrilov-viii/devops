# ***Kubernetes***

## [[DevOps]]


## Created by [Ivan Gavrilov](https://github.com/ivangavrilov-viii)
---
## Summary of Content:




---
## Useful links:
[Zoom](https://us06web.zoom.us/rec/share/KNvPNFh35jH4gCbuFHKN2wVuU_N2oXA210YLUHcytPNMgCXgVUbUahD-VwNrPXyw.QmLcoeOzi6ZcsoTS) ``` D^VD3k4z ```
[Homework repository](https://github.com/shephertz/App42PaaS-Java-MySQL-Sample)
[Kuberbates the hard way - GitHub](https://github.com/kelseyhightower/kubernetes-the-hard-way)
Cloud native - AWS - стандарт разработки


### Content:
---


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
#### Install kubernetes
Kubernates the hard way
```
sudo su
apt update
apt install docker.io
docker run --privileged -d --restart=unless-stopped -p 80:80 -p 443:443 rancher/rancher:v2.4-head-linux-amd64
```

```
Add cluster
Custom kind
```

Select Kubernetes version
```
1.15.12 
```

Node options
```
select all
```

Create YAML file
```

```


```
Cluster IP -> NodePort
```

#### Install Tomcat service & deployment with YAML
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
#### Open CLI kubectl
```
kubectl run php-apache --image=k8s.gcr.io/hpa-example --requests=cpu=2--m --expose --port=80
```

```
kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10
```

```
kubectl run -i --tty load-generator --image=busybox /bin/sh
```

```
while true; do wget -q -O- ip_address; done
```
---
