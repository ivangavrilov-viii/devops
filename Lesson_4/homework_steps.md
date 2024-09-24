# ***Homework task***

## [[DevOps]]


## Created by [Ivan Gavrilov](https://github.com/ivangavrilov-viii)
---
## Useful links:
[Глава 19.6. Репликация](https://postgrespro.ru/docs/postgresql/12/runtime-config-replication)
[Глава 26. Отказоустойчивость, балансировка нагрузки и репликация](https://postgrespro.ru/docs/postgresql/12/warm-standby-failover)


## TASK:
---
> Set the 3rd Postgresql replica with a time delay. Simulate the failure of the master node. Turn the slave node into a master node.

## Solution
---
### 1. Настройка базы данных и конфигурация:
- Установка PostgreSQL на третьем сервере.
```
sudo su
apt update
apt install postgresql
```
- Настройка файла конфигурации postgresql.conf для реплики:
```
nano /etc/postgresql/12/main/postgresql.conf
```
- Добавляем параметр recovery_min_apply_delay для отставания по времени:
```
recovery_min_apply_delay = '1min'
```
---
### 2. Настройка мастер сервера:
- Настройка файла pg_hba.conf
```
nano /etc/postgresql/12/main/pg_hba.conf
```
- Добавить в раздел репликаций в конце файла
```
host    all             all             158.160.8.210/32        md5
host    replication     postgres        158.160.8.210/32        md5
```
- Перезапуск postgresql
```
systemctl restart postgresql
ss -tupln
```
---
### 3. Создание slave-реплики:
- На сервере 3-ей реплики удалим содержимое /var/lib/postgresql/12/:
```
cd /var/lib/postgresql/12/
rm -rf main/*
```
- Создание репликации
```
su postgres
pg_basebackup -P -R -X stream -c fast -h 51.250.20.181 -U postgres -D ./main
```
- Перезапуск postgresql
```
systemctl restart postgresql
ss -tupln
```
---
### 4. Имитация падения master-ноды
- Остановим postgresql на master сервере
```
systemctl stop postgresql
```
- Проверка статуса работы postgres на master-сервере
```
systemctl status postgresql
ss -tupln
```
---
### 5.  Превращение slave-ноды в master-ноду
- Завершить режим ожидания и начать операции чтения-записи (команда работает с 13 версии postgresql)
```
pg_ctl promote [-D datadir] [-W] [-t seconds] [-s]
```
- В нашем случае с 12 версией:
```
pg_ctlcluster 12 main promote
```
- Перезапуск postgresql
```
systemctl restart postgresql
ss -tupln
```
---
### 6. Настройка других репликаций и подключение к новой master-ноде
- Настройка файлов на мастер-ноде:
```
nano /etc/postgresql/12/main/postgresql.conf
nano /etc/postgresql/12/main/pg_hba.conf
```
- Добавить в раздел репликаций в конце файла pg_hba.conf
```
host    all             all             158.160.8.210/32        md5
host    replication     postgres        158.160.8.210/32        md5
```
- Перезапуск postgresql
```
systemctl restart postgresql
ss -tupln
```
- Возвращаемся к пункту 3 для поднятия реплики относительно новой мастер-ноды c новым IP.
- Затем проверяем синхронизацию данных с задержкой
---
### Файл с логами для postgresql
```
nano /var/log/postgresql...
```
> Содержит информацию об ошибках при работе с postgresql
---
