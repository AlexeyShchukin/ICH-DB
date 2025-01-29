CREATE TABLE students1 (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(128) NOT NULL,
    last_name VARCHAR(128) NOT NULL,
    age INT(3) CHECK (age >= 17 AND age < 40)
);

DESCRIBE students1;
SHOW CREATE TABLE students1;

ALTER TABLE students1
ADD email VARCHAR(128) UNIQUE;

INSERT INTO students1 (first_name, last_name, age, email)
VALUES
    ('John', 'Doe', 25, 'johndoe@gmail.com'),
    ('Jane', 'Doe', 22, 'janedoe@gmail.com'),
    ('Alice', 'Smith', 30, 'alicesmith@gmail.com');

ALTER TABLE students1
ADD CONSTRAINT unique_first_last_name UNIQUE (first_name, last_name);

ALTER TABLE students1
DROP CONSTRAINT first_name;

DESCRIBE students1;

SHOW CREATE TABLE students1;

ALTER TABLE students1
ADD CONSTRAINT valid_email CHECK(email LIKE '%@%');
