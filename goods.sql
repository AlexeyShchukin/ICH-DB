CREATE TABLE IF NOT EXISTS goods
(id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(100),
    quantity INT);

DESCRIBE goods;

INSERT INTO goods (title, quantity)
VALUES ("Дыня", 100);

INSERT INTO goods (title, quantity)
VALUES ("Арбуз", 50);

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

