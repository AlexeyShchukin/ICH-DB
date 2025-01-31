SELECT IF(`code` = 'IND', 'Индия', name) AS new_name
FROM world.country
WHERE `code` = 'IND';

SELECT *
FROM hr.employees
WHERE last_name LIKE 'L%';

select round(avg(if(e.salary < 10000, e.salary, NULL)))
from hr.employees e;

describe hr.employees;

SELECT *
FROM hr.departments
WHERE location_id = 1700;

SELECT name,
       IF(CountryCode = 'IND', 'Индия', CountryCode) AS country
FROM city;

SELECT city
FROM hr.locations
WHERE country_id = 'US';

SELECT *
FROM hr.employees
ORDER BY last_name;

SELECT *
FROM hr.employees
WHERE salary >= 5000
  AND salary <= 7000;

SELECT country.name,
       country.LifeExpectancy,
       CASE
           WHEN LifeExpectancy < 50 THEN 'short_liver'
           WHEN LifeExpectancy < 70 THEN 'average_liver'
           ELSE 'long_liver'
       END life_category
FROM world.country;

SELECT *
FROM hr.employees
WHERE first_name LIKE 'D%'
ORDER BY last_name;