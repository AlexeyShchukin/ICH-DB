-- Работаем с базой данных sakila (fiction movies database).
USE sakila;

-- 1. Выведите количество фильмов в таблице film.
SELECT COUNT(*) FROM film;

-- 2. Выведите список категорий фильмов.
SELECT name FROM category;

-- 3. Выведите все фильмы в категории на ваше усмотрение, например, все комедии (Comedy).
SELECT c.name, f.title FROM film f
JOIN film_category fc USING(film_id)
JOIN category c USING(category_id)
WHERE c.name = 'Comedy';

-- 4. Выведите список всех актёров с количеством фильмов в которых снимался каждый.
SELECT a.first_name,
       a.last_name,
       COUNT(film_id) AS count_films
FROM actor a
JOIN film_actor fa USING(actor_id)
GROUP BY a.actor_id;

-- 5. Выведите список языков и количество фильмов на каждом языке.
SELECT l.name,
       COUNT(f.film_id) AS count_films
FROM language l
JOIN film f USING(language_id)
GROUP BY l.name;

-- 6. Выведите имя актёра, который снялся в самом большом количестве фильмов.
SELECT a.first_name,
       a.last_name,
       COUNT(film_id) AS count_films
FROM actor a
JOIN film_actor fa USING(actor_id)
GROUP BY a.actor_id
ORDER BY count_films DESC
LIMIT 1;

-- 7. Выведите актёров, которые снялись более, чем в 5 фильмах.
SELECT a.first_name,
       a.last_name,
       COUNT(film_id) AS count_films
FROM actor a
JOIN film_actor fa USING(actor_id)
GROUP BY a.actor_id
HAVING COUNT(film_id) > 5;

-- 8. Выведите список актёров по их рангу в зависимости от количества фильмов
SELECT a.first_name,
       a.last_name,
       COUNT(fa.film_id) AS count_films,
       DENSE_RANK() OVER(ORDER BY COUNT(film_id) DESC) AS rank_by_count
FROM actor a
JOIN film_actor fa USING(actor_id)
GROUP BY a.actor_id;