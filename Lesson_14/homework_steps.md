# ***Homework task***

## [[DevOps]]


## Created by [Ivan Gavrilov](https://github.com/ivangavrilov-viii)
---
## Useful links:
[Yandex CLI](https://yandex.cloud/ru/docs/cli/quickstart#linux_1)


## TASK:
---
> С помощью Terraform поднять 2 гнстанса в облаке. «Сборочный» инстанс собирает Java приложение. «Продовый» инстанс запускает приложение. В качестве репозитория использовать нативный сервис облачного провайдера.

## Solution
---
#### Install terraform and create ssh-key
```bash
sudo su
apt update && apt install unzip docker.io -y
ssh-keygen
nano ~/.terraformrc
```

```nano
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
#### Install Yandex CLI
```bash
curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
reboot
```

Init with Yandex cloud token
```bash
yc init
```

```bash
yc --version
yc config list
yc compute image list
```
---
#### Start terraform
```bash
terraform init
terraform validate
terraform apply
terraform destroy
```
---
