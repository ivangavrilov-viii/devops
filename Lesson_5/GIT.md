# ***Lesson about GIT version control system***

## [[DevOps]]


## Created by [Ivan Gavrilov](https://github.com/ivangavrilov-viii)
---
## Summary of Content:
This section describes 


---
## Useful links:
[GitFlow: как построить процесс разработки – YouTube](https://www.youtube.com/watch?v=rC6varfUhCo)
[Git Cheat Sheet Link](https://proglib.io/p/git-cheatsheet)
[[git-cheat-sheet-education.pdf|Git Cheat Sheet File]]

## Content:
---
Для работы на уроке потребуется VM: от 4vCPU от 4GB RAM и от 65 GB SSD.

---
### Homework content
![[homework_5.pdf]]

---

```
docker run --detach \
  --hostname gitlab.example.com \
  --env GITLAB_OMNIBUS_CONFIG="external_url 'http://gitlab.example.com'" \
  --publish 443:443 --publish 80:80 --publish 23:22 \
  --name gitlab \
  --restart always \
  --volume $GITLAB_HOME/config:/etc/gitlab \
  --volume $GITLAB_HOME/logs:/var/log/gitlab \
  --volume $GITLAB_HOME/data:/var/opt/gitlab \
  --shm-size 256m \
  gitlab/gitlab-ce
```

```
docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password
```
