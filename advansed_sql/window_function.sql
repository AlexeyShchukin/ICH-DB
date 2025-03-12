SELECT O.*, grouped_sum_amt.sum_amt FROM ORDERS O
JOIN (SELECT SELL_ID, SUM(AMT) AS sum_amt FROM ORDERS
GROUP BY SELL_ID) grouped_sum_amt
ON O.SELL_ID = grouped_sum_amt.SELL_ID
ORDER BY SELL_ID;

# 1. Вывести средний рейтинг клиентов по городам: для каждого города вывести средний рейтинг клиентов.
SELECT *, AVG(RATING) OVER(PARTITION BY CITY) AS avg_rating
FROM CUSTOMERS
ORDER BY RATING;

# 2. Вывести информацию о каждом заказе и максимальную сумму заказа в том же месяце для каждой строки.
SELECT *, MAX(AMT) OVER(PARTITION BY EXTRACT(MONTH FROM ODATE)) MAX_AMT
FROM ORDERS;

# 3. Добавим подсчет относительного вклада каждого заказа в общий объем продаж месяца.
SELECT *,
       SUM(AMT) OVER(PARTITION BY EXTRACT(MONTH FROM ODATE)) MONTHLY_SUM,
       ROUND(AMT / SUM(AMT) OVER(PARTITION BY EXTRACT(MONTH FROM ODATE)) * 100, 2) IMPACT
FROM ORDERS;

# 4. Вывести список продавцов с указанием общей суммы их продаж. Отсортировать продавцов по убыванию суммы продаж.
SELECT O.*, S.SNAME, COALESCE(SUM(O.AMT) OVER(PARTITION BY O.SELL_ID), 0) AS SELL_SUM
FROM ORDERS O
RIGHT JOIN SELLERS S
ON O.SELL_ID = S.SELL_ID
ORDER BY SELL_SUM DESC;

# 5. Вывести топ-2 продавцов с самой высокой средней суммой заказа.
SELECT DISTINCT S.SNAME, ROUND(COALESCE(AVG(O.AMT) OVER(PARTITION BY O.SELL_ID), 0), 2) AS AVG_AMT
FROM ORDERS O
RIGHT JOIN SELLERS S
ON O.SELL_ID = S.SELL_ID
ORDER BY AVG_AMT DESC
LIMIT 2;

# 1. Произведите ранжирование департаментов по средней зарплате.
USE hr;

SELECT d.department_name,
       AVG(e.salary) dep_avg_salary,
       ROW_NUMBER() OVER(ORDER BY AVG(e.salary)) AS `rank`
FROM employees e
RIGHT JOIN departments d
ON e.department_id = d.department_id
GROUP BY e.department_id;

# 2. Выведите топ-3 сотрудников с наивысшей зарплатой в каждом департаменте.
SELECT t1.*, d.department_name FROM (SELECT employee_id,
       department_id,
       salary,
       RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS `rank`
FROM employees) t1
LEFT JOIN departments d
ON t1.department_id = d.department_id
WHERE t1.`rank` <= 3;

# 3. Выведите второго по зарплате сотрудника в каждом департаменте.
SELECT s.department_id, s.salary, d.department_name FROM (SELECT *,
       DENSE_RANK() OVER(PARTITION BY department_id ORDER BY salary) salary_rank
FROM employees) s
LEFT JOIN departments d
ON s.department_id = d.department_id
WHERE s.salary_rank = 2;

# 4. Получить информацию о зарплате сотрудников, а также рассчитать кумулятивную и
# относительную кумулятивную сумму зарплаты для каждого сотрудника в пределах своего
# департамента.
SELECT employee_id,
       department_id,
       SUM(salary) OVER(PARTITION BY department_id ORDER BY employee_id) AS emp_dep_sum_salary,
       ROUND(SUM(salary) OVER(PARTITION BY department_id ORDER BY employee_id) / SUM(salary) OVER(PARTITION BY department_id) * 100, 2) AS rel_sum
FROM employees