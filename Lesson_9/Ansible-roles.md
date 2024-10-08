# ***DESCRIPTION***

## [[DevOps]]


## Created by [Ivan Gavrilov](https://github.com/ivangavrilov-viii)
---
## Summary of Content:
This section describes


---
## Useful links:
[Zoom](https://us06web.zoom.us/rec/share/WEYt90GHH2Fh-gppcKAql3PvwpxBw8sFiFrgfDSy4ME_WPn-K18n2qYnUyITN19U.hI-np3fTlNkli-S7) Access code: ```4YJ&fV*F```
[[Запускаем Ansible|Ansible Book]]


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
#### Stop watching at 40 minutes
