/*(по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
 * Поля from, to и label содержат английские названия городов, поле name — русское. 
 * Выведите список рейсов flights с русскими названиями городов.*/

drop database if exists airport;

create database airport;

use airport;

drop table if exists flights;

create table flights (id SERIAL PRIMARY KEY, from_city varchar(255), to_city varchar (255));

drop table if exists cities;

create table cities (lable varchar(255), name varchar (255));

insert into flights values (null, 'moscow', 'omsk'),(null, 'novgorod', 'kazan'), (null, 'irkutsk', 'moscow'),(null, 'omsk', 'irkutsk') ;

insert into cities values ('moscow', 'Москва'), ('omsk', 'омск'),('novgorod', 'новгород'),('irkutsk', 'иркутск'),('kazan', 'казань');

select origins.*, cities. name as destination 
from (select flights.*, cities.name as origin from flights left join cities on flights.from_city=cities.lable) as origins 
left join cities on origins.to_city=cities.lable 
order by origins.id;

