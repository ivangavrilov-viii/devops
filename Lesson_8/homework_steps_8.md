# ***Homework task***

## [[DevOps]]


## Created by [Ivan Gavrilov](https://github.com/ivangavrilov-viii)
---
## Useful links:



## TASK:
---
> Написать playbook, который подготавливает сборочное и продовое окружение на 2-х нодах. На сборочной ноде производится сборка проекта, на продовой - запуск.

## Solution
---
Gen SSH keys
```
ssh-keygen -t ed25519 
```

COPY 
```
ssh-copy-id ivan@build
ssh-copy-id ivan@production
```


```bash
sudo su
apt update
apt install ansible -y
apt install git -y
```

Add slaves ip in ansible
```bash
nano /etc/ansible/hosts
```

```
[production]
production_ip  

[build]
build_ip
```

Check connection
```
ansible all -m ping
```

```
git clone https://github.com/ivangavrilov-viii/devops.git
```

```bash
cd devops/Lesson_8/homework_app/
ansible-playbook homework.yml
```











---










## Additional
---



