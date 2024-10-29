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
#### Install terraform

```
apt update && apt install unzip docker.io -y
nano ~/.terraformrc
```

```
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

```
wget https://hashicorp-releases.yandexcloud.net/terraform/1.9.8/terraform_1.9.8_linux_amd64.zip
unzip terraform_1.9.8_linux_amd64.zip
cp terraform /bin
terraform --version
```
---
#### Generate ssh key in master server
```
ssh-keygen
```
---

```
terraform init
terraform validate
```

Создать образ диска

```
yc compute image list
```

Скопировать его image_id и вставить в config.tf
```
terraform init
terraform validate
```
## Additional
---
