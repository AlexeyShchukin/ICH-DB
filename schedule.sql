CREATE TABLE IF NOT EXISTS schedule
(
subject_name VARCHAR(50),
teacher VARCHAR(50),
date DATE,
pair_number INT
);

INSERT INTO schedule
VALUES ('Математика',
        'Загвоздина Ксения',
        '2025-01-13', 1),
    ('Программирование',
        'Вячеслав',
        '2025-01-13', 2),
    ('Математика',
        'Загвоздина Ксения',
        '2025-01-14', 2),
    ('Программирование',
        'Вячеслав',
        '2025-01-14', 1),
    ('Литература',
        'Илья',
        '2025-01-14', 3),
    ('Литература',
        'Илья',
        '2025-01-15', 1),
    ('Программирование',
        'Вячеслав',
        '2025-01-16', 2),
    ('Математика',
        'Загвоздина Ксения',
        '2025-01-16', 3),
    ('Математика',
        'Загвоздина Ксения',
        '2025-01-17', 1),
    ('Литература',
        'Илья',
        '2025-01-17', 3);


SELECT * FROM schedule;

ALTER TABLE schedule
ADD COLUMN time VARCHAR(5);

UPDATE schedule
SET time = '09:30'
WHERE pair_number = 1;

UPDATE schedule
SET time = '11:00'
WHERE pair_number = 2;

UPDATE schedule
SET time = '12:30'
WHERE pair_number = 3;

ALTER TABLE schedule
MODIFY time time;

# UPDATE schedule
# SET time = STR_TO_DATE(time, '%H.%i')

SELECT * FROM schedule
ORDER BY date;

UPDATE schedule
SET subject_name = 'Физкультура'
WHERE subject_name = 'Литература';

COMMIT;

SELECT @@autocommit;

