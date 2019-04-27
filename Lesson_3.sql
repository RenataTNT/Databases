/*1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
 * 
2.Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR 
и в них долгое время помещались значения в формате "20.10.2017 8:10". 
Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

3.В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, 
если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, 
чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.

4.(по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')
5.(по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.
*/






USE shop;

delete from users;


-- 1 Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
insert into users (name, birthday_at) values ('Renata','1984-08-10'), ('Maxim','1979-05-11'), ('Eugenia','2015-04-12');

update users set created_at=current_timestamp;
update users set updated_at=current_timestamp;

-- 2.Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR 
alter table users
modify created_at varchar(255);

delete from users;

insert into users (name, birthday_at, created_at) values ('Masha', '1982-12-03', '20.10.2017 8:10'), ('Misha', '1980-05-17','11.12.2015 7:36'), ('Olga','1986-08-15','17.01.2016 10:10');

update users set created_at=concat(substring(created_at,7,4),'-',substring(created_at,4,2),'-',substring(created_at,1,2),substring(created_at,11,5));

alter table users
modify created_at datetime default now();

-- 3.В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, ....

insert into storehouses_products (storehouse_id, product_id, value)  values 
	(1,1,50),
	(2,2,0),
	(3,1,37),
	(3,1,0),
	(3,1,22);

select * from storehouses_products order by if (value=0,true,false), value; 

-- 4.(по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')

select name, monthname(birthday_at) from users where month(birthday_at) in (5,8);

-- 5. Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2);

select * from catalogs where id in (5,1,2) order by field(id,5,1,2);
