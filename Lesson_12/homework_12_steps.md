# ***Homework task***

## [[DevOps]]


## Created by [Ivan Gavrilov](https://github.com/ivangavrilov-viii)
---
## Useful links:



## TASK:
---
> ...

## Solution
---
### Install Docker-compose
```bash
sudo su
apt update
apt install docker.io -y
wget https://github.com/docker/compose/releases/download/v2.29.7/docker-compose-linux-x86_64
cp docker-compose-linux-x86_64 /bin/docker-compose
chmod +x /bin/docker-compose
docker-compose --version
```
---
```bash
git clone https://github.com/ivangavrilov-viii/devops.git
cd devops/Lesson_12/homework
docker-compose up -d
```

```bash
docker-compose up -d
```

```bash
docker-compose down
```

```bash
docker rmi -f $(docker images -aq)
```

```bash
docker rm -vf $(docker ps -aq)
```

## Additional
---
