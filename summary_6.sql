SELECT o.name, sum(g.price)
FROM orders o
JOIN goods g
ON o.product = g.product
GROUP BY o.name;

# Для каждого сотрудника выведите имя, фамилию и название департамента.
USE hr;

SELECT emp.first_name, emp.last_name, dep.department_name
FROM employees emp
LEFT JOIN departments dep
ON emp.department_id = dep.department_id;

# Для каждого департамента выведите имя и фамилию менеджера.

SELECT dep.department_name, emp.first_name, emp.last_name
FROM employees emp
RIGHT JOIN departments dep
ON emp.employee_id = dep.manager_id;

# Для каждого сотрудника выведите его имя, фамилию и разницу между зарплатой его менеджера и его зарплатой.

SELECT emp.first_name,
       emp.last_name,
       m.first_name,
       m.last_name,
       m.salary - emp.salary AS diff
FROM employees emp
LEFT JOIN employees m
ON m.employee_id = emp.manager_id;

# Измените предыдущий запрос так, чтобы выводились только те сотрудники, которые зарабатывают больше своих менеджеров.

SELECT emp.first_name,
       emp.last_name,
       m.first_name,
       m.last_name,
       m.salary - emp.salary AS diff
FROM employees emp
LEFT JOIN employees m
ON m.employee_id = emp.manager_id
WHERE emp.salary > m.salary;

# Убедитесь в том, что в компании нет незанятых позиций.

SELECT jobs.job_title, emp.first_name, emp.last_name
FROM jobs
LEFT JOIN employees emp
ON jobs.job_id = emp.job_id
WHERE emp.job_id IS NULL;

# Выведите сотрудников, работающих в Мюнхене.

SELECT emp.first_name, emp.last_name
FROM employees emp
JOIN departments dep
ON emp.department_id
JOIN locations loc
ON dep.location_id = loc.location_id
WHERE loc.city = 'Munich';

# Для каждого сотрудника вывести его имя, фамилию и название региона.

SELECT emp.first_name, emp.last_name, reg.region_name
FROM employees emp
LEFT JOIN departments dep
ON emp.department_id = dep.department_id
LEFT JOIN locations loc
ON dep.location_id = loc.location_id
LEFT JOIN countries c
ON loc.country_id = c.country_id
LEFT JOIN regions reg
ON c.region_id = reg.region_id;

# Для каждого сотрудника вывести его имя, фамилию и страну.

SELECT emp.first_name, emp.last_name, c.country_name
FROM employees emp
LEFT JOIN departments dep
ON emp.department_id = dep.department_id
LEFT JOIN locations loc
ON dep.location_id = loc.location_id
LEFT JOIN countries c
ON loc.country_id = c.country_id;
