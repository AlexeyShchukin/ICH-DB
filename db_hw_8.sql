# Подключитесь к базе данных Students (которая находится на удаленном сервере).
USE students;

# Найдите самого старшего студента
SELECT name
FROM Students
WHERE age = (SELECT MAX(age) FROM Students);

# Найдите самого старшего преподавателя
SELECT name
FROM Teachers
WHERE age = (SELECT MAX(age) FROM Teachers);

# Выведите список преподавателей с количеством компетенций у каждого
SELECT t.name, COUNT(t2c.competencies_id) AS cnt_copm
FROM Teachers t
LEFT JOIN Teachers2Competencies t2c
ON t.id = t2c.teacher_id
GROUP BY t.id;

# Выведите список курсов с количеством студентов в каждом
SELECT c.title, COUNT(s2c.student_id) AS cnt_students
FROM Courses c
LEFT JOIN Students2Courses s2c
ON c.id = s2c.course_id
GROUP BY c.id;

# Выведите список студентов, с количеством курсов, посещаемых каждым студентом.
SELECT s.name, COUNT(s2c.course_id) AS cnt_cources
FROM Students s
LEFT JOIN Students2Courses s2c
ON s.id = s2c.student_id
GROUP BY s.id;





