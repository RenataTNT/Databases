/*В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
 * Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции. */




drop database if exists sample;
create database sample;
use sample;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  birthday_at DATE ,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
  
insert into users (name, birthday_at) values ('Ruslan','1982-08-05'), ('Anna','1985-09-06');

start transaction;

insert into sample.users (name, birthday_at) select shop.users.name, shop.users.birthday_at from shop.users where shop.users.id=1;
delete from shop.users where id=1; 

commit;

/* Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.*/

use shop;

drop view if exists prod;
create view prod as select products.name as product, catalogs.name as cat from products left join catalogs on products.catalog_id=catalogs.id;

/*по желанию) Пусть имеется таблица с календарным полем created_at. 
 * В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. 
 * Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.
 */
 
use sample;

drop table if exists August;

create table August (calendar_date date);

truncate August;

insert into August values ('2018-08-01'),('2018-08-04'),('2018-08-16'),('2018-08-17');



set @day_n:='2018-08-01';

drop table if exists dates;
create table dates (n int, d date, flag int);
insert into dates (n) values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),(21),(22),(23),(24),(25),(26),(27),(28),(29),(30),(31);
update dates set d= @day_n+interval n-1 day;
update dates set flag=0;


drop temporary table if exists temp;
create temporary table temp (d date, calendar_date date, flag int);
insert into temp select dates.d, August.*, dates.flag from dates left join August on dates.d=August.calendar_date;

update  temp set flag=1 where d=calendar_date; 

select d, flag from temp order by d;



