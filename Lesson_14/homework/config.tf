terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.131.0"
    }
  }
}

provider "yandex" {
  token     = "y0_AgAAAABox0RxAATuwQAAAAEWPLPRAAD3Qlb-df5NS5We-ke0zPZsCYNajg"
  cloud_id  = "b1gt1ccagp0jtpemjero"
  folder_id = "b1gb34lf7n5tljljhr8m"
  zone      = "ru-central1-b"
}

resource "yandex_compute_instance" "build-machine" {
  name        = "build-machine"
  platform_id = "standard-v1"
  zone        = "ru-central1-b"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd87i1kfq2iv96be358f"  # ID образа для загрузочного диска
      size     = 35                      # Размер диска в ГБ
      type     = "network-ssd"
    }
  }

  network_interface {
    index     = 1
    subnet_id = yandex_vpc_subnet.foo.id
    nat       = true # Эта строка разрешает присвоение публичного IP-адреса
  }

  metadata = {
    user-data = "${file("/home/ivan/config.txt")}"
  }

  provisioner "remote-exec" {
    inline = [
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
      user     = "root"
      private_key = file("~/.ssh/id_rsa")
    }
  }
}

resource "yandex_compute_instance" "prod-machine" {
  name        = "prod-machine"
  platform_id = "standard-v1"
  zone        = "ru-central1-b"

  boot_disk {
    initialize_params {
      image_id = "fd87i1kfq2iv96be358f"  # ID образа для загрузочного диска
      size     = 35                      # Размер диска в ГБ
      type     = "network-ssd"
    }
  }

  resources {
    cores  = 2
    memory = 2
  }

  network_interface {
    index     = 2
    subnet_id = yandex_vpc_subnet.foo.id
    nat       = true # Эта строка разрешает присвоение публичного IP-адреса
  }

  metadata = {
    user-data = "${file("/home/ivan/config.txt")}"
  }
}

resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "foo" {
  name           = "foo"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.5.0.0/24"]
}

output "build_machine_ip" {
  value = yandex_compute_instance.build-machine.network_interface.0.nat_ip_address
}

output "prod_machine_ip" {
  value = yandex_compute_instance.prod-machine.network_interface.0.nat_ip_address
}