# ***Base info about database***

## [[DevOps]]


## Created by [Ivan Gavrilov](https://github.com/ivangavrilov-viii)
---
## Summary of Content:
This section describes the basic concepts of databases, the fundamental concepts of databases, the types of databases, and the concept of replication with practical implementation of creation and application in development. 


---
## Useful links:
[[PostgreSQL.pdf|PostgreSQL commands]]
[[postgresql_internals-14.pdf|PostgreSQL 14 – книга]]
[[postgresql-v517.pdf|PostgreSQL – масштабирование]]
[Test Database](https://github.com/pthom/northwind_psql)
[Postgres 12 – Courses and Documentation](https://postgrespro.ru/docs/postgresql/12/)
[pg_Tune](https://www.pgconfig.org/#/?max_connections=100&pg_version=16&environment_name=WEB&total_ram=4&cpus=2&drive_type=SSD&arch=x86-64&os_type=linux)


## Content:
---
> Транзакция - группа последовательных операций с БД, которая представляет собой логическую единицу работы с данными

> Репликация - одна их техник масштабирования БД, горизонтальное масштабирование БД, данные с одного сервера реплицируется, копируется на реплики. Виды репликаций: master-master, master-slave.

>pgBouncer - распределитель нагрузки коннектов к postgres 
---
### Report
![[devops4.pdf]]

---
### Homework
![[homework_4.pdf]]

---
### Commands

#### Start PostgreSQL
---
Установка PostgreSQL
```
sudo apt update
sudo apt install postgresql postgresql-contrib
```
Открывает командный интерпритатор PostgreSQL
```
sudo su postgres
psql
```
Список баз данных
```
\l
\l+
```
Список пользователей
```
\du
```
Создание пользователя
```
CREATE USER user1 WITH PASSWORD 'password';
```
Создание базы данных
```
CREATE DATABASE test1;
```
Выход из командного интерпритатора
```
\q
```
---
#### Install test DB
Установка GIT и клонирование тестовой базы данных
```
sudo apt install git
git clone https://github.com/pthom/northwind_psql.git
```
---
#### Import installed dump
Переключаемся на пользователя postgres
```
sudo su postgres
```

Импортируем dump
```
psql -d test1 -f northwind.sql
```
> -d  test1- аргумент для базы данных куда импортируем
> -f northwind.sql - файл дампа для испорта в БД

Проверяем установленный дамп
```
psql
\c test1
SELECT * FROM products;
\q
```
>\c - подключиться к БД (connect)
---
#### Creating own dump of test1 DB
Создание собственного дампа БД
```
pg_dump test1 > /tmp/db.sql
```

Создание дампа всей системы 
```
pg_damp all
```
> Аналог команды pg_dump - gzip
> Замедляет создание дампа, но сокращает занимаемое место
---
#### Monitor our instance
С помощью утилиты симулировать нагрузку на инстансе  БД 

Предварительная настройка для работы утилиты
```
nano etc/postgresql/12/main/pg_hba.conf
```
> В открытом файле конфигурации аутентификации предоставляем доступ к БД: везде меняет method на trust

Перезапускаем сервис postgresql
```
sudo systemctl restart postgresql
ss -tupln
sudo systemctl status postgresql
```

Переход под пользователя postgres
```
su postgres
cd /etc/postgresql/12/main/
```

Запуск подготовки утилиты
```
pgbench -h localhost -p 5432 -U postgres -i -s 100 test1
```
> -h localhost - host
> -p 5432 - port
> -U postgres - user
> -i -s - string amount to adding
> test1 - DB name
> 
> Команда инициализирует базу данных test1, создавая в ней необходимые таблицы и заполняя их тестовыми данными, масштабируемыми до уровня, определенного параметром -s. В данном случае размер данных будет достаточно большим (-s 100), что эквивалентно примерно 10 миллионам строк в основной таблице. После выполнения этой команды база данных будет готова для запуска тестов производительности с помощью pgbench.

Устанавливаем утилиту pg-activity
```
apt install pg-activity
su postgres
pg_activity
```

Запуск теста
```
pgbench -h localhost -p 5432 -U postgres -c 50 -j 2 -P 60 -T 600 test1
```
> -c 50 - clients
> -j 2 - amount of 
> -P - progress each 60 s
> -T 600 - work time
> test1 - DB name
---
#### Settings of replications
Запускаем 2-ю машину
```
sudo su
apt update 
```

Установка PostgreSQL
```
apt install postgresql
```
> Требования: версии postgresql на мастер БД и репликационной БД должны быть идентичны

```
nano /etc/postgresql/12/main/postgresql.conf
```

Настройка файла postgresql.conf
```
listen_addresses = '*'
wal_level = replica
wal_log_hints = on
max_wal_senders = 10
wal_keep_segments = 64
hot_standby = on
```

Настройка файла pg_hba.conf
```
nano /etc/postgresql/12/main/pg_hba.conf
```

Добавить в раздел репликаций в конце файла
```
host    all             all             slave_ip/32       md5
host    replication     postgres        slave_ip/32       md5
```

Перезапуск postgresql
```
systemctl restart postgresql
ss -tupln
```

Создаем пароль md5 для пользователя postgres
```
su postgres
psql
ALTER ROLE postgres PASSWORD 'password';
\q
```

> Физическая БД лежит:
```
/var/lib/postgresql/12/main/
```

На slave server удалим содержимое /var/lib/postgresql/12
```
cd /var/lib/postgresql/12/
rm -rf main/*
```

Настройка репликация из под сервера slave
```
pg_basebackup -P -R -X stream -c fast -h master_ip -U postgres -D ./main
```

Предоставление прав для пользователя postgres
```
chown -R postgres:postgres main/
```

Перезапуск postgresql
```
systemctl restart postgresql
systemctl status postgresql
```
---
