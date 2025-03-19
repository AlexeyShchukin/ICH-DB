# 1. Подключитесь к базе данных hr

USE hr;

# 2. Выведите одним запросом общее количество департаментов (отделов) в базе, количество
# департаментов, где есть сотрудники и количество департаментов где нет сотрудников (на
# выходе три столбца и одна строчка)

SELECT COUNT(DISTINCT dep.department_id) AS deps,
       COUNT(DISTINCT IF(emp.department_id IS NULL, NULL, dep.department_id)) AS full_dep,
       COUNT(IF(emp.department_id IS NOT NULL, NULL, dep.department_id)) AS empty_dep
FROM departments dep
LEFT JOIN employees emp
        ON dep.department_id = emp.department_id;


# 3. Подключитесь к базе данных World

USE world;

# 4. Выведите одним запросом среднюю продолжительность жизни, минимальную и
# максимальную по континентам. Если измерение равно NULL, то выведите "нет
# данных"

SELECT AVG(co.LifeExpectancy)
FROM country co


# 5. Выведите самую большую площадь территории среди стран, которые приняли
# независимость до 1950 года.