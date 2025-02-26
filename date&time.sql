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
GROUP BY `MONTH`

# Определить какие из покупок были совершены в интервале от 10 апреля 2022 до 10 мая 2022 года
SELECT *
FROM ORDERS
WHERE ODATE BETWEEN '2022-04-10' AND '2022-05-10';