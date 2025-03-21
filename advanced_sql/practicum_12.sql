USE airport;
# 1. Вывести количество самолетов каждой модели.
SELECT model_name,
       COUNT(id) AS cnt_airliners
FROM airliners
GROUP BY model_name;

SELECT DISTINCT model_name,
                COUNT(id) OVER (PARTITION BY model_name) AS cnt_airliners
FROM airliners

# 2. Вывести количество самолетов по странам.
SELECT country,
       COUNT(id) AS cnt_airliners
FROM airliners
GROUP BY country;

# 3. Вывести количество trips для каждого типа лайнера.
SELECT airliner_id,
       COUNT(id) AS trips_qty
FROM trips
GROUP BY airliner_id;

SELECT DISTINCT airliner_id,
                COUNT(id) OVER (PARTITION BY airliner_id) AS trips_qty
FROM trips;

# 4. Вывести id билетов, цену билета и среднюю стоимость билета (таблица tickets).
SELECT id,
       price,
       AVG(price) OVER ()
FROM tickets;

WITH avg_t AS (SELECT id, price, AVG(price) OVER () av_p FROM tickets)
SELECT *
FROM avg_t
WHERE price > av_p;

SELECT id, price
FROM tickets
WHERE price > (SELECT AVG(price) FROM tickets);

# 5. Вывести среднюю стоимость билета в каждом классе обслуживания (service_class).
SELECT service_class,
       AVG(price) AS tickets_avg_price
FROM tickets
GROUP BY service_class;

SELECT DISTINCT service_class,
                AVG(price) OVER (PARTITION BY service_class) AS tickets_avg_price
FROM tickets;

# добавить самолеты
SELECT DISTINCT ti.id,
                ti.service_class,
                a.model_name,
                AVG(ti.price) OVER (PARTITION BY ti.service_class, a.model_name) AS tickets_avg_price
FROM tickets ti
         LEFT JOIN trips tr
                   ON ti.trip_id = tr.id
         LEFT JOIN airliners a
                   ON tr.airliner_id = a.id;

# 6. Вывести список поездок (trips) по убыванию количество билетов для каждой поездки.
SELECT ti.trip_id,
       tr.departure,
       tr.arrival,
       COUNT(ti.id) AS tickets_qty
FROM tickets ti
         JOIN trips tr
              ON ti.trip_id = tr.id
GROUP BY ti.trip_id, tr.departure, tr.arrival
ORDER BY tickets_qty DESC;

# 7. Изменить предыдущий запрос так, чтобы выводился ранк каждой поездки в зависимости от
# количества билетов в ней.
SELECT trip_id,
       RANK() OVER (ORDER BY COUNT(id) DESC) AS tickets_qty_rank
FROM tickets
GROUP BY trip_id;

# 8. Вывести поездку с самым большим количеством билетов.
SELECT *
FROM (SELECT trip_id,
             RANK() OVER (ORDER BY COUNT(id) DESC) AS tickets_qty_rank
      FROM tickets
      GROUP BY trip_id) t1
WHERE tickets_qty_rank = 1;

# 9. Вывести поездку с третьим по количеству билетов.
SELECT *
FROM (SELECT trip_id,
             DENSE_RANK() OVER (ORDER BY COUNT(id) DESC) AS tickets_qty_rank
      FROM tickets
      GROUP BY trip_id) t1
WHERE tickets_qty_rank = 3;

# 10. Вывести список билетов с именами пассажиров, а также названием модели авиалайнера.
SELECT ti.id,
       c.name,
       a.model_name
FROM airliners a
         JOIN trips tr ON a.id = tr.airliner_id
         JOIN tickets ti ON tr.id = ti.trip_id
         JOIN clients c ON ti.client_id = c.id;

# 11. Вывести среднее количество билетов у каждого клиента.
SELECT AVG(tickets_aty) AS avg_tick_aty
FROM (SELECT client_id,
             COUNT(id) AS tickets_aty
      FROM tickets
      GROUP BY client_id) t1;

-- Напишите запрос для расчёта населения на каждом континенте.
SELECT c.Continent
     , SUM(c.Population)                      AS by_Country
     , SUM(ci.Population)                     AS by_City
     , SUM(c.Population) - SUM(ci.Population) AS by_Village
FROM country c
         JOIN city ci
              ON c.Code = ci.CountryCode
GROUP BY c.Continent;

-- Найдите количество стран в каждом регионе.
SELECT co.Region,
       COUNT(Code) AS countries_in_region
FROM country co
GROUP BY co.Region;

-- Найдите континенты со средним населением более 50 миллионов человек.
-- Отобразите название континента вместе со средним населением.
SELECT continent, AVG(population) AS avg_population
FROM country
GROUP BY continent
HAVING avg_population > 50000000;

-- Перечислите континенты со средней продолжительностью жизни больше 70 лет.
SELECT Continent, AVG(LifeExpectancy) avg_le
FROM country
GROUP BY Continent
HAVING avg_le > 70;

-- Рассчитайте среднюю продолжительность жизни для стран каждого континента,
-- исключая те, где население менее 10 миллионов человек.
SELECT Continent,
       AVG(LifeExpectancy) AS avg_LE
FROM country
WHERE Population > 10000000
GROUP BY Continent;

-- Перечислите континенты, где процент стран с английским в качестве официального
-- языка превышает 50%. Отобразите название континента вместе с процентом.
SELECT * FROM (SELECT co.Continent,
    ROUND(COUNT(CASE
    WHEN cl.Language = 'English' AND cl.IsOfficial = 'T' THEN co.Code
    END) / COUNT(DISTINCT co.Code) * 100, 2) AS percent_eng_countries
FROM country co
JOIN countrylanguage cl
ON co.Code = cl.CountryCode
GROUP by co.Continent) t1
WHERE percent_eng_countries > 50;

-- Проранжируйте страны по населению в пределах соответствующих им континентов.
SELECT Continent,
       `Name`,
       RANK() OVER(PARTITION BY Continent ORDER BY Population) AS countries_pop_rank
FROM country;

-- Расчитайте накопительную сумму населений в каждом регионе.
SELECT Region,
       `Name`,
       SUM(Population) OVER(PARTITION BY Region ORDER BY Code)
FROM country;

-- Ранжируйте города в каждой стране по населению.
-- Отобразите название города, название страны, население и его ранг.
SELECT co.Name AS Country,
       ci.Name As City,
       ci.Population,
       RANK() OVER(PARTITION BY co.Code ORDER BY ci.Population DESC) AS city_pop_rank
FROM city ci
JOIN country co
ON ci.CountryCode = co.Code;

-- Найдите континенты, где общая площадь превышает 5 миллионов квадратных километров,
-- и средняя продолжительность жизни менее 70 лет.

SELECT Continent,
       SUM(SurfaceArea) AS sum_area,
       AVG(LifeExpectancy) AS avg_LE
FROM country
GROUP BY Continent
HAVING sum_area > 5000000 AND avg_LE < 70;

-- Рассчитайте разницу между зарплатой сотрудника и самой высокой зарплатой в его отделе.
SELECT first_name,
       last_name,
       department_id,
       salary,
       MAX(salary) OVER(PARTITION BY department_id) - salary AS diff_salary
FROM employees

-- Для каждого сотрудника отобразите зарплату предыдущего и следующего
-- сотрудника в зависимости от даты найма.
SELECT first_name,
       last_name,
       hire_date,
       LAG(salary) OVER (ORDER BY hire_date) AS prev_salary,
       LEAD(salary) OVER (ORDER BY hire_date) AS next_salary
FROM employees

-- Сравните зарплату каждого сотрудника с зарплатой ранее нанятого сотрудника в его отделе.
SELECT first_name,
       last_name,
       salary,
       hire_date,
       LAG(salary) OVER(PARTITION BY department_id ORDER BY hire_date) AS prev_emp_salary,
       salary - COALESCE(LAG(salary) OVER(PARTITION BY department_id ORDER BY hire_date), 0) AS diff_salary
FROM employees
