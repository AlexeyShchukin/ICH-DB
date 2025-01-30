CREATE TABLE students1
(
    id         INT          NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(128) NOT NULL,
    last_name  VARCHAR(128) NOT NULL,
    age        INT(3) CHECK (age >= 17 AND age < 40)
);

DESCRIBE students1;
SHOW CREATE TABLE students1;

ALTER TABLE students1
    ADD email VARCHAR(128) UNIQUE;

INSERT INTO students1 (first_name, last_name, age, email)
VALUES ('John', 'Doe', 25, 'johndoe@gmail.com'),
       ('Jane', 'Doe', 22, 'janedoe@gmail.com'),
       ('Alice', 'Smith', 30, 'alicesmith@gmail.com');

ALTER TABLE students1
    ADD CONSTRAINT unique_first_last_name UNIQUE (first_name, last_name);

DESCRIBE students1;

SHOW CREATE TABLE students1;

ALTER TABLE students1
    ADD CONSTRAINT valid_email CHECK (email LIKE '%@%');

CREATE TABLE new_students AS (SELECT employee_id, first_name, last_name, email
                              FROM hr.employees);

DROP TABLE new_students;

SELECT first_name, last_name
FROM students1
UNION ALL
(SELECT first_name, last_name FROM new_students);

CREATE TABLE holand AS (SELECT c.*
                        FROM world.city c
                        WHERE c.CountryCode = 'NLD');

DESCRIBE holand;

SHOW CREATE TABLE holand;

SHOW CREATE TABLE world.city;
