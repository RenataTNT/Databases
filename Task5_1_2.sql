-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

use shop;

truncate users;
insert into users (name, birthday_at) values ('Rita','1984-08-10'), ('Marina','1979-05-11'), ('Darya','2015-04-12'), ('Vasya','1984-08-10'), ('Oleg','1979-05-11'), ('Sasha','2015-04-12');

insert into orders (user_id) values(1),(2),(1),(1),(2),(3);


select * from 
	(select users.id, users.name, count(orders.id) as n_orders from users left join orders on users.id=orders.user_id group by orders.user_id) as temp2
where n_orders>0;

-- Выведите список товаров products и разделов catalogs, который соответствует товару.

truncate catalogs;
insert into catalogs (name)
  values ('Headphones'), ('Routers'),('web-cameras'),('Processors'),('Displays');

insert into products (name, desription, price, catalog_id) values
  ('Apple Airpods v1.1','Wireless headphones 2017', 12000, 1),
  ('Apple Airpods v1.2','Wireless headphones 2018',13000.00, 1),
  ('Apple Airpods v1.3','Wireless headphones 2019',14000.00, 1),
  ('ASUS N520','Router 5G',4000, 2),
  ('DLINK 1008','Router 5G',3000, 2),
  ('HP-1213','Wireless webcam',3500, 3),
  ('Samsung LCD 2019','Display 1200-1200 pixels',30000, 4);
  
  select products.*, catalogs.name from products left join catalogs on products.catalog_id=catalogs.id;