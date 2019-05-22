/*Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs 
 * помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.
*/

use shop;

drop table if exists logs;
create table logs(
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	table_name varchar(255),
	record_key int,
	record_name varchar(255)) Engine=ARCHIVE;

delimiter //

drop trigger if exists on_insert_users//
create trigger on_insert_users after insert on users
for each row
begin
	insert into logs(table_name, record_key, record_name) values ('users',new.id,new.name);
end//

insert into users(name, birthday_at) values ('Boris','1984-08-10'),('Marina','1979-05-11'), ('Darya','2015-04-12'), ('Vasya','1984-08-10'), ('Oleg','1979-05-11')//

drop trigger if exists on_insert_catalogs//
create trigger on_insert_catalogs after insert on catalogs
for each row
begin
	insert into logs(table_name, record_key, record_name) values ('catalogs',new.id,new.name);
end//


-- insert into catalogs(name) values ('HD'),('SD')//

drop trigger if exists on_insert_products//
create trigger on_insert_products after insert on products
for each row
begin
	insert into logs(table_name, record_key, record_name) values ('products',new.id,new.name);
end//

insert into products(name) values ('Asus HD'),('Asus SD')//

delimiter ;



/*(по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.*/

/*drop trigger if exists on_insert_users;

truncate table users;

 SHOW VARIABLES LIKE "secure_file_priv";
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users.csv'
into table users
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY 'n'
IGNORE 1 rows
(name,@birthday_at)
SET birthday_at = STR_TO_DATE(@birthday_at, '%m/%d/%Y');*/
