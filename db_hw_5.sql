SELECT name, population
FROM world.city
UNION
(SELECT name, population
 FROM world.country);

# Task 3
SHOW CREATE TABLE world.countrylanguage;
# Все столбцы не могут иметь нулевые значения, заданы дефолтные значения и
# primary key для `CountryCode` и `Language` (ненулевые, уникальные)

CREATE TABLE citizen
(
    id         INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    insurance  VARCHAR(128),
    first_name VARCHAR(128),
    last_name  VARCHAR(128),
    email      VARCHAR(128)
);

DROP TABLE citizen;

CREATE TABLE people
(
    id         INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name  VARCHAR(50),
    age        INT
);

INSERT INTO people (first_name, last_name, age)
VALUES ('Alex', 'Smith', 30),
       ('Alex', 'Johnson', 25),
       ('Alex', 'Brown', 28),
       ('John', NULL, 40),
       ('Emily', NULL, 35);

ALTER TABLE people
    MODIFY first_name VARCHAR(128) NOT NULL;

ALTER TABLE people
    MODIFY last_name VARCHAR(128) NOT NULL;

ALTER TABLE people
    ADD CONSTRAINT first_last_unique UNIQUE (first_name, last_name);

DROP TABLE people;

CREATE TABLE people
(
    id         INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL UNIQUE,
    last_name  VARCHAR(50) NOT NULL UNIQUE,
    age        INT
);

INSERT INTO people (first_name, last_name, age)
VALUES
    ('Alice', 'Brown', 30),
    ('Bob', 'Smith', 25),
    ('Charlie', 'Johnson', 40);

INSERT INTO people (first_name, last_name, age)
VALUES
    ('Alice', 'Williams', 29); # повторяющееся имя

INSERT INTO people (first_name, last_name, age)
VALUES
    ('David', 'Brown', 35); # повторяющаяся фамилия
