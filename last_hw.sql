SELECT title, rating,
    CASE rating
        WHEN 'G' THEN 'Для широкой аудитории'
        WHEN 'PG' THEN 'Рекомендуется родительское наблюдение'
        WHEN 'PG-13' THEN 'Родителям настоятельно рекомендуется наблюдение'
        WHEN 'R' THEN 'Ограничено'
        WHEN 'NC-17' THEN 'Только для взрослых'
    END AS rate_desc
FROM film;

SELECT rating, COUNT(*) AS count_films FROM film
GROUP BY rating;

SELECT title, rating,
       COUNT(*) OVER(PARTITION BY rating) AS count_films
FROM film;

SELECT p.payment_id, c.first_name, c.last_name, p.amount, p.payment_date
FROM customer c
RIGHT JOIN payment p
ON c.customer_id = p.customer_id;

SELECT p.payment_id, c.first_name, c.last_name, p.amount,
       DATE_FORMAT(p.payment_date, '%d-%M-%Y') AS payment_date
FROM customer c
RIGHT JOIN payment p
ON c.customer_id = p.customer_id;
