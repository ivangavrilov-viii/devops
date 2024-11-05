terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.131.0"
    }
  }
}

provider "yandex" {
  token     = "y0_AgAAAAB54exEAATuwQAAAAEXRsfOAABWw5QKHNdGEY_CtLQO0xkH_6HYQA"
  cloud_id  = "b1g3d3ees15oi60u0ls7"
  folder_id = "b1grpt9mrfqpvsmui4ap"
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
      image_id = "fd86l9ph4mtm13ses76m"
      size     = 65
      type     = "network-ssd"
    }
  }

  network_interface {
    index     = 1
    subnet_id = yandex_vpc_subnet.foo.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "prod-machine" {
  name        = "prod-machine"
  platform_id = "standard-v1"
  zone        = "ru-central1-b"

  boot_disk {
    initialize_params {
      image_id = "fd86l9ph4mtm13ses76m"
      size     = 65
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
    nat       = true
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
