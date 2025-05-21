SELECT title FROM film
WHERE title LIKE "% LION%" OR title LIKE "% LION %" OR title LIKE "LION%";

SELECT count(*) as count_films FROM film
WHERE title LIKE "% LION%" OR title LIKE "% LION %" OR title LIKE "LION%";

SELECT f.title FROM film f
JOIN film_category fc USING(film_id)
JOIN category c USING (category_id)
WHERE c.name = "Horror";

SELECT f.title, c.name FROM film f
JOIN film_category fc USING(film_id)
JOIN category c USING (category_id);

SELECT * FROM (
SELECT title, length,
       DENSE_RANK() OVER(ORDER BY length DESC) AS _rank
FROM film) t1
WHERE _rank <= 10;


SELECT c.name, count(f.title) AS count_films
FROM film f
JOIN film_category fc USING(film_id)
JOIN category c USING (category_id)
GROUP BY c.name;

SELECT c.name, count(*) AS count_films
FROM film_category fc
JOIN category c USING (category_id)
GROUP BY c.name
HAVING count(*) > 20;

SELECT * FROM (
SELECT f.title, c.name,
       AVG(f.length) OVER(PARTITION BY c.name) AS avg_length,
       DENSE_RANK() OVER(PARTITION BY c.name ORDER BY f.length) AS length_rank
FROM film f
JOIN film_category fc USING(film_id)
JOIN category c USING (category_id)) t1
WHERE t1.length_rank <= 5;

SELECT * FROM (
SELECT ci.city, cu.first_name, cu.last_name,
       count(r.rental_id) as count_rents,
       DENSE_RANK() OVER (PARTITION BY ci.city ORDER BY count(r.rental_id) DESC) as rents_rank
FROM city ci
JOIN address a USING(city_id)
JOIN customer cu USING(address_id)
JOIN rental r USING (customer_id)
GROUP BY ci.city_id, cu.customer_id) t1
WHERE rents_rank <= 3;

SELECT c.city,
       DATE_FORMAT(p.payment_date, "%Y-%m") as date_f,
       SUM(p.amount) as month_payment, ROUND((SUM(p.amount) - LAG(SUM(p.amount),1) OVER(PARTITION BY c.city ORDER BY DATE_FORMAT(p.payment_date, "%Y-%m"))) / LAG(SUM(p.amount), 1) OVER(PARTITION BY c.city ORDER BY DATE_FORMAT(p.payment_date, "%Y-%m")) * 100, 2) AS prcnt
FROM city c
JOIN address a ON c.city_id = a.city_id
JOIN customer c2 ON a.address_id = c2.address_id
JOIN payment p ON c2.customer_id = p.customer_id
GROUP BY c.city, date_f