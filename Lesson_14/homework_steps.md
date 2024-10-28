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
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDZMMX166jUF2/3kFCPZqKuA0IVDS3fQVfEKcMLzREWdehgbZii8i5/fZab+fm8V4sLwJeH9MU9vyvEDQGLGUbbUDjd+AEtGIeYobc5DBboi9tyFoec0F53CbfhI/zLWMcqG0/07I3qQVGhELCJuQvGl5WRd5f78N5R+uObTMx0sxSpCqpWXIqZsJzvdX6lkh3XF6GFRLvAnAWA0zmgVWdPnXQTmjj4CbecDV092L3y8C/M2y+LXfWv9WfdWSGqC62VK3mgEvDhuYQT1CRSHuCMoeEyyTg5ih8VkEdYFcxu45W2pZTjsESgdwHBPZQLF6Z6Qrgz4Co8JabL83rThhR0u+na8FMDq3WbONwIe6j0oaYzuJZ2GfLCSjdr4XnWlGWp3BfIrvsIMMIv301FRRgZj+6a8x1I1GKQ6I8XnsMzvNtbHldTsRadqO1tsCZvisUWDKs+2gBK3GO9g2dJsxhznZsKMP1/KwFXOWhS9w9LXyJ5MdK6RvXsnjvE0FEvUQU= root@build
      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP3Jc4BFyNMULIM21hogbNlTOOun59f6rm6pRdgLVikw ivan@iMac-D21.local
```

```
provider "yandex" {
  token     = "<ВАШ_YANDEX_CLOUD_TOKEN>"
  cloud_id  = "<ВАШ_CLOUD_ID>"
  folder_id = "<ВАШ_FOLDER_ID>"
  zone      = "ru-central1-a"
}

resource "yandex_vpc_network" "my_network" {
  name = "my-network"
}

resource "yandex_vpc_subnet" "my_subnet" {
  name           = "my-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.my_network.id
  v4_cidr_blocks = ["10.0.0.0/24"]
}

resource "yandex_compute_instance" "build_machine" {
  name = "build-machine"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8cqtlsf4e05a7dqrvf" # Ubuntu 20.04 LTS
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.my_subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  provisioner "remote-exec" {
    inline = [
      # Устанавливаем необходимые пакеты на VM
      "sudo apt update",
      "sudo apt install -y openjdk-11-jdk maven git",
      
      # Клонируем репозиторий
      "git clone https://github.com/<ВАШ_ПРОЕКТ>.git /home/ubuntu/app",
      
      # Переходим в папку с проектом и выполняем сборку
      "cd /home/ubuntu/app",
      "mvn clean package"
    ]

    connection {
      type     = "ssh"
      host     = self.network_interface.0.nat_ip_address
      user     = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
    }
  }
}

output "build_machine_ip" {
  value = yandex_compute_instance.build_machine.network_interface.0.nat_ip_address
}

```
## Additional
---
