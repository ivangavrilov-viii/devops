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
nano config.txt
```

```
#cloud-config
users:
  - name: root
    groups: sudo
    shell: /bin/bash
    sudo: 'ALL=(ALL) NOPASSWD:ALL'
    ssh_authorized_keys:
      - sh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDEX7jjXg5XPuqm4p1+5//6LnI5BYdro3VKyGs2Z3Nz5mjC5skl3AlRSfuaj0jogU2qCDfEqXuQmXFU02QLbMaHDx7a+IWg63qP0L27/5Vpa9DOAxrzlJRYOg6Zp7Bb1aQLWdVee147Ef4m3PQma6aTlfvpgWVC65z0H3epP3EcQDtxgPjpk3Ba0OH5JFmIWBnrWCr0EqthnJodfkEVtHp28X3NPm+EiU1lLgVgPkc5/wByxrlrdA5eM3HMPv10avucbB9HLuydJ9lbVN5TIK1JFGsEDPd8RdXm4to6u3R2BF7ijXYPF0uo8Go6Rv/uy8COmKQcs+PHyF5X6Bg0fR0TyNN8bYUq/CAyf4c1fZiQomziB7/TgXaqO/b+/apL+3jAko7aeC6weClSk1sUXqf19Xkp5Kd6aFHm953wMqpZ/JvETc1V6d3HP1uubQ2LufQPtF0mCjo4/f1BO+HxbP0l2rYYkQW7LCIsKqZNbKB26Vf10FbwGRDWbTLVHQJWfck= root@build
```

```
terraform init
terraform validate
terraform apply
```
---