# ***Create ansible roles and build Java app in production server***

## [[DevOps]]


## Created by [Ivan Gavrilov](https://github.com/ivangavrilov-viii)
---
## Useful links:
[Ansible Vars](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_variables.html#playbooks-variables)



## TASK:
---
> Write Ansible roles that prepare build and prod environments on 2 nodes. On the build node the project is built, on the prod node the project is launched.

## Steps in master server
---
### Clone repository from git
```bash
git clone https://github.com/ivangavrilov-viii/devops.git
```
### Move homework_app folder from repo
```bash
mv devops/Lesson_9/homework_app/ .
cd homework_app
```
### Start playbook
```bash
ansible-playbook roles.yml
```
---
## Solution
---
### Create "roles" folder
```bash
mkdir roles
cd roles
```
### Create role "builder"
```bash
ansible-galaxy init builder
```
### Add vars for role "builder"
```bash
nano builder/vars/main.yml
```

```YAML
---
# vars file for builder
app_dest: /app
repo_url: https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
```
### Create tasks for role "builder"
```bash
nano builder/tasks/main.yml
```

```YAML
---
# tasks file for builder
- name: Install packages
  apt: name={{item}} state=present
  with_items:
    - maven
    - default-jdk
    - git

- name: Clone project from repo
  git:
    repo: {{ repo_url }}
    dest: {{ app_dest }}
    version: master

- name: Build app using Maven
  command: mvn package
  args:
    chdir: {{ app_dest }}
```
---
### Create role "production"
```bash
ansible-galaxy init production
```
### Add vars for role "production"
```bash
nano production/vars/main.yml
```

```YAML
---
# vars file for production
remote_src: /app/target/hello-1.0.war
local_dest: /var/lib/tomcat9/webapps
```
### Add handler for role "production"
```bash
nano production/handlers/main.yml
```

```YAML
---
# handlers file for production
- name: Restart Tomcat
  service: name=tomcat9 state=restarted
```
### Add tasks for role "production"
```bash
nano production/tasks/main.yml
```

```YAML
---
# tasks file for production
- name: Ensure tomcat9 packages are present
  apt: name=tomcat9 state=present

- name: Copy .war from build server
  synchronize:
    src: {{ remote_src }}
    dest: {{ local_dest }}
  delegate_to: build
  notify:
    - Restart Tomcat
```
---
### Create roles playbook
```bash
nano roles.yml
```

```YAML
---
- name: Setup build server
  hosts: build
  become: yes
  vars:  
    ansible_python_interpreter: /usr/bin/python3
  
  roles:
    - builder

- name: Setup prod servers
  hosts: production
  become: yes
  vars:  
    ansible_python_interpreter: /usr/bin/python3
    
  roles:
    - production
```
---
### Start playbook
```bash
ansible-playbook roles.yml
```
---


