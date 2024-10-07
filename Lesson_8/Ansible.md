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



```
<158.160.29.132> ESTABLISH SSH CONNECTION FOR USER: None

<158.160.29.132> SSH: EXEC ssh -vvv -C -o ControlMaster=auto -o ControlPersist=60s -o KbdInteractiveAuthentication=no -o PreferredAuthentications=gssapi-with-mic,gssapi-keyex,hostbased,publickey -o PasswordAuthentication=no -o ConnectTimeout=10 -o ControlPath=/root/.ansible/cp/dbcb51d12f 158.160.29.132 '/bin/sh -c '"'"'echo ~ && sleep 0'"'"''

<158.160.29.132> (0, b'/root\n', b'OpenSSH_8.2p1 Ubuntu-4ubuntu0.11, OpenSSL 1.1.1f  31 Mar 2020\r\ndebug1: Reading configuration data /etc/ssh/ssh_config\r\ndebug1: /etc/ssh/ssh_config line 19: include /etc/ssh/ssh_config.d/*.conf matched no files\r\ndebug1: /etc/ssh/ssh_config line 21: Applying options for *\r\ndebug2: resolve_canonicalize: hostname 158.160.29.132 is address\r\ndebug1: auto-mux: Trying existing master\r\ndebug2: fd 3 setting O_NONBLOCK\r\ndebug2: mux_client_hello_exchange: master version 4\r\ndebug3: mux_client_forwards: request forwardings: 0 local, 0 remote\r\ndebug3: mux_client_request_session: entering\r\ndebug3: mux_client_request_alive: entering\r\ndebug3: mux_client_request_alive: done pid = 4930\r\ndebug3: mux_client_request_session: session request sent\r\ndebug3: mux_client_read_packet: read header failed: Broken pipe\r\ndebug2: Received exit status from master 0\r\n')

<158.160.29.132> ESTABLISH SSH CONNECTION FOR USER: None

<158.160.29.132> SSH: EXEC ssh -vvv -C -o ControlMaster=auto -o ControlPersist=60s -o KbdInteractiveAuthentication=no -o PreferredAuthentications=gssapi-with-mic,gssapi-keyex,hostbased,publickey -o PasswordAuthentication=no -o ConnectTimeout=10 -o ControlPath=/root/.ansible/cp/dbcb51d12f 158.160.29.132 '/bin/sh -c '"'"'( umask 77 && mkdir -p "` echo /root/.ansible/tmp/ansible-tmp-1728309326.818952-155426748984826 `" && echo ansible-tmp-1728309326.818952-155426748984826="` echo /root/.ansible/tmp/ansible-tmp-1728309326.818952-155426748984826 `" ) && sleep 0'"'"''

<158.160.29.132> (0, b'ansible-tmp-1728309326.818952-155426748984826=/root/.ansible/tmp/ansible-tmp-1728309326.818952-155426748984826\n', b'OpenSSH_8.2p1 Ubuntu-4ubuntu0.11, OpenSSL 1.1.1f  31 Mar 2020\r\ndebug1: Reading configuration data /etc/ssh/ssh_config\r\ndebug1: /etc/ssh/ssh_config line 19: include /etc/ssh/ssh_config.d/*.conf matched no files\r\ndebug1: /etc/ssh/ssh_config line 21: Applying options for *\r\ndebug2: resolve_canonicalize: hostname 158.160.29.132 is address\r\ndebug1: auto-mux: Trying existing master\r\ndebug2: fd 3 setting O_NONBLOCK\r\ndebug2: mux_client_hello_exchange: master version 4\r\ndebug3: mux_client_forwards: request forwardings: 0 local, 0 remote\r\ndebug3: mux_client_request_session: entering\r\ndebug3: mux_client_request_alive: entering\r\ndebug3: mux_client_request_alive: done pid = 4930\r\ndebug3: mux_client_request_session: session request sent\r\ndebug3: mux_client_read_packet: read header failed: Broken pipe\r\ndebug2: Received exit status from master 0\r\n')

Using module file /usr/lib/python3/dist-packages/ansible/modules/files/synchronize.py

<158.160.29.132> PUT /root/.ansible/tmp/ansible-local-5321l_um39j9/tmpji2eigtz TO /root/.ansible/tmp/ansible-tmp-1728309326.818952-155426748984826/AnsiballZ_synchronize.py

<158.160.29.132> SSH: EXEC sftp -b - -vvv -C -o ControlMaster=auto -o ControlPersist=60s -o KbdInteractiveAuthentication=no -o PreferredAuthentications=gssapi-with-mic,gssapi-keyex,hostbased,publickey -o PasswordAuthentication=no -o ConnectTimeout=10 -o ControlPath=/root/.ansible/cp/dbcb51d12f '[158.160.29.132]'

<158.160.29.132> (0, b'sftp> put /root/.ansible/tmp/ansible-local-5321l_um39j9/tmpji2eigtz /root/.ansible/tmp/ansible-tmp-1728309326.818952-155426748984826/AnsiballZ_synchronize.py\n', b'OpenSSH_8.2p1 Ubuntu-4ubuntu0.11, OpenSSL 1.1.1f  31 Mar 2020\r\ndebug1: Reading configuration data /etc/ssh/ssh_config\r\ndebug1: /etc/ssh/ssh_config line 19: include /etc/ssh/ssh_config.d/*.conf matched no files\r\ndebug1: /etc/ssh/ssh_config line 21: Applying options for *\r\ndebug2: resolve_canonicalize: hostname 158.160.29.132 is address\r\ndebug1: auto-mux: Trying existing master\r\ndebug2: fd 3 setting O_NONBLOCK\r\ndebug2: mux_client_hello_exchange: master version 4\r\ndebug3: mux_client_forwards: request forwardings: 0 local, 0 remote\r\ndebug3: mux_client_request_session: entering\r\ndebug3: mux_client_request_alive: entering\r\ndebug3: mux_client_request_alive: done pid = 4930\r\ndebug3: mux_client_request_session: session request sent\r\ndebug2: Remote version: 3\r\ndebug2: Server supports extension "posix-rename@openssh.com" revision 1\r\ndebug2: Server supports extension "statvfs@openssh.com" revision 2\r\ndebug2: Server supports extension "fstatvfs@openssh.com" revision 2\r\ndebug2: Server supports extension "hardlink@openssh.com" revision 1\r\ndebug2: Server supports extension "fsync@openssh.com" revision 1\r\ndebug2: Server supports extension "lsetstat@openssh.com" revision 1\r\ndebug3: Sent message fd 3 T:16 I:1\r\ndebug3: SSH_FXP_REALPATH . -> /root size 0\r\ndebug3: Looking up /root/.ansible/tmp/ansible-local-5321l_um39j9/tmpji2eigtz\r\ndebug3: Sent message fd 3 T:17 I:2\r\ndebug3: Received stat reply T:101 I:2\r\ndebug1: Couldn\'t stat remote file: No such file or directory\r\ndebug3: Sent message SSH2_FXP_OPEN I:3 P:/root/.ansible/tmp/ansible-tmp-1728309326.818952-155426748984826/AnsiballZ_synchronize.py\r\ndebug3: Sent message SSH2_FXP_WRITE I:4 O:0 S:32768\r\ndebug3: SSH2_FXP_STATUS 0\r\ndebug3: In write loop, ack for 4 32768 bytes at 0\r\ndebug3: Sent message SSH2_FXP_WRITE I:5 O:32768 S:32768\r\ndebug3: Sent message SSH2_FXP_WRITE I:6 O:65536 S:32768\r\ndebug3: Sent message SSH2_FXP_WRITE I:7 O:98304 S:12906\r\ndebug3: SSH2_FXP_STATUS 0\r\ndebug3: In write loop, ack for 5 32768 bytes at 32768\r\ndebug3: SSH2_FXP_STATUS 0\r\ndebug3: In write loop, ack for 6 32768 bytes at 65536\r\ndebug3: SSH2_FXP_STATUS 0\r\ndebug3: In write loop, ack for 7 12906 bytes at 98304\r\ndebug3: Sent message SSH2_FXP_CLOSE I:4\r\ndebug3: SSH2_FXP_STATUS 0\r\ndebug3: mux_client_read_packet: read header failed: Broken pipe\r\ndebug2: Received exit status from master 0\r\n')

<158.160.29.132> ESTABLISH SSH CONNECTION FOR USER: None

<158.160.29.132> SSH: EXEC ssh -vvv -C -o ControlMaster=auto -o ControlPersist=60s -o KbdInteractiveAuthentication=no -o PreferredAuthentications=gssapi-with-mic,gssapi-keyex,hostbased,publickey -o PasswordAuthentication=no -o ConnectTimeout=10 -o ControlPath=/root/.ansible/cp/dbcb51d12f 158.160.29.132 '/bin/sh -c '"'"'chmod u+x /root/.ansible/tmp/ansible-tmp-1728309326.818952-155426748984826/ /root/.ansible/tmp/ansible-tmp-1728309326.818952-155426748984826/AnsiballZ_synchronize.py && sleep 0'"'"''

<158.160.29.132> (0, b'', b'OpenSSH_8.2p1 Ubuntu-4ubuntu0.11, OpenSSL 1.1.1f  31 Mar 2020\r\ndebug1: Reading configuration data /etc/ssh/ssh_config\r\ndebug1: /etc/ssh/ssh_config line 19: include /etc/ssh/ssh_config.d/*.conf matched no files\r\ndebug1: /etc/ssh/ssh_config line 21: Applying options for *\r\ndebug2: resolve_canonicalize: hostname 158.160.29.132 is address\r\ndebug1: auto-mux: Trying existing master\r\ndebug2: fd 3 setting O_NONBLOCK\r\ndebug2: mux_client_hello_exchange: master version 4\r\ndebug3: mux_client_forwards: request forwardings: 0 local, 0 remote\r\ndebug3: mux_client_request_session: entering\r\ndebug3: mux_client_request_alive: entering\r\ndebug3: mux_client_request_alive: done pid = 4930\r\ndebug3: mux_client_request_session: session request sent\r\ndebug3: mux_client_read_packet: read header failed: Broken pipe\r\ndebug2: Received exit status from master 0\r\n')

<158.160.29.132> ESTABLISH SSH CONNECTION FOR USER: None

<158.160.29.132> SSH: EXEC ssh -vvv -C -o ControlMaster=auto -o ControlPersist=60s -o KbdInteractiveAuthentication=no -o PreferredAuthentications=gssapi-with-mic,gssapi-keyex,hostbased,publickey -o PasswordAuthentication=no -o ConnectTimeout=10 -o ControlPath=/root/.ansible/cp/dbcb51d12f -tt 158.160.29.132 '/bin/sh -c '"'"'sudo -H -S -n  -u root /bin/sh -c '"'"'"'"'"'"'"'"'echo BECOME-SUCCESS-xlpdasyaiogjkkdzxwplexrqtmwetcjn ; /usr/bin/python /root/.ansible/tmp/ansible-tmp-1728309326.818952-155426748984826/AnsiballZ_synchronize.py'"'"'"'"'"'"'"'"' && sleep 0'"'"''

Escalation succeeded
```