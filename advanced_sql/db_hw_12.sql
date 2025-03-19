# 1. Вывести количество городов для каждой страны.
# Результат должен содержать CountryCode, CityCount (количество городов в стране).
# Поменяйте запрос с использованием джойнов так, чтобы выводилось название страны вместо CountryCode.
SELECT ci.CountryCode,
       COUNT(ci.ID) AS CityCount
FROM city ci
GROUP BY ci.CountryCode;

SELECT co.Name,
       COUNT(ci.ID) AS CityCount
FROM country co
         JOIN city ci
              ON co.Code = ci.CountryCode
GROUP BY co.Name;

# 2. Используя оконные функции, вывести список стран с продолжительностью жизнью и
# средней продолжительностью жизни.
SELECT Name,
       LifeExpectancy,
       ROUND(AVG(LifeExpectancy) OVER(), 2) AS avg_life_exp
FROM country;

# 3. Используя ранжирующие функции, вывести страны по убыванию продолжительности жизни.
SELECT Name,
       RANK() OVER(ORDER BY LifeExpectancy DESC) AS LE_rank
FROM country;

# 4. Используя ранжирующие функции,
# вывести третью страну с самой высокой продолжительностью жизни.
SELECT * FROM (SELECT Name,
       RANK() OVER(ORDER BY LifeExpectancy DESC) AS LE_rank
FROM country) t1
WHERE LE_rank = 3;