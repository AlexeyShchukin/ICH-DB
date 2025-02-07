USE world;

SELECT c.Name, cl.Language
FROM country c
LEFT JOIN countrylanguage cl
ON c.Code = cl.CountryCode;

SELECT city.Name, city.Population, country.Name
FROM city
LEFT JOIN country
ON city.CountryCode = country.Code;

SELECT city.Name
FROM city
LEFT JOIN country
ON city.CountryCode = country.Code
WHERE country.Name = 'South Africa';

SELECT country.Name AS country, city.Name AS capital
FROM city
LEFT JOIN country
ON city.ID = country.Capital;

SELECT country.Name AS country, city.Name AS capital, city.Population AS capital_pop
FROM city
LEFT JOIN country
ON city.ID = country.Capital;

SELECT city.Name AS capital
FROM city
LEFT JOIN country
ON city.ID = country.Capital
WHERE country.Name = 'United States';

USE hr;

SELECT emp.first_name, emp.last_name, loc.city
FROM employees emp
LEFT JOIN departments dep
ON emp.department_id = dep.department_id
LEFT JOIN locations loc
ON dep.location_id = loc.location_id;

SELECT loc.city, c.country_name
FROM locations loc
LEFT JOIN countries c
ON loc.country_id = c.country_id;