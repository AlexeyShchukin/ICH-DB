USE hr;

SELECT * FROM employees
WHERE hire_date >= '2005-01-01'
AND hire_date < '2006-01-01';

SELECT * FROM employees
WHERE DATE_FORMAT(hire_date, '%Y') = 2005;


USE shop;

SELECT AVG(AMT) AS avg_amount
FROM ORDERS
WHERE DATE_FORMAT(ODATE, '%Y') = 2022;

SELECT AVG(AMT) AS avg_amount
FROM ORDERS
WHERE ODATE >= STR_TO_DATE('01:01:2022', '%d:%m:%Y')
AND ODATE < STR_TO_DATE('01:01:2023', '%d:%m:%Y');

SELECT AVG(AMT) AS avg_amount,
       AVG(
               CASE
                   WHEN DATE_FORMAT(ODATE, '%Y') = 2022 THEN AMT
                   END
       ) AS avg_2022
FROM ORDERS;


USE hr;
SELECT * FROM employees
WHERE WEEKDAY(hire_date) = 4;

SELECT DATE_FORMAT(t1.end_date, '%d') AS end_date_day,
       count(*) AS cnt_emp FROM
                               (SELECT first_name,
                                       last_name,
                                       hire_date,
                                       LAST_DAY(hire_date) + INTERVAL 1 DAY + INTERVAL 3 MONTH AS end_date
                                FROM employees) t1
GROUP BY DATE_FORMAT(t1.end_date, '%d');

# месяц, в котором было больше всего наймов

with info as (SELECT EXTRACT(MONTH FROM e.hire_date) AS month,
            COUNT(*) cnt_hire
FROM employees e
GROUP BY month)
SELECT month FROM info
WHERE cnt_hire = (SELECT MAX(cnt_hire) FROM info);


SELECT t.month
FROM
    (
    SELECT EXTRACT(MONTH FROM e.hire_date) AS month,
            COUNT(*) cnt_hire
FROM employees e
GROUP BY month) t
WHERE cnt_hire =  (SELECT MAX(t.cnt_hire) as max_hire
FROM
    (
    SELECT EXTRACT(MONTH FROM e.hire_date) AS month,
            COUNT(*) cnt_hire
FROM employees e
GROUP BY month) t)

# количество заказов по месяцам
USE shop;

SELECT EXTRACT(MONTH FROM ODATE) AS `MONTH`,
       COUNT(ORDER_ID) AS CNT_ORDERS
FROM ORDERS
GROUP BY MONTH;

# кол-во заказов в марте
SELECT COUNT(*) AS CNT_ORDERS
FROM ORDERS
WHERE EXTRACT(MONTH FROM ODATE) = 3;

SELECT ORDER_ID, EXTRACT(YEAR FROM ODATE) AS YEAR FROM ORDERS;

# Выведите список заказов (номер заказа, название месяца)

SELECT ORDER_ID,
       DATE_FORMAT(ODATE, '%M') AS `MONTH`
FROM ORDERS;

# Выведите количество заказов по месяцам (название месяца, количество
# заказов)

SELECT MONTHNAME(ODATE) AS `MONTH`, COUNT(*) AS ORDERS_AMOUNT
FROM ORDERS
GROUP BY `MONTH`;

# Определить какие из покупок были совершены в интервале от 10 апреля 2022 до 10 мая 2022 года
SELECT *
FROM ORDERS
WHERE ODATE BETWEEN '2022-04-10' AND '2022-05-10';

# Напишите SQL-запрос для анализа покупок, совершенных в июне, и определите количество
# покупок для каждого продавца. Результат запроса должен содержать идентификатор
# продавца и количество покупок, сделанных им в июне.
SELECT SELL_ID, COUNT(
                CASE
                    WHEN EXTRACT(MONTH FROM ODATE) = 6 THEN ORDER_ID
                END
                ) JUNE_ORDERS
FROM ORDERS
GROUP BY SELL_ID;

# Напишите SQL-запрос для анализа средней стоимости покупок, совершенных в марте, и
# определите, какие продавцы имеют самую высокую и самую низкую среднюю стоимость
# покупок в этом месяце. Обязательно выведите имя продавца.

WITH MO AS (SELECT S.SNAME, AVG(O.AMT) AVG_AMOUNT
FROM ORDERS O
JOIN SELLERS S
ON S.SELL_ID = O.SELL_ID
WHERE EXTRACT(MONTH FROM ODATE) = 3
GROUP BY S.SNAME)
SELECT (SELECT MO.SNAME FROM MO
WHERE MO.AVG_AMOUNT = (SELECT MAX(MO.AVG_AMOUNT) FROM MO)) AS top_seller,
    (SELECT MO.SNAME FROM MO
WHERE MO.AVG_AMOUNT = (SELECT MIN(MO.AVG_AMOUNT) FROM MO)) AS low_seller;

# Напишите SQL-запрос для анализа покупок, совершенных во вторник, и предоставьте
# информацию о каждом заказе, включая сумму, дату, имя покупателя и имя продавца.
SELECT O.ODATE, O.AMT, S.SNAME, C.CNAME
FROM SELLERS S
RIGHT JOIN ORDERS O
ON S.SELL_ID = O.SELL_ID
LEFT JOIN CUSTOMERS C
ON O.CUST_ID = C.CUST_ID
WHERE WEEKDAY(O.ODATE) = 1;

# Определить, сколько покупок было совершено в каждый месяц. Отсортировать строки в
# порядке возрастания количества покупок. Вывести два поля - номер месяца и количество
# покупок
SELECT EXTRACT(MONTH FROM O.ODATE) AS `MONTH`,
       COUNT(O.ORDER_ID) AS ORDERS_AMOUNT
FROM ORDERS O
GROUP BY `MONTH`
ORDER BY ORDERS_AMOUNT;

# Необходимо определить, в какой месяц было совершено больше всего покупок. Вывести
# два поля - номер месяца и количество покупок.
WITH MA AS (SELECT EXTRACT(MONTH FROM O.ODATE) AS `MONTH`,
       COUNT(O.ORDER_ID) AS ORDERS_AMOUNT
FROM ORDERS O
GROUP BY `MONTH`)
SELECT MA.`MONTH`, MA.ORDERS_AMOUNT
FROM MA
WHERE MA.ORDERS_AMOUNT = (SELECT MAX(MA.ORDERS_AMOUNT) FROM MA);

# Вывести сегодняшнюю дату в формате: день недели, число, месяц, год.
SELECT DATE_FORMAT(NOW(), '%W, %d.%M.%Y');

# Вывести на какой день недели приходится 1 января 2024 года.
SELECT DAYNAME('2024.01.01');

# Вывести, на какой день недели приходится число, через 10 дней после.
SELECT DATE_FORMAT(NOW() + INTERVAL 10 DAY, '%W');

# Вывести дату, которая будет через 10 дней после последнего дня текущего месяца.
SELECT DATE_FORMAT(LAST_DAY(NOW()) + INTERVAL 10 DAY, '%d.%m.%Y');

# Вывести день недели даты из предыдущей задачи.
SELECT DATE_FORMAT(LAST_DAY(NOW()) + INTERVAL 10 DAY, '%W');

# Вывести название месяца, который будет через 5 месяцев после текущего.
SELECT DATE_FORMAT(NOW() + INTERVAL 5 MONTH, '%M');

