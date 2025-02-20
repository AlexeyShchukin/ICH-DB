# 1. Вывести все поездки (trips) с указанием названия airliner
USE airport;

SELECT t.*, a.model_name AS airliner
FROM trips t
LEFT JOIN airliners a
ON t.airliner_id = airliner_id;

# 2. Вывести все билеты, с указанием имени клиента
SELECT t.*, c.name AS client_name
FROM tickets t
LEFT JOIN clients c
ON t.client_id = c.id;

# 3. Вывести количество поездок по каждому airliner с указанием названия типа самолета
SELECT a.model_name, COUNT(t.id) AS cnt_trips
FROM trips t
RIGHT JOIN airliners a
ON t.airliner_id = a.id
GROUP BY a.id;

# 4. Вывести количество пассажиров для каждой поездки
SELECT tr.trip_code, COUNT(c.id) AS cnt_clients
FROM trips tr
LEFT JOIN tickets ti
ON tr.id = ti.trip_id
LEFT JOIN clients c
ON ti.client_id = c.id
GROUP BY tr.id;

# Вывести количество тикетов для каждой поездки, где тикетов больше 1
SELECT * FROM (SELECT tr.trip_code, COUNT(tr.id) AS cnt_tickets
FROM trips tr
LEFT JOIN tickets ti
ON tr.id = ti.trip_id
GROUP BY tr.id) t1
WHERE t1.cnt_tickets > 1;

SELECT tr.trip_code, COUNT(tr.id) AS cnt_tickets
FROM trips tr
LEFT JOIN tickets ti
ON tr.id = ti.trip_id
GROUP BY tr.id
HAVING cnt_tickets > 1;

# 5. Посчитать количество поездок для каждого типа airliner.
# Поменяйте запрос и использованием joins так, чтобы выводилось название модели самолета.
SELECT a.model_name, COUNT(t.id) AS cnt_trips
FROM airliners a
LEFT JOIN trips t
ON a.id = t.airliner_id
GROUP BY a.id;

# 6. Посчитать количество билетов в каждой поездки и выведите список по убыванию количества
# билетов.
SELECT tr.trip_code, COUNT(ti.id) AS cnt_tickets
FROM trips tr
LEFT JOIN tickets ti
ON tr.id = ti.trip_id
GROUP BY tr.id
ORDER BY cnt_tickets DESC;

# 7. Посчитать, какой процент поездок успешен и какой процент отменен.
SELECT ROUND(COUNT(IF(status='Arrived', status, NULL)) / COUNT(status) * 100) AS arrived_percent,
ROUND(COUNT(IF(status='Cancelled', status, NULL)) / COUNT(status) * 100) AS cancelled_percent
FROM trips;

# 8. Вывести топ клиентов (по clients_id) которые делали наибольшее количество успешных поездок.
SELECT c.id, COUNT(IF(tr.status='Arrived', tr.id, NULL)) cnt_trips
FROM clients c
LEFT JOIN tickets ti
ON c.id = ti.client_id
LEFT JOIN trips tr
ON ti.trip_id = tr.id
GROUP BY c.id
ORDER BY cnt_trips DESC;

# 9. Сделать группировку по сервис классу которым пользовались клиенты. В итоге выведите
# количество клиентов в каждом классе.
SELECT t.service_class, COUNT(c.id) AS cnt_clients
FROM tickets t
LEFT JOIN clients c
ON t.client_id = c.id
GROUP BY t.service_class;

# 10. Повторить прошлый запрос, но теперь с условием - если клиент пользовался несколькими
# классами, то его нужно вывести в новую группу “Мульти”.
SELECT c.id AS client_id, IF(COUNT(t.service_class) > 1, 'Мульти', t.service_class) AS classes
FROM tickets t
RIGHT JOIN clients c
ON t.client_id = c.id
GROUP BY c.id;