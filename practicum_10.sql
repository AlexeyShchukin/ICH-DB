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

# Показать все департаменты в которых работают больше 30ти сотрудников
SELECT department_id, COUNT(employee_id) AS emp_qty
FROM employees
GROUP BY department_id
HAVING emp_qty > 30;

-- Получить список department_id в котором работают работники нескольких (>1) job_id
SELECT department_id
FROM employees
GROUP BY department_id
HAVING COUNT(DISTINCT job_id) > 1;

# Получить список manager_id у которых количество подчиненных больше 5 и
# сумма всех зарплат его подчиненных больше 50000
SELECT manager_id
FROM employees
GROUP BY manager_id
HAVING COUNT(employee_id) > 5
   AND SUM(salary) > 50000;

# Получить список manager_id, у которых средняя зарплата всех его подчиненных находится
# в промежутке от 6000 до 9000 и которые не получают бонусы (commission_pct пустой)
SELECT manager_id
FROM employees
WHERE commission_pct IS NULL
GROUP BY manager_id
HAVING AVG(salary) BETWEEN 6000 AND 9000;

# Получить список регионов и количество сотрудников в каждом регионе
SELECT r.region_name, COUNT(e.employee_id) AS count_emp
FROM regions r
         LEFT JOIN countries c ON r.region_id = c.region_id
         LEFT JOIN locations l ON c.country_id = l.country_id
         LEFT JOIN departments d ON l.location_id = d.location_id
         LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY r.region_name;

# Показать всех менеджеров которые имеют в подчинении больше 6ти сотрудников
SELECT m.first_name, m.last_name
FROM employees m
         LEFT JOIN employees e ON m.employee_id = e.manager_id
GROUP BY m.employee_id, m.first_name, m.last_name
HAVING COUNT(e.employee_id) > 6;

# Найдите отделы со средней зарплатой выше 75% от самой высокой средней зарплаты в отделе.
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
HAVING avg_salary > (SELECT MAX(t1.avg_s)
                     FROM (SELECT AVG(salary) AS avg_s
                           FROM employees
                           GROUP BY department_id) t1) * 0.75;


WITH t1 AS (SELECT AVG(salary) AS avg_s
            FROM employees
            GROUP BY department_id)

SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
HAVING avg_salary > (SELECT MAX(t1.avg_s)
                     FROM t1) * 0.75;

# Найдите сотрудников, которые зарабатывают больше, чем средняя зарплата в их отделе.
WITH avg_salary_in_department AS (SELECT department_id, AVG(salary) AS avg_salary
                                  FROM employees
                                  GROUP BY department_id)

SELECT employee_id
FROM employees e
         LEFT JOIN avg_salary_in_department asd
                   ON e.department_id = asd.department_id
WHERE e.department_id = asd.department_id
  AND e.salary > asd.avg_salary;