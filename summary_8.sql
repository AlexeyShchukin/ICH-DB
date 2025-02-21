# 1. Посчитать количество менеджеров в каждом отделе у которых количество подчиненных больше 2.
# Подсказка: используем having на количество сгруппированных менеджеров в каждом отделе.
USE hr;

SELECT d.department_name, COUNT(em.employee_id)
FROM employees em
         JOIN (SELECT manager_id, COUNT(employee_id) count_employee
               FROM employees
               GROUP BY manager_id
               HAVING count_employee > 1) mi
              ON em.employee_id = mi.manager_id
         JOIN departments d
              ON em.department_id = d.department_id
GROUP BY d.department_name;

# количество дубликатов
SELECT employee_id, COUNT(*) AS num_employees
FROM employees
GROUP BY employee_id
HAVING num_employees > 1
ORDER BY num_employees DESC;
DESCRIBE employees;

# найти вторую по величине зарплату
SELECT MAX(e.salary) AS second_max_salary
FROM employees e
WHERE e.salary < (SELECT MAX(salary)
                  FROM employees);

# Выведите список городов по странам, где население больше (меньше)
# среднего населения по все городам в пределах данной страны.
USE world;
SELECT tm.CountryCode
     , tm.Name
FROM (SELECT c.CountryCode
           , c.Name
           , (SELECT AVG(c2.Population) FROM city AS c2 WHERE c2.CountryCode = c.CountryCode) AS AVG_Population
           , c.Population
      FROM city c) AS tm
WHERE tm.AVG_Population > tm.Population;