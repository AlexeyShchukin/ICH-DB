SELECT e.department_id, COUNT(e.employee_id) AS emps_amount
FROM employees e
GROUP BY e.department_id
HAVING emps_amount > 10;

SELECT d.department_name, COUNT(e.employee_id) AS emps_amount
FROM employees e
         RIGHT JOIN departments d
                    ON e.department_id = d.department_id
GROUP BY d.department_name
HAVING emps_amount > 10;

SELECT d.department_name, empl
FROM departments d
         INNER JOIN (SELECT department_id,
                            COUNT(employee_id) empl
                     FROM employees
                     GROUP BY department_id
                     HAVING empl > 10) AS e ON d.department_id = e.department_id;

SELECT e.department_id, MAX(e.salary) AS msx_salary
FROM employees e
GROUP BY e.department_id;

# Найти сотрудников, у которых наибольшая зарплата в их департаменте.
SELECT e.first_name, e.last_name, d.department_name, s.max_salary
FROM employees e
         JOIN (SELECT department_id, MAX(salary) AS max_salary
               FROM employees
               GROUP BY department_id) s ON e.department_id = s.department_id
    AND e.salary = s.max_salary
         JOIN departments d ON e.department_id = d.department_id;

# Найти департамент с наибольшим кол-вом сотрудников.
SELECT d.*, t2.qty_emps
FROM departments d
         JOIN
     (SELECT e.department_id, COUNT(e.employee_id) AS qty_emps
      FROM employees e
      GROUP BY e.department_id
      HAVING COUNT(e.employee_id) = (SELECT MAX(t1.cnt_emps)
                                     FROM (SELECT COUNT(e.employee_id) cnt_emps
                                           FROM employees e
                                           GROUP BY e.department_id) t1)) t2
     ON d.department_id = t2.department_id;

# Найти департаменты, в которых больше 10 сотрудников
SELECT e.department_id
FROM employees e
GROUP BY e.department_id
HAVING COUNT(e.employee_id) > 10;

# Выведите название отделов с кол-вом сотрудников больше среднего.
SELECT d.*, t2.qty_emps
FROM departments d
         JOIN
     (SELECT e.department_id, COUNT(e.employee_id) AS qty_emps
      FROM employees e
      GROUP BY e.department_id
      HAVING COUNT(e.employee_id) > (SELECT AVG(t1.cnt_emps)
                                     FROM (SELECT COUNT(e.employee_id) cnt_emps
                                           FROM employees e
                                           GROUP BY e.department_id) t1)) t2
     ON d.department_id = t2.department_id;

# Используйте базу данных shop
# напишите SQL-запрос
# для определения города с наибольшим числом клиентов в базе данных. Выведите название
# города и общее количество клиентов в этом городе, при условии, что в городе проживает
# более одного клиента.
USE shop;

SELECT C.CITY,
    CASE
        WHEN COUNT(CUST_ID) > 1 THEN COUNT(CUST_ID)
    END AS CUSTOMERS_QTY
FROM CUSTOMERS C
GROUP BY C.CITY
HAVING CUSTOMERS_QTY = (SELECT MAX(T1.CUSTOMERS_QTY)
                        FROM (SELECT COUNT(CUST_ID) AS CUSTOMERS_QTY
                              FROM CUSTOMERS C
                              GROUP BY C.CITY) T1)

