# Подключиться к базе данных world
USE world;
# Вывести население в каждой стране. Результат содержит два поля: CountryCode, sum(Population). Запрос по таблице city.
SELECT CountryCode, SUM(Population) AS CountryPopulation
FROM city
GROUP BY CountryCode;

# Изменить запрос выше так, чтобы выводились только страны с населением более 3 млн человек.
SELECT CountryCode, SUM(Population) AS CountryPopulation
FROM city
GROUP BY CountryCode
HAVING CountryPopulation > 3000000;

# Сколько всего записей в результате?
SELECT COUNT(*) FROM (SELECT CountryCode, SUM(Population) AS CountryPopulation
FROM city
GROUP BY CountryCode
HAVING CountryPopulation > 3000000) t1;


# Поменять запрос выше так, чтобы в результате вместо кода страны выводилось ее название.
SELECT country.Name, SUM(city.Population) AS CountryPopulation
FROM city
RIGHT JOIN country
ON city.CountryCode = country.Code
GROUP BY country.Code
HAVING CountryPopulation > 3000000;

# Вывести количество городов в каждой стране (CountryCode, amount of cities).
SELECT CountryCode, COUNT(id) AS city_qty
FROM city
GROUP BY CountryCode;

# Поменять запрос так, чтобы вместо кодов стран, было названия стран.
SELECT country.name, COUNT(id) AS city_qty
FROM city
RIGHT JOIN country
ON city.CountryCode = country.Code
GROUP BY country.Code;

# Поменять запрос так, чтобы выводилось среднее количество городов в стране.
SELECT ROUND(AVG(t1.city_qty)) AS avg_qty_of_cities
FROM (SELECT country.name, COUNT(id) AS city_qty
FROM city
RIGHT JOIN country
ON city.CountryCode = country.Code
GROUP BY country.Code) t1;
