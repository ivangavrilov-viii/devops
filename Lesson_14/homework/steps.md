```
sudo su
apt update && apt install unzip docker.io -y
ssh-keygen
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
```
curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
reboot
```

```
yc init
```

```
yc --version
```

```
yc config list
```

```
yc compute image list
```
---
```
terraform init
terraform validate
terraform apply
```
---