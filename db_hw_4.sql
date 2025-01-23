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

SELECT good_id, COUNT(*) AS best_seller
FROM orders
GROUP BY good_id
ORDER BY best_seller DESC
LIMIT 1;

CREATE VIEW view_1 AS
SELECT *, price - discounter_price AS discount
FROM orders;
SELECT *, MAX(discount) AS max_discount
FROM view_1;

SELECT *, ROUND(100 - discounter_price / price * 100) AS discount_percent
FROM orders;
