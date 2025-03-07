create database if not exists json_exercise;

use json_exercise;

drop table if exists friends;

create table if not exists friends(
	id int auto_increment primary key,
    friend json
);

INSERT INTO friends (friend) VALUES
    ('{"name": "Alice", "age": 25, "eye_color": "green"}'),
    ('{"name": "Bob", "age": 30, "eye_color": "brown"}'),
    ('{"name": "Charlie", "age": 28, "eye_color": "blue"}');

SELECT * FROM friends;

SELECT friend->>'$.name' AS `name` FROM friends;

SELECT friend->>'$.age' AS age FROM friends;

UPDATE friends 
SET friend = JSON_SET(friend, '$.age', 26) 
WHERE id = 1;

select * from friends;

UPDATE friends 
SET friend = JSON_REMOVE(friend, '$.eye_color') 
WHERE id = 1;

select * from friends;

UPDATE friends 
SET friend = JSON_SET(friend, '$.eye_color', 'green') 
WHERE id = 1;

select * from friends;

SELECT * FROM friends 
WHERE JSON_CONTAINS(friend->'$.eye_color', '"brown"');

SELECT JSON_EXTRACT(friend, '$.eye_color') FROM friends;

SELECT JSON_ARRAY('brown', 'green');

SELECT * FROM friends;

UPDATE friends
SET friend = JSON_SET(friend, '$.eye_color', JSON_ARRAY(friend->>'$.eye_color', 'blue'))
WHERE id = 1;

SELECT * FROM friends;

SELECT JSON_OBJECT('name', 'Alice', 'age', 25);

SELECT JSON_ARRAYAGG(friend) FROM friends;

-- Напишите запрос для извлечения имени и возраста всех пользователей из информационного столбца JSON.
-- Напишите запрос, чтобы найти всех пользователей, в списке навыков которых есть «Python».
-- Боб только что изучил MySQL! Обновите список навыков Боба, включив в него "MySQL".
-- Напишите запрос, чтобы подсчитать, сколько пользователей имеют «JavaScript» в своем списке навыков.
-- Напишите запрос, который возвращает массив JSON, содержащий имена всех пользователей.