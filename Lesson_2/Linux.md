# ***Linux. Bash***

## [[DevOps]]


## Created by [Ivan Gavrilov](https://github.com/ivangavrilov-viii)
---
## Summary of Content:
This section describes the basics of Linux, the kernel, processes, files, and basic commands. In addition, this article includes an introduction to bash scripts.


---
## Useful links:
[[Командная_строка_Linux_и_сценарии.pdf|Linux – командная строка]]


## Content:
---

---
### Report
![[devops02.pdf]]

---
### Homework
![[homework_2.pdf]]

---
#


Генерируем SSH ключ на первой машине
ssh-keygen -t ed25519 

cat .ssh/yandex_machine.pub
Копируем и вставляем этот ключ в файл autorized_keys

etc/ssh/sshd_config
Разрешаем от пользователя root

Master_Ivan
Prod_Ivan
Build_Ivan
#### Generate ssh key in master server
```
ssh-keygen
```

На второй машине
Разрешу авторизацию по паролю
```
nano /etc/ssh/sshd_config
```

```
PermitRootlogin yes

ChallengeResponseAuthetification yes

PasswordAuthetification yes

```


service sshd restart

```
passwd root
```

```
ssh-copy-id root@
```



