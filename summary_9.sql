# Вывести количество заказов по числам месяца.
SELECT EXTRACT(DAY FROM ODATE) AS DAY,
       COUNT(*) AS ORDERS_AMOUNT
FROM ORDERS
GROUP BY DAY;

# Вывести количество заказов по дням недели.
SELECT DAYNAME(ODATE) AS `WEEKDAY`,
       COUNT(*) AS ORDERS_AMOUNT
FROM ORDERS
GROUP BY `WEEKDAY`;

# Вывести количество дней, которые работают сотрудники с момента найма.
USE hr;
SELECT first_name, last_name, DATEDIFF(NOW(), hire_date)  AS days_emoployment
FROM employees;

# Вывести количество лет, которые проработал каждый сотрудник.
SELECT first_name, last_name, TIMESTAMPDIFF(YEAR, hire_date, NOW()) AS years_employment
FROM employees;

SELECT STR_TO_DATE('01.01.2023', '%d.%m.%Y')

# Выведите имена (поле member_name)
# и возраст для каждого человека из
# таблицы FamilyMembers, используя
# схему базы данных. Для вывода
# возраста используйте псевдоним age.

SELECT member_name, DATESTAMPDIFF(YEAR, fm.birthday, NOW()) AS age
FROM FamilyMembers fm;

# количество заказов за последнюю неделю
USE shop;
SELECT COUNT(*)
FROM ORDERS
WHERE ODATE BETWEEN NOW() - INTERVAL 1 WEEK AND NOW();

SELECT COUNT(*)
FROM ORDERS
WHERE ODATE BETWEEN SUBDATE(NOW(), INTERVAL 1 WEEK) AND NOW();

SELECT COUNT(*)
FROM ORDERS
WHERE ODATE BETWEEN DATE_ADD(NOW(), INTERVAL -1 WEEK) AND NOW();

# сотрудники, у которых годовщина трудоустройства в текущем месяце
USE hr;
SELECT first_name, last_name
FROM employees
WHERE MONTH(hire_date) = MONTH(NOW());

SELECT first_name, last_name
FROM employees
WHERE EXTRACT(MONTH FROM hire_date) = EXTRACT(MONTH FROM NOW());

# первый день текущего месяца
SELECT DATE_FORMAT(NOW(), '01.%m.%Y');

SELECT LAST_DAY(NOW() - INTERVAL 1 MONTH) + INTERVAL 1 DAY;

# дата следующего понедельника
SELECT NOW() + INTERVAL 7 - WEEKDAY(NOW()) DAY;