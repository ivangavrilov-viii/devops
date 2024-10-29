terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.131.0"
    }
  }
}

# cmd: yc config list - copy from
provider "yandex" {
  token     = "API_TOKEN"
  cloud_id  = "CLOUD_ID"
  folder_id = "FOLDER_ID"
  zone      = "NETWORK_ZONE"
}

resource "yandex_compute_instance" "test" {
  name        = "test"
  platform_id = "standard-v1"
  zone        = "NETWORK_ZONE"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "DISK_IMAGE_ID"        # ID образа для загрузочного диска
      size     = 65                     # Размер диска в ГБ
      type     = "network-ssd"
    }
  }

  network_interface {
    index     = 1
    subnet_id = yandex_vpc_subnet.foo.id
    nat       = true                    # Эта строка разрешает присвоение публичного IP-адреса
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
  value = yandex_compute_instance.test.network_interface.0.nat_ip_address
}