terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.131.0"
    }
  }
}

provider "yandex" {
  token     = "y0_AgAAAABlNEnMAATuwQAAAAEWR91KAADSoqOlDmpGZKHWwLRIsv5ozCv15Q"
  cloud_id  = "b1gtjgth71n4h3sit5kf"
  folder_id = "b1geo1bhheiifpunotk4"
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
      image_id = "fd83o04luhqgqs7ul2l4"  # ID образа для загрузочного диска
      size     = 60                     # Размер диска в ГБ
      type     = "network-ssd"
    }
  }

  network_interface {
    index     = 1
    subnet_id = yandex_vpc_subnet.foo.id
    nat       = true # Эта строка разрешает присвоение публичного IP-адреса
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  provisioner "remote-exec" {
    inline = [
      "apt update && apt install docker.io git -y",
      "git clone https://github.com/ivangavrilov-viii/devops.git /",
    ]

    connection {
      type     = "ssh"
      host     = self.network_interface.0.nat_ip_address
      user     = "ubuntu"
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
      image_id = "fd83o04luhqgqs7ul2l4"  # ID образа для загрузочного диска
      size     = 60                      # Размер диска в ГБ
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
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
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