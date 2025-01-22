SELECT *
FROM orders
ORDER BY price DESC;

SELECT *
FROM customers
WHERE email like '%@gmail.com';

SELECT *,
       CASE
           WHEN price < 20 THEN 'low'
           WHEN price < 30 THEN 'middle'
           WHEN price >= 30 THEN 'high'
           ELSE NULL
           END AS status
FROM orders;

SELECT *
FROM customers
WHERE city = 'Lakeside';

SELECT *, COUNT(*) AS best_seller
FROM orders
GROUP BY good_id
ORDER BY best_seller DESC
LIMIT 1;

/* 7. Вывести список заказов с максимальной скидкой.
   У нас у всех товаров уже задана скидка 10%.
   Разницу можно посчитать только в валюте. Тогда не будет списка максимальных,
   а будет либо список самых больших из n-го количества строк, либо одна максимальная.
   Я вывел одну максимальную */

CREATE VIEW view_1 AS
SELECT *, price - discounter_price AS discount
FROM orders;

SELECT *
FROM view_1
ORDER BY discount DESC
LIMIT 1;

SELECT *, ROUND(100 - discounter_price / price * 100) AS discount_percent
FROM orders;
