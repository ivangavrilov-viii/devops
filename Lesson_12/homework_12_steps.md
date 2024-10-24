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
apt update && apt install docker.io -y
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

```
docker exec -it homework-prod_service-1 /bin/bash
```

```
https://wiki.pwodev.com/docker-%D0%BA%D0%B0%D0%BA-%D0%BF%D0%BE%D1%87%D0%B8%D1%81%D1%82%D0%B8%D1%82%D1%8C-%D0%B2%D0%B5%D1%81%D1%8C-%D0%BC%D1%83%D1%81%D0%BE%D1%80/
```
## Additional
---
