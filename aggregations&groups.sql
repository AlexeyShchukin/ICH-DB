SELECT emp.first_name, emp.last_name
FROM employees emp
WHERE emp.salary = (SELECT max(emp1.salary) FROM employees emp1);

SELECT max(emp.salary) AS max_salary FROM employees emp;

SELECT COUNT(DISTINCT emp.employee_id) AS emp_quantity
FROM employees emp;

SELECT ROUND(AVG(emp.salary), 2) AS avg_salary
FROM employees emp;

SELECT emp.first_name, emp.last_name
FROM employees emp
WHERE salary < (SELECT AVG(emp1.salary)
FROM employees emp1);

SELECT COUNT(dep.department_id) AS cnt_dep
FROM departments dep;

SELECT COUNT(dep.department_id) AS cnt_dep
FROM departments dep
LEFT JOIN employees emp
ON dep.department_id = emp.department_id
WHERE emp.department_id IS NULL;

SELECT COUNT(dep.department_id) AS cnt_dep
FROM departments dep
WHERE dep.department_id NOT IN (SELECT DISTINCT emp.department_id
                                FROM employees emp
                                WHERE emp.department_id IS NOT NULL);

SELECT AVG(emp.salary)
FROM employees emp
WHERE emp.department_id = 90;

SELECT
MAX(emp.salary) as max_salary
from employees emp
where emp.department_id in (70, 80);

SELECT COUNT(*) cnt_emps
FROM employees emp
WHERE emp.department_id = 100 AND emp.salary > 5000;

SELECT COUNT(*) cnt_emps
FROM employees emp
WHERE emp.department_id = 60 AND emp.salary > (
    SELECT AVG(emp1.salary) FROM employees emp1);

SELECT COUNT(*) cnt_emp
FROM employees emp
JOIN departments dep
ON emp.department_id = dep.department_id
WHERE dep.department_name = 'IT' AND emp.salary < (
    SELECT AVG(emp1.salary) FROM employees emp1);

SELECT emp.department_id, COUNT(emp.employee_id) AS cnt_emp
FROM employees emp
GROUP BY emp.department_id;

SELECT dep.department_name, COUNT(emp.employee_id) AS cnt_emp
FROM departments dep
LEFT JOIN employees emp
ON dep.department_id = emp.department_id
GROUP BY dep.department_name;

SELECT emp.first_name, emp.last_name
FROM employees emp
JOIN (SELECT emp1.department_id, MAX(emp1.salary) AS max_salary
FROM employees emp1
GROUP BY emp1.department_id) t1
ON emp.department_id = t1.department_id
AND emp.salary = t1.max_salary;

SELECT job_id, COUNT(*) AS cnt_emps
FROM employees emp
GROUP BY emp.job_id;

SELECT SUM(cnt_emps) AS sum_emps FROM (
                                        SELECT j.job_title, COUNT(*) AS cnt_emps
                                        FROM employees emp
                                        RIGHT JOIN jobs j
                                        ON emp.job_id = j.job_id
                                        GROUP BY j.job_title) AS t1;

SELECT AVG(emp.salary), MIN(emp.salary), MAX(emp.salary)
FROM employees emp;

select d.department_name, avg(e.salary) as middl, min(e.salary) as min_salary, max(e.salary) as max_salary
from employees e
right join departments d
on d.department_id = e.department_id
group by d.department_name;

SELECT emp.manager_id, COUNT(*) AS cnt_emps
FROM employees emp
GROUP BY manager_id;

SELECT SUM(cnt_emps) AS sum_emps FROM (SELECT m.first_name, m.last_name , COUNT(*) AS cnt_emps
FROM employees emp
LEFT JOIN employees m
ON emp.manager_id = m.employee_id
GROUP BY m.first_name, m.last_name) t1;

SELECT emp.first_name, emp.last_name, emp.salary
FROM employees emp
WHERE salary < (SELECT AVG(emp1.salary)
                FROM employees emp1
                );

SELECT emp.first_name, emp.last_name, emp.salary
FROM employees emp
JOIN (SELECT emp1.department_id, AVG(emp1.salary) AS avg_dep_salary
      FROM employees emp1
      GROUP BY emp1.department_id) t1
ON emp.department_id = t1.department_id
AND emp.salary < t1.avg_dep_salary;