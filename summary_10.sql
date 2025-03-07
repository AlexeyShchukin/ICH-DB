USE shop;
-- Список клиентов, разместивших более 1 заказов.
SELECT O.CUST_ID, C.CNAME
FROM CUSTOMERS C
         RIGHT JOIN ORDERS O
                    ON C.CUST_ID = O.CUST_ID
GROUP BY C.CUST_ID, C.CNAME
HAVING COUNT(O.ORDER_ID) > 1;

-- Найдите месяц с самыми высокими продажами
SELECT DATE_FORMAT(ODATE, '%M') AS `MONTH`
FROM ORDERS
GROUP BY `MONTH`
HAVING SUM(AMT) = (SELECT MAX(T1.SUM_AMT)
                   FROM (SELECT EXTRACT(MONTH FROM ODATE) AS `MONTH`, SUM(AMT) AS SUM_AMT
                         FROM ORDERS
                         GROUP BY `MONTH`) T1);

-- Найдите клиентов, которые заказали сумму, превышающую среднюю сумму заказа.
SELECT O.CUST_ID, C.CNAME
FROM ORDERS O
         LEFT JOIN CUSTOMERS C
                   ON O.CUST_ID = C.CUST_ID
GROUP BY O.CUST_ID
HAVING SUM(AMT) > (SELECT AVG(T1.CUST_SUM)
                   FROM (SELECT SUM(AMT) AS CUST_SUM
                         FROM ORDERS
                         GROUP BY CUST_ID) T1);

# Найдите менеджеров, которые контролируют более 5 сотрудников, и чьи сотрудники
# имеют среднюю зарплату выше 10 000.
USE hr;

SELECT e.manager_id,
       m.first_name,
       m.last_name,
       COUNT(e.employee_id) AS cnt_emps
FROM employees e
         LEFT JOIN employees m
                   ON e.manager_id = m.employee_id
GROUP BY e.manager_id, m.first_name, m.last_name
HAVING cnt_emps > 5
   AND AVG(e.salary) > 10000;

# Найдите должности, где общий заработок (зарплата + комиссия) превышает
# средний показатель по департаменту.
WITH t1 AS (SELECT e1.department_id,
                   AVG(e1.salary + e1.salary * COALESCE(e1.commission_pct, 0)) AS dep_avg_salary
            FROM employees e1
            GROUP BY e1.department_id)
SELECT e.job_id,
       SUM(e.salary + e.salary * COALESCE(e.commission_pct, 0)) AS job_total_salary
FROM employees e
         JOIN t1
              ON e.department_id = t1.department_id
GROUP BY e.job_id, t1.dep_avg_salary
HAVING job_total_salary > t1.dep_avg_salary;