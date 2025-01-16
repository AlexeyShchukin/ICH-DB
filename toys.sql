CREATE TABLE toys1
(
    toy_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    toy_name VARCHAR(100) NULL,
    weight INT NULL);

INSERT INTO toys1 (toy_name, weight)
VALUES ('Велосипед', 10);

INSERT INTO toys1 (toy_name, weight)
VALUES ('Самокат', 5);

UPDATE toys1
SET weight = 15
WHERE toy_name = 'Велосипед';

TRUNCATE toys1;

DROP TABLE IF EXISTS toys1;

COMMIT;
