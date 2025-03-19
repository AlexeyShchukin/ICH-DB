CREATE TABLE customers
(
    id                INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name        VARCHAR(50),
    last_name         VARCHAR(50),
    street            VARCHAR(50),
    post_code         INT,
    city              VARCHAR(50),
    country           VARCHAR(50),
    email             VARCHAR(50),
    registration_date DATE
);

CREATE TABLE orders
(
    id               INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id      INT,
    order_date       DATE,
    good_id          INT,
    good_description VARCHAR(255),
    price            NUMERIC(10, 2)
);

INSERT INTO customers (first_name, last_name, street, post_code, city, country, email, registration_date)
VALUES ('John', 'Doe', '123 Elm Street', 12345, 'Springfield', 'USA', 'john.doe@example.com', '2025-01-01'),
       ('Jane', 'Smith', '456 Maple Avenue', 67890, 'Shelbyville', 'USA', 'jane.smith@example.com', '2025-01-15'),
       ('Robert', 'Brown', '789 Oak Lane', 54321, 'Centerville', 'Canada', 'robert.brown@example.ca', '2024-12-31'),
       ('Alice', 'Johnson', '321 Pine Road', 98765, 'Lakeside', 'UK', 'alice.johnson@example.co.uk', '2023-07-20'),
       ('Emily', 'White', '654 Cedar Blvd', 11111, 'Greentown', 'Australia', 'emily.white@example.au', '2025-01-20');

INSERT INTO orders
VALUES (NULL, 3, '2025-01-01', 2, 'Арбузы 5 шт.', 35.5),
       (NULL, 1, '2025-01-02', 5, 'Мандарины 20 шт.', 10.7),
       (NULL, 2, '2025-01-17', 6, 'Апельсины 15 шт.', 15.1),
       (NULL, 3, '2025-01-02', 6, 'Апельсины 10 шт.', 10.7),
       (NULL, 1, '2025-01-03', 6, 'Апельсины 30 шт.', 30.4),
       (NULL, 4, '2023-08-20', 4, 'Груши 10 шт.', 25.35),
       (NULL, 4, '2024-09-19', 3, 'Яблоки 40 шт.', 29.8),
       (NULL, 5, '2025-01-22', 1, 'Дыня 5 шт.', 41.8),
       (NULL, 2, '2025-01-22', 5, 'Мандарины 50 шт.', 31.6),
       (NULL, 2, '2025-01-19', 3, 'Яблоки 25 шт.', 27.2);

ALTER TABLE customers
    ADD last_modified TIMESTAMP DEFAULT current_timestamp;

ALTER TABLE customers
    DROP last_modified;

ALTER TABLE customers
    ADD last_modified DATE DEFAULT (NOW());

ALTER TABLE orders
    ADD discounter_price DECIMAL(10, 2);

UPDATE orders
SET discounter_price = price * 0.9;
