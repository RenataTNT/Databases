/*Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
с 18:00 до 00:00 — "Добрый вечер", 
с 00:00 до 6:00 — "Доброй ночи".*/

use shop;

delimiter //
drop function if exists hello//
create function hello(cur_time time)
returns varchar(255) deterministic
begin 
	if cur_time between '06:00:00' and '12:00:00' then 
		return 'Доброе утро!';
	elseif cur_time between '12:00:01' and '18:00:00' then
		return 'Добрый день!';
	elseif cur_time between '18:00:01' and '23:59:59' then
		return 'Добрый вечер!';
	else 
		return 'Доброй ночи!';
	end if;
end//

select current_time//

select hello(current_time)//
select hello('07:00:02')//
select hello('13:00:02')//
select hello('19:00:02')//
select hello('04:00:02')//

-- delimiter ;


/* В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
 * Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
 * Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
 * При попытке присвоить полям NULL-значение необходимо отменить операцию.*/

drop trigger if exists product_details//
create trigger product_details before update on products
for each row
begin
	if new.name is null and new.desription is null 
	then
		set new.name=old.name;
		set new.desription=old.desription;
	end if;
end//

insert into products(name, desription, price, catalog_id) values 
	('ASUS 111','Монитор LCD',25000.99,5),
	('HP 8590','Netbook 2019',65000.99,6)//

update products
	set desription=null where name='ASUS 111'//
	
update products
	set name=null where name='ASUS 111'//	

/*(по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
 * Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. 
 * Вызов функции FIBONACCI(10) должен возвращать число 55.*/


drop function if exists FIBONACCI//
create function FIBONACCI(value int)
returns int deterministic
begin
	
	set @f1:=0;
	set @f2:=1;
	if value=0 then
		set @fib:=0;	
	else
		set @n:=1;
		while @n<value DO
			set @fib:=@f1+@f2;
			set @f1:=@f2;
			set @f2:=@fib;
			set @n:=@n+1;
		end while;
	end if;
	return @fib;
end//

select FIBONACCI(10)//