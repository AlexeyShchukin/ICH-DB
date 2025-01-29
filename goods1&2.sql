CREATE TABLE IF NOT EXISTS goods1
(
    id       INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `title`  VARCHAR(30),
    quantity INT CHECK (quantity >= 0),
    in_stock CHAR(1) CHECK (in_stock in ('y', 'n'))
);

INSERT INTO goods1 (title, quantity, in_stock)
VALUES ('Table', 3, 'y'),
       ('Chair', 10, 'y'),
       ('Lamp', 0, 'n'),
       ('Sofa', 2, 'y'),
       ('Cupboard', 0, 'n');

CREATE TABLE IF NOT EXISTS goods2
(
    id       INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `title`  VARCHAR(30),
    quantity INT CHECK (quantity >= 0),
    in_stock CHAR(1) CHECK (in_stock in ('y', 'n')),
    price    INT
);

DROP TABLE goods1;

INSERT INTO goods2 (title, quantity, in_stock, price)
VALUES ('Laptop', 5, 'y', 1000),
       ('Mouse', 10, 'y', 50),
       ('Keyboard', 8, 'y', 80),
       ('Monitor', 3, 'y', 300),
       ('Printer', 0, 'n', 150),
       ('Headphones', 6, 'y', 120),
       ('USB Cable', 15, 'y', 10),
       ('External HDD', 4, 'y', 200),
       ('Webcam', 7, 'y', 90),
       ('Speakers', 0, 'n', 130);

SELECT *, NULL AS price
FROM goods1
UNION ALL
(SELECT * FROM goods2);

SELECT title
FROM goods1
UNION
(SELECT title FROM goods2);