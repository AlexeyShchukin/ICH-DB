USE students;
# 1. Выведите список студентов с курсом, на который каждый записан (результат содержит имя
# студента - name и course_id).

SELECT s.name, s2c.course_id
FROM Students s
LEFT JOIN Students2Courses s2c
ON s.id = s2c.student_id;

# 2. Изменить предыдущий запрос так, чтобы вместо course_id выводилось название курса.

SELECT s.name, c.title AS course_name
FROM Students s
LEFT JOIN Students2Courses s2c
ON s.id = s2c.student_id
LEFT JOIN Courses c
ON s2c.course_id = c.id;

# 3. Выведите список студентов, который не записаны на какой-либо курс.

SELECT s.name, s2c.course_id
FROM Students s
LEFT JOIN Students2Courses s2c
ON s.id = s2c.student_id
WHERE s2c.course_id IS NULL;

# 4. Выведите список преподавателей с компетенциями (имя преподавателя, competencies_id)

SELECT t.name, t2c.competencies_id
FROM Teachers t
LEFT JOIN Teachers2Competencies t2c
ON t.id = t2c.teacher_id;

# 5. Измените предыдущий запрос так, чтобы вместо competencies_id было название компетенции.

SELECT t.name, c.title
FROM Teachers t
LEFT JOIN Teachers2Competencies t2c
ON t.id = t2c.teacher_id
LEFT JOIN Competencies c
ON t2c.competencies_id = c.id;

# 6. Убедитесь, что в таблице teachers нет преподавателей без компетенций.

SELECT t.name, t2c.competencies_id
FROM Teachers t
LEFT JOIN Teachers2Competencies t2c
ON t.id = t2c.teacher_id
WHERE t2c.competencies_id IS NULL;

USE world;

# 1. Выведите список стран со столицами.
SELECT country.name, city.name AS capital
FROM country
LEFT JOIN city
ON country.Capital = city.ID
# WHERE city.id IS NULL
;

# 2. Выведите список стран с языками, на которых в них говорят.

SELECT c.name, cl.language
FROM country c
LEFT JOIN countrylanguage cl
ON c.Code = cl.CountryCode;

# 3. Выведите список стран с официальными языками.

SELECT c.name, cl.language
FROM country c
LEFT JOIN countrylanguage cl
ON c.Code = cl.CountryCode
AND IsOfficial = True;

# 4. Сравните результаты (количество записей в результате) предыдущих запросов. Где в результате
# больше записей?

SELECT COUNT(*)
FROM country c
JOIN countrylanguage cl
ON c.Code = cl.CountryCode;

SELECT COUNT(*)
FROM country c
JOIN countrylanguage cl
ON c.Code = cl.CountryCode
AND IsOfficial = True;

SELECT COUNT(*)
FROM country c
JOIN countrylanguage cl
ON c.Code = cl.CountryCode
AND IsOfficial = True
INTO @offcl;

SELECT @offcl;

SELECT COUNT(*)
FROM country c
JOIN countrylanguage cl
ON c.Code = cl.CountryCode
INTO @cl;

SELECT @offcl < @cl AS comparison;

# 5. Поменяйте последний запрос (3) так, чтобы результат выглядел так (например, для Samoa):
# Samoa | {English, Samoan}, то есть на каждую страну была только одна запись, а соответствующие
# официальные языки бы отображались в одно строчку списком.

SELECT c.Name Country,
CONCAT('{', GROUP_CONCAT(cl.Language SEPARATOR ', '), '}') AS Official_Languages
FROM country c
LEFT JOIN countrylanguage cl
ON c.Code = cl.CountryCode
WHERE cl.IsOfficial = True
GROUP BY c.NAME;