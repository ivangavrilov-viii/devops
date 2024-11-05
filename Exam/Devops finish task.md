# ***Exam task***

## [[DevOps]]


## Created by [Ivan Gavrilov](https://github.com/ivangavrilov-viii)
---
## Summary of Content:
This section describes


---
## Useful links:
[Yandex CLI](https://yandex.cloud/ru/docs/cli/quickstart#linux_1)


## Content:
---
### Exam
![[Cert_task.pdf]]

---
### Steps
#### Set Jenkins
```bash
sudo su 
apt update && apt install docker.io -y
```

Install docker container Jenkins
```bash
docker run -d -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 --restart=on-failure jenkins/jenkins:lts-jdk17
```

Search container_id for Jenkins
```bash
docker ps
```

Copy auth-code for Jenkins from logs
```bash
docker logs container_id 
```
---
#### Install and set Terraform
```bash
sudo su
apt update && apt install unzip docker.io -y
ssh-keygen
nano ~/.terraformrc
```

```bash
provider_installation {
  network_mirror {
    url = "https://terraform-mirror.yandexcloud.net/"
    include = ["registry.terraform.io/*/*"]
  }
  direct {
    exclude = ["registry.terraform.io/*/*"]
  }
}
```

```bash
wget https://hashicorp-releases.yandexcloud.net/terraform/1.9.8/terraform_1.9.8_linux_amd64.zip
unzip terraform_1.9.8_linux_amd64.zip
cp terraform /bin
terraform --version
rm -r terraform_1.9.8_linux_amd64.zip
```
---
#### Set Yandex CLI
```bash
curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
reboot
```

```bash
yc init
```

```bash
yc --version
yc config list
```

Copy ids from console and paste in terraform config
```
token: y0_AgAAAAB54exEAATuwQAAAAEXRsfOAABWw5QKHNdGEY_CtLQO0xkH_6HYQA
cloud-id: b1g3d3ees15oi60u0ls7
folder-id: b1grpt9mrfqpvsmui4ap
compute-default-zone: ru-central1-b
```

```bash
yc compute image list
```

Copy image id for disk and paste in terraform config
```bash
+----------------------+------+--------+----------------------+--------+
|          ID          | NAME | FAMILY |     PRODUCT IDS      | STATUS |
+----------------------+------+--------+----------------------+--------+
| fd86l9ph4mtm13ses76m | test |        | f2e9thvmcgppt3301eau | READY  |
+----------------------+------+--------+----------------------+--------+
```
---



