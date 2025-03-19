SELECT * FROM task1
ORDER BY date_add DESC
LIMIT 1;

SELECT MAX(date_add) AS latest
FROM task1;

SELECT DISTINCT concat_ws(' ', first_name, 'Developer')
FROM task1
GROUP BY first_name;

SELECT concat('Д', SUBSTRING(prize, 2, 1))
FROM task1
WHERE is_have in (0,1) AND prize like '%p%'; # английская p

