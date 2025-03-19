SELECT e.first_name, e.last_name, d.department_name
FROM employees e
JOIN hr.departments d
ON e.department_id = d.department_id;

SELECT e.first_name, e.last_name, d.department_name
FROM employees e
JOIN hr.departments d
ON e.department_id = d.department_id
WHERE department_name IN ('IT', 'Treasury', 'IT Support');

# SELECT emp.first_name, emp.last_name,
# FROM hr.employees emp
# JOIN hr.
# ON emp.manager_id = d.manager_id

SELECT
empl.first_name,
empl.last_name,
m.first_name AS manager_name,
m.last_name AS manager_last_name
FROM employees empl
INNER JOIN employees m
ON empl.manager_id = m.employee_id;

SELECT emp.first_name, emp.last_name, emp.job_id
FROM employees emp
JOIN employees man
ON emp.manager_id = man.employee_id
WHERE emp.salary > man.salary;

SELECT emp.first_name, emp.last_name, city
FROM employees emp
JOIN departments dep
ON emp.department_id = dep.department_id
JOIN locations loc
ON dep.location_id = loc.location_id
AND loc.city in ('Seattle', 'Toronto');

SELECT dep.department_name
FROM departments dep
INNER JOIN employees emp
ON emp.employee_id = dep.manager_id
WHERE emp.salary > 10000;

SELECT emp.first_name, emp.last_name, dep.department_name, j.job_title
FROM employees emp
JOIN departments dep
ON emp.department_id = dep.department_id
JOIN jobs j
ON emp.job_id = j.job_id;

SELECT emp.first_name, last_name, emp.salary
FROM employees emp
INNER JOIN departments dep
ON emp.department_id = dep.department_id
INNER JOIN locations loc
ON dep.location_id = loc.location_id
AND loc.city in ('Oxford', 'San Francisco');

select e.first_name, e.last_name, d.department_name
from employees e
left join departments d
on e.department_id = d.department_id;

SELECT
d.department_name
FROM
departments d
LEFT JOIN employees e
ON e.department_id = d.department_id
WHERE e.salary > 15000;

SELECT dep.department_name
FROM departments dep
LEFT JOIN employees emp
ON dep.department_id = emp.department_id
WHERE emp.department_id IS NULL;

