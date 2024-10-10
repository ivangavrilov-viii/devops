# ***Ansible roles and playbook***

## [[DevOps]]


## Created by [Ivan Gavrilov](https://github.com/ivangavrilov-viii)
---
## Summary of Content:
This section describes about roles in Ansible and playbooks for these roles.


---
## Useful links:
[Zoom](https://us06web.zoom.us/rec/share/WEYt90GHH2Fh-gppcKAql3PvwpxBw8sFiFrgfDSy4ME_WPn-K18n2qYnUyITN19U.hI-np3fTlNkli-S7) Access code: ```4YJ&fV*F```
[[Запускаем Ansible|Ansible Book]]
[Ansible Repository](https://galaxy.ansible.com/ui/)
[Ansible Roles](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_reuse_roles.html)

## Content:
---
```html
<p><script> document.write(new Date().toLocaleDateString()); </script></p>
```

---
### View
![[GMT20241007-174728_Recording_1600x1024.mp4]]

---
### Homework
![[homework_9.pdf]]

---
### Lesson steps

#### Create first file
```bash
nano demo.yml
```

```yaml
---
- name: Add several users
  user:
    name: "{{ item }}"
    groups: "wheel"
    state: present
  with_items:
    - user1
    - user2
    - user3
- name: Install many packages
  apt:
    name: "{{item}}"
    state: installed
  with_items:
    - nginx
    - mc
    - python
...
```
---
#### Create second file
```bash
nano demo3.yml
```

```
---
- name: Ensure Apache package is present
  apt: 
    name: apache2
    state: present
  when:
    ansimle_os_family == "Debian"

- name: Ensure Apache package is present
  yum: 
    name: httpd
    state: present
  when:
    ansimle_os_family == "RedHat"
  notify: Restart Apache


  Handlers:
  - name: Restart Apache
    service:
      name: httpd
      state: restarted




...
```
---
#### Add vars in hosts file for ansible
```
cd /etc/ansible/hosts 
```

```
slave_1_ip state=First
slave_2_ip state=Second
```
---
#### Create html
```
nano index.j2
```

```html
<html>
<body>
	<h1> 
		Hello World! I'm {{ state }} and my ip = {{ansible_all_ipv4_addresses}}
	</h1>
</body>
</html>
```
---
#### Create playbook
```
nano templating.yml
```

```
---
- name: Setup nginx
  hosts: all
  become: yes

  var: 
    source_folder: ./
    dest_folder: /var/www/html

  tasks:
  - name: Ensure nginx package is present
    apt:
      name: nginx
      state: present
  
  - name: Templating web
    template:
      src: {{ source_folder }}/index.j2
      dest: {{ dest_folder }}/index.html
      mode: 0555
    notify: 
      - Restart Nginx

  Handlers:
  - name: Restart Nginx
    service: name=nginx state=restarted
...
```

```
ansible-playbook templating.yml
```
---
#### Install role from ansible roles rep
```bash
ansible-galaxy role install geerlingguy.postgresql
```
---
#### Create own role "common"
```bash
mkdir roles
cd roles
ansible-galaxy init common
nano common/task/main.yml
```

```
---
# tasks file for common
- name: Install packages
  apt: name={{item}} state=installed
  with_items:
    - tree
    - mc
    - htop
    - ncdu
    - links
...
```
---
#### Create own role "webserver"
##### Add var in defaults
```bash
cd roles
ansible-galaxy init webserver
nano webserver/defaults/main.yml
```

```yaml
---
# tasks file for common
dest_folder: /var/www/html
...
```
##### Add index.html in files dir
```bash
nano webserver/files/index.html
```

```html
<html>
	<h1>Hello World!</h1>
</html>
```
##### Add handler in role
```bash
nano webserver/handlers/main.yml
```

```YAML
---
# handlers file for webserver
- name: Restart Nginx
  service: name=nginx state=restarted
...
```
##### Add tasks for role
```bash
nano webserver/tasks/main.yml
```

```YAML
---
# tasks file for webserver
- name: Install Nginx
  apt:
    name: nginx
    state: present

- name: Copy index.html
  copy: src=index.html dest={{dest_folder}}/index.html mode=0555
  notify:
    - Restart Nginx
...
```
---
#### Create own role "security"
##### Create new role
```bash
cd roles
ansible-galaxy init security
```
##### Create banner
```bash
nano security/files/banner
```

```bash
***************************************************
This server is protected ! 
***************************************************
```
##### Add handler for role
```bash
nano security/handlers/main.yml
```

```YAML
---
# handlers file for security
- name: Restart sshd
  service: name=sshd state=restarted
...
```
##### Add task for role
```bash
nano security/tasks/main.yml
```

```YAML
---
# tasks file for security
- name: Copy banner
  copy: src=banner dest=/etc/ssh/

- name: Setup config
  lineinfile:
    dest: /etc/ssh/sshd_config
    line: 'Banner /etc/ssh/sshd_config'
  notify:
    - Restart sshd
...
```
---
#### Create roles playbook
```bash
nano /roles/roles.yml
```

```YAML
---
- name: Setup web servers
  hosts: web
  become: yes

  roles:
    - common
    - webserver
    - security

- name: Setup db servers
  hosts: db
  become: yes

  roles:
    - common
    - security
...
```

#### Create and start playbook
```bash
ansible-playbook roles.yml
```
---
