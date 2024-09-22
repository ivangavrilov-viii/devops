# ***Base info about database***

## [[DevOps]]


## Created by [Ivan Gavrilov](https://github.com/ivangavrilov-viii)
---
## Summary of Content:
This section describes


---
## Useful links:
[[PostgreSQL.pdf|PostgreSQL commands]]
[[postgresql_internals-14.pdf|PostgreSQL 14 – книга]]
[[postgresql-v517.pdf|PostgreSQL – масштабирование]]
[Test Database](https://github.com/pthom/northwind_psql)
[Postgres 12 – Courses and Documentation](https://postgrespro.ru/docs/postgresql/12/)



## Content:
---
> Транзакция - группа последовательных операций с БД, которая представляет собой логическую единицу работы с данными



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
CREATE USER user1 WITH PASSWORD 'gavril_23';
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
sud su postgres
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

> Создание дампа всей системы 
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

Запуск утилиты
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

