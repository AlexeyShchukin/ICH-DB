SELECT city.CountryCode, SUM(city.Population) AS population
FROM city
GROUP BY CountryCode;

SELECT co.name, IF(SUM(city.population) IS NULL, 0, SUM(city.Population)) AS city_population
FROM city
         RIGHT JOIN country co
                    ON city.CountryCode = co.Code
GROUP BY CountryCode;

SELECT co.name, COUNT(cl.language) AS language
FROM country co
         LEFT JOIN countrylanguage cl
                   ON co.Code = cl.CountryCode
GROUP BY co.name
ORDER BY language;

SELECT c.CountryCode
     , c.`Language`
FROM countrylanguage c
WHERE c.Percentage = (SELECT MAX(c2.Percentage)
                      FROM countrylanguage c2
                      WHERE c2.CountryCode = c.CountryCode);

SELECT coun.Name
     , c.`Language`
FROM countrylanguage c
         JOIN (SELECT c2.CountryCode     AS CountryCode,
                      MAX(c2.Percentage) AS maxPercentage
               FROM countrylanguage c2
               GROUP BY c2.CountryCode) AS c3
              ON c.CountryCode = c3.CountryCode AND c.Percentage = c3.maxPercentage
         INNER JOIN country AS coun
                    ON c.CountryCode = coun.Code
ORDER BY c.CountryCode;

# Для каждой страны выведите разницу между суммой населений
# её городов и населением всей страны.

SELECT co.name, co.population - IF(SUM(ci.Population) IS NULL, 0, SUM(ci.Population)) AS diff_pop
FROM country co
         LEFT JOIN city ci
                   ON co.code = ci.CountryCode
GROUP BY co.name
ORDER BY diff_pop;

# 1. Выведите количество сотрудников, работающих в отделах Marketing и IT, используя
# операцию JOIN между таблицами "employees" и "departments" по полю
# "department_id"

USE hr;

SELECT d.department_name, COUNT(e.employee_id) AS cnt_emp
FROM employees e
         RIGHT JOIN departments d
                    ON e.department_id = d.department_id
WHERE d.department_name IN ('Marketing', 'IT')
GROUP BY d.department_name;

# 2. Посчитайте сумму зарплат всех сотрудников
SELECT SUM(salary) AS total_salary
FROM employees;

# 3. Посчитайте сумму зарплат сотрудников, работающих в IT
SELECT SUM(e.salary) AS it_salary
FROM employees e
         JOIN departments d
              ON e.department_id = d.department_id
WHERE department_name = 'IT';

# Посчитайте сумму зарплат сотрудников, работающих в Мюнхене.
SELECT SUM(e.salary) AS salary
FROM employees e
         LEFT JOIN departments d
                   ON e.department_id = d.department_name
         LEFT JOIN locations l
                   ON d.location_id = l.location_id
WHERE l.city = 'Munich';

# Посчитайте среднюю зарплату по городу.
SELECT l.city, IF(AVG(e.salary) IS NULL, 0, AVG(e.salary)) AS salary
FROM employees e
         RIGHT JOIN departments d
                    ON e.department_id = d.department_id
         RIGHT JOIN locations l
                    ON d.location_id = l.location_id
GROUP BY l.city
ORDER BY salary;

# Одним запросом посчитайте сумму зарплат всех сотрудников и сумму зарплат сотрудников, работающих в IT.
SELECT SUM(salary) AS total_salary, SUM(IF(d.department_name = 'IT', e.salary, NULL)) AS it_salary
FROM employees e
         JOIN departments d
              ON e.department_id = d.department_id;

# 1. Выведите имена студентов и id курса, которые они проходят
USE students;
SELECT s.name,
       s2c.course_id
FROM Students s
         JOIN Students2Courses s2c
              ON s.id = s2c.student_id;

# 2. Измените запрос в задании 1 так, чтобы выводились имена студентов и названия
# курсов, которые они проходят
SELECT s.name, c.title AS course_name
FROM Students s
         LEFT JOIN students.Students2Courses s2c
                   ON s.id = s2c.student_id
         LEFT JOIN Courses c
                   ON s2c.course_id = c.id;

# 3. Вывести имена всех преподавателей с их компетенциями. Подсказка: сначала
# выведите имена преподавателей с id компетенции. А потом поменяйте запрос так
# (добавив еще один джойн), чтобы выводились имена преподавателей и названия
# компетенций

SELECT t.name, c.title
FROM Teachers t
         LEFT JOIN Teachers2Competencies t2c
                   ON t.id = t2c.teacher_id
         LEFT JOIN Competencies c
                   ON t2c.competencies_id = c.id;

# 4. Найти преподавателя, у которого нет компетенций
SELECT t.name
FROM Teachers t
         LEFT JOIN Teachers2Competencies t2c
                   ON t.id = t2c.teacher_id
WHERE t2c.teacher_id IS NULL;

# 5. Найти имена студентов, которые не проходят ни один курс
SELECT s.name
FROM Students s
         LEFT JOIN Students2Courses s2c
                   ON s.id = s2c.student_id
WHERE s2c.student_id IS NULL;

# 6. Найти курсы, которые не посещает ни один студент
SELECT c.title
FROM Courses c
         LEFT JOIN Students2Courses s2c
                   ON c.id = s2c.course_id
WHERE s2c.course_id IS NULL;

# 7. Найти компетенции, которых нет ни у одного преподавателя
SELECT c.title
FROM Teachers2Competencies t2c
         RIGHT JOIN Competencies c
                    ON t2c.competencies_id = c.id
WHERE t2c.competencies_id IS NULL;

# 8. Вывести название курса и имя старосты
SELECT c.title, s.name AS headman
FROM Courses c
         LEFT JOIN Students s
                   ON c.headman_id = s.id;

# Отобразить имена студента и старост, на которых они обучаются
SELECT s.name
     , hs.name AS "headManName"
FROM Students s
         JOIN Students2Courses sc
              ON s.id = sc.student_id
         JOIN Courses c
              ON sc.course_id = c.id
         JOIN Students hs
              ON c.headman_id = hs.id