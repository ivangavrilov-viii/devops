# ***Terraform. Infrastructure as a code***

## [[DevOps]]


## Created by [Ivan Gavrilov](https://github.com/ivangavrilov-viii)
---
## Summary of Content:
This section describes


---
## Useful links:
[Puzzle project](https://github.com/venkaDaria/puzzle15)
[Terra](https://github.com/dkgnim/terraform)
[Zoom](https://us06web.zoom.us/rec/share/Lhw95u6joo5ZoRoBPz0EB_dh_eUgwcildZpV5U2AqnjCkL04_Zquvi60LjXlb2OO.nK7-R-a1eLDAeVBe) Code: ```K*fb5n7P```

## Content:
---

---
### Report
![[GMT20241024-174201_Recording_1280x1024.mp4]]

---
### Homework
![[homework_14.pdf]]

---
### Lesson steps

#### 1. Install Docker
```bash
apt update && apt install unzip docker.io -y
```
---
#### 2. Set a mirror for download terraform
```bash
nano ~/.terraformrc
```

```bash
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
---
#### 3. Install terraform from git rep
```
git clone https://github.com/dkgnim/terraform.git
cd terraform
unzip terraform_1.7.0_linux_amd64.zip
cp terraform /bin
terraform --version
```
---
#### 4. Install docker in terraform
```
mkdir terraforms
nano config.tf
```

```
terraform {
	required_providers {
		docker = {
			source = "kreuzwerker/docker"
			version = "3.0.2"
		}
	}
}

provider "docker " {
	host = "unix:///var/run/docker.sock"
}

resource "docker_container" "foo" {
	image = docker_image.nginx.image_id
	name = "foo"
	ports {
		internal = 80
		external = 80
	}
}

resource "docker_image" "nginx" {
	name = "nginx:latest"
}
```
---
#### 5. Start terraform
```bash
terraform init
terraform plan
terraform apply
terraform show
terraform destroy
```


