terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.131.0"
    }
  }
}

provider "yandex" {
  token     = "TOKEN"
  cloud_id  = "ID"
  folder_id = "ID"
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
      size     = 65                     # Размер диска в ГБ
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
      "sudo apt update && sudo apt install docker.io git -y",
      "sudo git clone https://github.com/ivangavrilov-viii/devops.git /devops",
      "cd /devops/Lesson_14/homework/build",
      "sudo docker build -t test .",
      "sudo docker run -d --name=test test",
      "sudo docker cp test:/app/target/hello-1.0.war /devops/Lesson_14/homework/prod/app.war",
      "cd /devops/Lesson_14/homework/prod",
      "sudo docker build -t prod .",
      "sudo docker run -d -p 8080:8080 --name=prod prod",
      "sudo docker image tag prod USERNAME/boxfuse",
      "sudo docker login -u USERNAME -p PASSWORD",
      "sudo docker push USERNAME/boxfuse",
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
  depends_on = [yandex_compute_instance.build-machine]

  boot_disk {
    initialize_params {
      image_id = "fd83o04luhqgqs7ul2l4"  # ID образа для загрузочного диска
      size     = 65                      # Размер диска в ГБ
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


  provisioner "remote-exec" {
    inline = [
      "sudo apt update && sudo apt install docker.io",
      "sudo docker pull USERNAME/boxfuse",
      "sudo docker run -d -p 8080:8080 USERNAME/boxfuse",
    ]

    connection {
      type     = "ssh"
      host     = self.network_interface.0.nat_ip_address
      user     = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
    }
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