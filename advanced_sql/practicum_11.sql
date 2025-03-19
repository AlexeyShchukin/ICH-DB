-- 1. Вывести список model_name всех самолетов (airliners) и количество всех самолетов в таблице. 
-- Подсказка: работаем с таблицей airliners, использовать
-- оконную функцию over() и суммировать count(id).
USE airport;

SELECT DISTINCT model_name,
COUNT(id) OVER () plane_amnt
FROM airliners;

# Изменить предыдущий запрос таким образом, чтобы для каждого типа самолетов (model_name) выводилось количество самолетов этого типа. 
# Подсказка: добавить partition by model_name в over().
SELECT DISTINCT model_name,
COUNT(id) OVER (PARTITION BY model_name) plane_amnt
FROM airliners;

# Работаем с таблицей tickets. Написать запрос, который выводит список client_id и количество билетов у каждого клиента.
SELECT client_id,
COUNT(id) OVER(PARTITION BY client_id)
FROM tickets;

# Изменить запрос таким образом, чтобы вместо client_id выводилось имя клиента из таблицы clients.
SELECT client_id, c.name,
COUNT(t.id) OVER(PARTITION BY t.client_id) AS cnt_tickets
FROM tickets t
LEFT JOIN clients c
ON t.client_id = c.id
ORDER BY cnt_tickets DESC;

# Вывести список сервисных классов со средней стоимостью билета в каждом классе. 
SELECT
	DISTINCT service_class,
	AVG(price) OVER (PARTITION BY service_class) avg_class
FROM
	tickets;

# Вывести список сервисных классов со средней ценой в каждой классе и ранком каждого класса в зависимости от 
# средней цены в сервисном классе. 
SELECT t.service_class,
AVG(t.price) avg_classprice,
RANK() OVER(ORDER BY AVG(t.price) DESC) class_rank
FROM tickets t
GROUP BY t.service_class;

# Вывести количество билетов для каждой поездки.
SELECT tr.id,
COUNT(tic.id) OVER(PARTITION BY tr.id) AS cnt_tickets
FROM trips tr 
LEFT JOIN tickets tic
ON tr.id = tic.trip_id;

# Вывести топ 2 поездок (trips) по их средней стоимости. 
# Поездка может состоять из нескольких перелетов (поэтому на каждую поездку может приходиться больше одного билета).
SELECT * FROM (SELECT
	trip_id,
	count(id) AS cnt_id,
	avg(price) AS avg_price,
	DENSE_RANK() OVER(ORDER BY avg(price) DESC) class_rank
FROM tickets
GROUP BY trip_id) sel
where class_rank < 3;