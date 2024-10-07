# ***Ansible and playbooks.***

## [[DevOps]]


## Created by [Ivan Gavrilov](https://github.com/ivangavrilov-viii)
---
## Summary of Content:
This section describes about Ansible.


---
## Useful links:
[Zoom](https://us06web.zoom.us/rec/share/zF311L5XL82tcGxh0OXFTAXX-9LF12wbsWGk51oNaO9oRZ0iwHeU86g6hPt657dZ.8sFsbsYw6xyUSiWY) Access Code: ```my*RG@13```
[Ansible – All modules](https://docs.ansible.com/ansible/2.8/modules/list_of_all_modules.html)
[Habr – Ansible: 30 самых важных модулей для DevOps-профессионалов](https://habr.com/ru/companies/slurm/articles/707130/)
[Ansible AWX](https://github.com/ansible/awx)
[Polemarch](https://polemarch.org)
[[Запускаем Ansible|Ansible Book]]


## Content:
---
> Ansible — система управления конфигурациями, написанная на языке программирования Python, с использованием декларативного языка разметки для описания конфигураций. Применяется для автоматизации настройки и развёртывания программного обеспечения.

> Red Hat Ansible Tower – графический интерфейс для работы с Ansible

> Playbook - файл со сценарием для Ansible (написан на YAML формате)

## WARNING:
> Нельзя удалять и копировать файлы между серверами с помощью команды _shell_ вызываемой из главного сервера.

### Homework
![[homework_8.pdf]]

---
### Lesson steps
#### Install ansible in master server
```bash
sudo su
apt update
apt install ansible
```
#### Install python in slaves servers
```bash
sudo su
apt update
apt install python
```
---
#### Ansible config files
```bash
cd /etc/ansible
nano hosts
```
> Файл hosts (Ansible Inventory) – инвентаризационный файл для Ansible 

Add in the end file
```
[web]
slave_ip_1

[db]
slave_ip_2
```
---
#### Check connect servers in file "hosts"
```bash
ansible all -m ping
```
---
#### Info about all hosts
```bash
ansible all -m setup
```
---
#### Do something from master server in another slaves servers 
```
ansible all -m shell -a "uname -a"
```
> uname -a – любая команда которую надо выполнить на всех серверах через ansible
---
#### Copy file from master to slaves
```
nano hello.txt
ansible all -m copy -a "src=hello.txt dest=/tmp"
```

Check success coping files in slaves servers
```
ansible all -m shell -a "ls /tmp"
```
---
#### Delete _hello.txt_ file from slaves servers
```
ansible all -m file -a "path=/tmp/hello.txt state=absent"
```
---
#### Install nginx using ansible
```
ansible all -m apt -a "name=nginx state=latest"
```
---
#### Ansible logs (example)
```
ansible all -m ping -v
```
> параметр -v выводит комментарии при выполнении команды (можно добавлять vvv для вывода еще большей информации)
---
#### Create playbook 
```bash
nano demo.aml
```

```YAML
---
- name: provisioning nginx
  hosts: web
  become: yes

  tasks:
    - name: Ensure nginx package is present
      apt: 
        name: nginx
        state: present
    
	- name: Copy index.html
	  copy:
	    src: index.html
	    dest: /var/www/html
	
	- name: Ensure nginx service is started
	  service:
	    name: nginx
	    state: started

- name: setup db
  hosts: db
  become: yes

  tasks:
    - name: Ensure postgresql package is present
      apt:
        name: postgresql
        state: present

    - name: Ensure postgresql service is started
      service:
        name: postgresql
        state: started
        
...
```
#### Create _index.html_
```bash
nano index.html
```

```html
<html>
<h1>Hello Ansible !</h1>
</html>
```
---
#### Start wrotten playbook
```bash
ansible-playbook demo.yml
```
---
