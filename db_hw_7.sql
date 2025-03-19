# Подключитесь к базе данных hr (которая находится на удаленном сервере).

USE hr;

# Выведите количество сотрудников в базе

SELECT COUNT(*) AS cnt_emps FROM employees;

# Выведите количество департаментов (отделов) в базе

SELECT COUNT(*) AS cnt_deps FROM departments;

# Подключитесь к базе данных World (которая находится на удаленном сервере).

USE world;

# Выведите среднее население в городах Индии (таблица City, код Индии - IND)

SELECT AVG(city.Population) AS avg_pop_ind FROM city
WHERE city.CountryCode = 'IND';

# Выведите минимальное население в индийском городе и максимальное.

SELECT MIN(city.Population) AS min_pop_ind,
       MAX(city.Population) AS max_pop_ind
FROM city
WHERE city.CountryCode = 'IND';

# Выведите самую большую площадь территории.

SELECT MAX(country.SurfaceArea) AS max_sur FROM country;

# Выведите среднюю продолжительность жизни по странам.

SELECT AVG(country.LifeExpectancy) AS avg_le FROM country;

# Найдите самый населенный город

SELECT city.Name AS most_pop
FROM city
WHERE city.Population = (SELECT MAX(Population)
                         FROM city);
