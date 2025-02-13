# Найти максимальную зарплату в каждом департаменте. Вывести department_name и max_salary

SELECT dep.department_name, MAX(emp.salary) AS max_salary
FROM employees emp
         LEFT JOIN departments dep
                   ON emp.department_id = dep.department_id
GROUP BY emp.department_id;

# Найти максимальную зарплату сотрудников у каждого менеджера. Вывести first_name, last_name и max_salary

SELECT m.first_name, m.last_name, MAX(emp.salary) AS max_salary
FROM employees emp
         LEFT JOIN employees m
                   ON emp.manager_id = m.employee_id
GROUP BY m.first_name, m.last_name;

# Для каждого менеджера найти сотрудников с максимальной зарплатой,
# вывести first_name, last_name менеджера и first_name, last_name сотрудников

SELECT e.first_name first_name_e,
       e.last_name  last_name_e,
       m.first_name first_name_m,
       m.last_name  last_name_m,
       e.salary
FROM employees e
         JOIN
     (SELECT manager_id,
             MAX(salary) AS salary
      FROM employees
      GROUP BY manager_id) s ON s.manager_id = e.manager_id
         AND s.salary = e.salary
         LEFT JOIN
     employees m ON m.employee_id = e.manager_id
ORDER BY last_name_m, first_name_m;

SELECT e.first_name  AS MitarbeiterName
     , e.last_name   AS MitarbeiterNachName
     , e2.first_name AS ManagerName
     , e2.last_name  AS ManagerName
     , e.salary      AS MaxSalary
FROM employees e
         LEFT JOIN employees e2
                   ON e.manager_id = e2.employee_id
WHERE e.salary = (SELECT MAX(e3.salary)
                  FROM employees e3
                  WHERE e3.manager_id = e.manager_id)
ORDER BY e2.first_name, e2.last_name;

# 1. Выведите 10 городов с наибольшим населением: название города, страна, население.

SELECT city.name AS city,
       country.name AS country,
       city.population
FROM city
JOIN country
ON city.CountryCode = country.Code
ORDER BY Population DESC
LIMIT 10;

# 2. Выведите название страны и количество городов в ней.

SELECT country.name, COUNT(city.name) AS city_cnt
FROM country
LEFT JOIN city
ON country.Code = city.CountryCode
GROUP BY country.name;

# 3. Выведите 10 стран с наиболее высокой продолжительностью жизни

SELECT c.name, c.LifeExpectancy
FROM country c
ORDER BY c.LifeExpectancy DESC
LIMIT 10;

# 4. Выведите список стран с названиями столиц в каждой

SELECT country.name AS country, city.name AS capital
FROM country
LEFT JOIN city
ON country.Code = city.CountryCode
WHERE city.id = country.Capital;

# 5. Выведите разбивку населения по провинциям Голландии

SELECT city.District, SUM(city.Population) AS population
FROM city
WHERE city.CountryCode = 'NLD'
GROUP BY city.District;

# 6. Выведите количество стран с республиканской формой правление (Republic)

SELECT COUNT(*) AS republic_countries
FROM country
WHERE GovernmentForm = 'Republic';

# 7. Выведите все формы правление с количеством стран, в которых она присутствует. Какая самая
# популярная форма правления?
# 8. Выведите список городов, где население больше (меньше) среднего населения по все городам.