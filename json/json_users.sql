# Напишите запрос для извлечения имени и возраста всех пользователей из
# информационного столбца JSON.
SELECT info->>'$.name' AS name,
       info->>'$.age' AS age
       FROM users;

# Напишите запрос, чтобы найти всех пользователей, в списке навыков которых есть «Python».
SELECT * FROM users
WHERE JSON_CONTAINS(info -> '$.skills', '"Python"');

# Боб только что изучил MySQL! Обновите список навыков Боба, включив в него "MySQL".
UPDATE users
SET info = JSON_SET(info, '$.skills', JSON_ARRAY(info ->> '$.skills', 'MySQL'))
WHERE JSON_EXTRACT(info, '$.name')  = 'Bob';

UPDATE users
SET info = JSON_SET(info, '$.skills', JSON_ARRAY('Django', 'Flask'))
WHERE JSON_EXTRACT(info, '$.name')  = 'Bob';

UPDATE users
SET info = JSON_SET(info, '$.skills', JSON_ARRAY_APPEND(info -> '$.skills', '$', 'MySQL'))
WHERE JSON_EXTRACT(info, '$.name') = 'Bob';

# Напишите запрос, чтобы подсчитать, сколько пользователей имеют «JavaScript»
# в своем списке навыков.
SELECT COUNT(*) AS users_amount FROM users
WHERE JSON_CONTAINS(info -> '$.skills', '"JavaScript"');

# Напишите запрос, который возвращает массив JSON, содержащий имена всех пользователей.
SELECT JSON_ARRAYAGG(info -> '$.name') FROM users;