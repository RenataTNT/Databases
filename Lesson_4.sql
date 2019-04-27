/*����������� ������� ������� ������������� � ������� users
����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������. ������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������.
(�� �������) ����������� ������������ ����� � ������� ������� */

use shop;

select avg(to_days(now())-to_days(birthday_at))/365.25 as average_age from users;

select weekday(concat(year(now()),substring(birthday_at,5,6))) as week_day, count(id) as number_of_users from users group by week_day;

