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


## Additional
---
