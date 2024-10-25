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
### Report
![[GMT20241024-174201_Recording_1280x1024.mp4]]

---
### Homework
![[homework_14.pdf]]

---




