CREATE TABLE IF NOT EXISTS weather
(city VARCHAR(30), forecast_date DATE, temperature INT);

SELECT * FROM weather;

INSERT INTO weather
VALUES ('Berlin', '2023-08-29', 30);

INSERT INTO weather
VALUES ('Magdeburg', '2024-05-19', 25),
('Dusseldorf', '2024-12-22', 6),
('Hamburg', '2022-03-10', 11);

SELECT * FROM weather;

UPDATE weather
SET temperature = 26
WHERE city = 'Berlin';

UPDATE weather
SET city = 'Paris'
WHERE temperature > 25;

ALTER TABLE weather
ADD COLUMN min_temp INT;

UPDATE weather
SET min_temp = 0;
