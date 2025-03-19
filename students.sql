CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(128) NOT NULL ,
    age INT
);

CREATE TABLE teachers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(128) NOT NULL,
    age INT
);

CREATE TABLE competencies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(128) NOT NULL
);

CREATE TABLE teacher2competencies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    teacher_id INT,
    competencies_id INT
);

CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    teacher_id INT,
    title VARCHAR(128) NOT NULL,
    headman_id INT
);

CREATE TABLE student2courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT
);

INSERT INTO students
VALUES (NULL, 'Анатолий', 29),
       (NULL, 'Олег', 25),
       (NULL, 'Семен', 27),
       (NULL, 'Олеся', 28),
       (NULL, 'Ольга', 31),
       (NULL, 'Иван', 22);

INSERT INTO teachers
VALUES (NULL, 'Петр', 39),
       (NULL, 'Максим', 35),
       (NULL, 'Антон', 37),
       (NULL, 'Всеволод', 38),
       (NULL, 'Егор', 41),
       (NULL, 'Светлана', 32);

INSERT INTO competencies
VALUES (NULL, 'Математика'),
       (NULL, 'Информатика'),
       (NULL, 'Программирование'),
       (NULL, 'Графика');

INSERT INTO teacher2competencies
VALUES (NULL, 1, 1),
       (NULL, 2, 1),
       (NULL, 2, 3),
       (NULL, 3, 2),
       (NULL, 4, 1),
       (NULL, 5, 3);

INSERT INTO courses
VALUES (NULL, 1, 'Алгебра логики', 2),
       (NULL, 2, 'Математическая статистика', 3),
       (NULL, 4, 'Высшая математика', 5),
       (NULL, 5, 'Javascript', 1),
       (NULL, 5, 'Базовый Python', 1);

INSERT INTO student2courses
VALUES (NULL, 1, 1),
       (NULL, 2, 1),
       (NULL, 3, 2),
       (NULL, 3, 3),
       (NULL, 4, 5);
