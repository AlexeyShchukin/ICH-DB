CREATE TABLE IF NOT EXISTS goods
(id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(100),
    quantity INT);

DESCRIBE goods;

INSERT INTO goods (title, quantity)
VALUES ('Дыня', 100);

INSERT INTO goods (title, quantity)
VALUES ('Арбуз', 50);

SELECT * FROM goods;

ALTER TABLE goods
ADD COLUMN price INT DEFAULT 0;

UPDATE goods
SET price = NULL;

ALTER TABLE goods
MODIFY price NUMERIC(8, 2);

ALTER TABLE goods
MODIFY price INT;

ALTER TABLE goods
RENAME COLUMN price TO item_price;

ALTER TABLE goods
CHANGE item_price price INT;

ALTER TABLE goods
DROP COLUMN price;
COMMIT;

INSERT INTO goods (title, quantity)
VALUES ('Яблоки', 200),
('Груши', 150),
('Мандарины', 250),
('Апельсины', 170);

ALTER TABLE goods
ADD in_stock CHAR(1);

UPDATE goods
SET in_stock = 'Y'
WHERE quantity < 50;

UPDATE goods
SET in_stock = 'N'
WHERE in_stock is NULL;

ALTER TABLE goods
MODIFY COLUMN quantity NUMERIC(8, 2);

SELECT * FROM goods
ORDER BY in_stock;
