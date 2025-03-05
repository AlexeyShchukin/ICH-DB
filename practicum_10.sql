USE airport;

# 1. Выведите количество лайнеров в каждом году.
# 2. Выведите количество лайнеров в каждом году с годами, где количеством лайнеров больше 1.
SELECT a.production_year, COUNT(*) AS count_boards
FROM airliners a
GROUP BY a.production_year
HAVING count_boards > 1;

# 3. Выведите список client_id, amount_of_tickets (таблица tickets), который содержит айди клиентов и
# количество билетов у каждого.
# 4. Выведите только тех клиентов, у которых больше 2 билетов.
SELECT client_id, COUNT(id) AS cnt_tickets
FROM tickets
GROUP BY client_id
HAVING cnt_tickets > 2;

# 5. Измените запрос так, чтобы вместо айди клиентов выводились их имена (join с таблицей clients).
SELECT c.name, COUNT(t.id) AS cnt_tickets
FROM tickets t
         JOIN clients c
              ON t.client_id = c.id
GROUP BY c.name
HAVING cnt_tickets > 2;

# 6. Выведите среднюю стоимость билетов в каждом сервисном классе
SELECT service_class, ROUND(AVG(price), 2) avg_price
FROM tickets
GROUP BY service_class

# 7. Выведите список самых популярных аэропортов отправления (trips departures).
SELECT departure
FROM trips
GROUP BY departure
HAVING COUNT(id) =
       (SELECT MAX(t1.trips_amt)
        FROM (SELECT COUNT(id) trips_amt
              FROM trips
              GROUP BY departure) t1)

# 8. Выведите самого молодого клиента.
SELECT *
FROM clients
WHERE age = (SELECT MIN(age) AS youngest
             FROM clients);

# 9. Выведите имена клиентов, код аэропорта отправления и прибытия (выборка из tickets и join с clients
# и с trips).
SELECT c.name, tr.departure, tr.arrival
FROM tickets ti
         RIGHT JOIN clients c
                    ON ti.client_id = c.id
         LEFT JOIN trips tr
                   ON ti.trip_id = tr.id;

# 10. Выведите имена клиентов, чьи поездки (trips) были отменены.
SELECT c.name
FROM tickets ti
         RIGHT JOIN clients c
                    ON ti.client_id = c.id
         LEFT JOIN trips tr
                   ON ti.trip_id = tr.id
WHERE tr.status = 'Cancelled';

USE hr;
# Сколько сотрудников имена которых начинается с одной и той же буквы?
# Сортировать по количеству.
# Показывать только те, где количество больше 1
SELECT LEFT(first_name, 1) AS first_letter, COUNT(*) cnt_emps
FROM employees
GROUP BY first_letter
HAVING cnt_emps > 1
ORDER BY cnt_emps;

SELECT SUBSTRING(first_name, 1, 1) f_initials
     , COUNT(*)                    c_f_initials
FROM employees
GROUP BY f_initials
HAVING c_f_initials > 1
ORDER BY c_f_initials DESC;

# Получить репорт сколько сотрудников приняли на работу в каждый день недели. Сортировать по количеству
SELECT DATE_FORMAT(hire_date, '%W') AS weekdays,
       COUNT(employee_id)           AS cnt_emps
FROM employees
GROUP BY weekdays
ORDER BY cnt_emps;

# Получить репорт сколько сотрудников приняли на работу по годам. Сортировать по количеству.
# Найти года с максимальным количеством нанятых сотрудников
SELECT EXTRACT(YEAR FROM hire_date) AS hire_year,
       COUNT(employee_id)           AS cnt_emps
FROM employees
GROUP BY hire_year
HAVING cnt_emps =
       (SELECT MAX(t1.cnt_emps)
        FROM (SELECT EXTRACT(YEAR FROM hire_date) AS hire_year,
                     COUNT(employee_id)           AS cnt_emps
              FROM employees
              GROUP BY hire_year
              ORDER BY cnt_emps) t1);