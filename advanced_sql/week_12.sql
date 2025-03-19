# 1. Найти количество сотрудников у каждого менеджера. Вывести manager_id и
# employees_cnt
SELECT e.manager_id,
       m.first_name,
       m.last_name,
       COUNT(e.employee_id) AS emps_amount
FROM employees e
         JOIN employees m
              ON e.manager_id = m.employee_id
GROUP BY e.manager_id, m.first_name, m.last_name;

# 2. Работаем с базой World. Выведите седьмой по густонаселенности город.
# Подсказка: использовать функцию rank() и оконные функции.
SELECT Name,
       Population
FROM (SELECT Name,
             Population,
             RANK() OVER (ORDER BY Population DESC) density
      FROM city) density_rank
WHERE density = 7;

# 3. Выведите название города, население и максимальное население для каждого
# города
SELECT Name,
       Population,
       MAX(Population) OVER ()
FROM city;

# 4. Напишите запрос для определения разницы в продолжительности жизни между
# текущей страной и страной с самой высокой продолжительностью жизни.
SELECT MAX(LifeExpectancy) OVER () - COALESCE(LifeExpectancy, 0) AS LifeExpDiff
FROM country;

# 5. Выполните ранжирование стран по средней численности населения в городах
SELECT co.Code,
       DENSE_RANK() OVER (ORDER BY AVG(ci.Population)) AS avg_pop_rank
FROM country co
         LEFT JOIN city ci
                   ON co.Code = ci.CountryCode
GROUP BY co.Code;

# 6. На основании предыдущего запроса выведите топ 5 стран по средней численности
# населения (Используйте LIMIT)
SELECT co.Code,
       RANK() OVER (ORDER BY AVG(ci.Population) DESC) AS avg_pop_rank
FROM country co
         LEFT JOIN city ci
                   ON co.Code = ci.CountryCode
GROUP BY co.Code
LIMIT 5;

# 8. На основании предыдущего запроса выведите топ 5 стран по средней численности
# населения (используйте вложенный запрос)
SELECT *
FROM (SELECT co.Code,
             AVG(ci.Population)                             AS avg_cntry_pop,
             RANK() OVER (ORDER BY AVG(ci.Population) DESC) AS avg_pop_rank
      FROM country co
               LEFT JOIN city ci
                         ON co.Code = ci.CountryCode
      GROUP BY co.Code) t1
WHERE avg_pop_rank <= 5;

# 9. Напишите запрос для определения доли населения города от общей численности
# населения страны и проведите ранжирование городов в пределах каждой страны:
SELECT co.Name                                                   AS Country,
       ci.Name                                                   AS City,
       ROUND(ci.Population / co.Population * 100, 2)             AS pop_rel_city_country,
       RANK() OVER (PARTITION BY co.Code ORDER BY ci.Population) AS city_pop_rel
FROM country co
         JOIN city ci
              ON co.Code = ci.CountryCode;

# 10. Написать SQL-запрос для выбора городов, занимающих первое место по населению
# в своих странах и превышающих среднее население по всем городам.
SELECT *
FROM (SELECT co.Name                                                        AS Country,
             ci.Name                                                        AS City,
             ci.Population,
             RANK() OVER (PARTITION BY co.Name ORDER BY ci.Population DESC) AS city_pop_rank,
             AVG(ci.Population) OVER ()                                     AS avg_pop
      FROM city ci
               JOIN country co
                    ON ci.CountryCode = co.Code) t1
WHERE t1.Population > avg_pop
  AND city_pop_rank = 1;

# 11. Выведите страны, где количество городов больше 10
# 12. Перепишите решение предыдущей задачи так, чтобы вместо CountryCode было
# название страны из таблицы country;
SELECT co.Name,
       COUNT(ci.ID) AS city_amount
FROM country co
         JOIN city ci
              ON co.Code = ci.CountryCode
GROUP BY co.Name
HAVING city_amount > 10;

# 13. Выведите список форм правления (GovernmentForm) c количеством стран, где есть
# эта форма правления.
SELECT GovernmentForm, COUNT(Code) AS country_amount
FROM country
GROUP BY GovernmentForm;

# 14. Выведите формы правления, которые есть в 10 и более странах
SELECT GovernmentForm, COUNT(Code) AS country_amount
FROM country
GROUP BY GovernmentForm
HAVING country_amount >= 10;