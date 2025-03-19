-- Расчитать среднее количество заказов на одного покупателя в каждом городе
USE shop;

WITH c_cnt_order AS (SELECT CUST_ID, COUNT(*) cnt
                     FROM ORDERS
                     GROUP BY CUST_ID)
SELECT DISTINCT AVG(c_cnt_order.cnt) OVER (PARTITION BY c.CITY) cnt_o,
                c.CITY
FROM CUSTOMERS c
         JOIN c_cnt_order
              ON c_cnt_order.CUST_ID = c.CUST_ID;

-- Получить список покупателей и их общую сумму заказов, отсортированные по сумме заказов в убывающем порядке
SELECT DISTINCT C.CNAME,
                SUM(O.AMT) OVER (PARTITION BY C.CUST_ID) AS SUM_AMT
FROM CUSTOMERS C
         JOIN ORDERS O
              ON C.CUST_ID = O.CUST_ID
ORDER BY SUM_AMT DESC;

SELECT C.CNAME,
       SUM(O.AMT) OVER (PARTITION BY C.CUST_ID ORDER BY O.ODATE DESC) AS SUM_AMT
FROM CUSTOMERS C
         RIGHT JOIN ORDERS O
                    ON C.CUST_ID = O.CUST_ID;

-- Вычислить процентное соотношение общей суммы заказов каждого покупателя к общей сумме заказов в его городе
SELECT C.CNAME,
       C.CITY,
       ROUND(SUM(O.AMT) OVER (PARTITION BY C.CUST_ID) /
             SUM(O.AMT) OVER (PARTITION BY C.CITY) * 100, 2) AS REL_SUM_CUST_CITY
FROM CUSTOMERS C
         RIGHT JOIN ORDERS O
                    ON C.CUST_ID = O.CUST_ID;

-- Определить средний размер заказа для каждого продавца в сравнении со средним размером заказа по всем продавцам
SELECT s.SNAME,
       SUM(o.AMT) OVER (PARTITION BY o.SELL_ID) AS sum_SELL,
       SUM(o.AMT) OVER ()                       AS sum,
       ROUND(SUM(o.AMT) OVER (PARTITION BY o.SELL_ID) /
             SUM(o.AMT) OVER () * 100, 2)       AS REL_SUM_SELL
FROM ORDERS o
         LEFT JOIN SELLERS s ON s.SELL_ID = o.SELL_ID;

-- Вычислить процентное соотношение числа заказов для каждого покупателя к общему числу заказов в его городе
SELECT C.CNAME,
       C.CITY,
       ROUND(COUNT(O.ORDER_ID) OVER (PARTITION BY C.CUST_ID) /
             COUNT(O.ORDER_ID) OVER (PARTITION BY C.CITY) * 100, 2) AS REL_ORD_CUST_TO_CITY
FROM CUSTOMERS C
         RIGHT JOIN ORDERS O
                    ON C.CUST_ID = O.CUST_ID;

# Определить топ-1 самых активных покупателей в каждом городе на основе суммы их заказов
SELECT T1.CNAME, T1.CITY, T1.CUST_RANK FROM
    (WITH CUST_OREDERS AS (SELECT CUST_ID,
                             SUM(AMT) AS SUM_AMT
                      FROM ORDERS
                      GROUP BY CUST_ID)
SELECT C.CNAME,
       C.CITY,
       RANK() OVER(PARTITION BY C.CITY ORDER BY CO.SUM_AMT DESC) AS CUST_RANK
FROM CUSTOMERS C
JOIN CUST_OREDERS CO
ON C.CUST_ID = CO.CUST_ID) T1
WHERE T1.CUST_RANK <= 1;

# Ранжировать продавцов по количеству сделок в каждом городе
SELECT S.CITY,
       S.SNAME,
       RANK() OVER(PARTITION BY S.CITY ORDER BY COUNT(O.ORDER_ID) DESC) AS RANK_SELLERS
FROM ORDERS O
LEFT JOIN SELLERS S
ON O.SELL_ID = S.SELL_ID
GROUP BY S.SNAME;

-- Найдите 10 самых высокооплачиваемых сотрудников и ранжируйте их с помощью RANK().
-- Если у нескольких сотрудников одинаковая зарплата, они должны получить одинаковый ранг.
USE hr;
SELECT * FROM (SELECT first_name, last_name,
       RANK() OVER(ORDER BY SALARY DESC) AS SALARY_RANK
FROM employees) t1
WHERE t1.SALARY_RANK <= 10;

-- Для каждого отдела ранжируйте сотрудников по зарплате в порядке убывания.
SELECT first_name, last_name, department_id,
       RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS SALARY_RANK_IN_DEP
FROM employees

-- Для каждого отдела рассчитайте промежуточную сумму зарплат сотрудников в порядке даты найма.
SELECT department_id, salary,
       SUM(salary) OVER(PARTITION BY department_id ORDER BY hire_date) AS  SUM_SALARY_DEP
FROM employees;

-- Для каждого сотрудника рассчитайте процентный вклад его зарплаты в общую зарплату его отдела.
SELECT first_name, last_name, department_id,
ROUND(salary / SUM(salary) OVER(PARTITION BY department_id) * 100, 2) AS sum_salary_in_dep
FROM employees
ORDER BY department_id, sum_salary_in_dep;

-- Рассчитайте разницу между зарплатой сотрудника и самой высокой зарплатой в его отделе.