/*ѕодсчитайте средний возраст пользователей в таблице users
ѕодсчитайте количество дней рождени€, которые приход€тс€ на каждую из дней недели. —ледует учесть, что необходимы дни недели текущего года, а не года рождени€.
(по желанию) ѕодсчитайте произведение чисел в столбце таблицы */

use shop;

select avg(to_days(now())-to_days(birthday_at))/365.25 as average_age from users;

select weekday(concat(year(now()),substring(birthday_at,5,6))) as week_day, count(id) as number_of_users from users group by week_day;

