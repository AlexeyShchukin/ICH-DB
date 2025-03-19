# Вывести текущую дату и время.
SELECT NOW();

# Вывести текущий год и месяц
SELECT DATE_FORMAT(NOW(), '%Y-%M');

# Вывести текущее время
SELECT EXTRACT(HOUR FROM NOW());

# Вывести название текущего дня недели
SELECT
    CASE WEEKDAY(NOW())
        WHEN 0 THEN 'Понедельник'
        WHEN 1 THEN 'Вторник'
        WHEN 2 THEN 'Среда'
        WHEN 3 THEN 'Четверг'
        WHEN 4 THEN 'Пятница'
        WHEN 5 THEN 'Суббота'
        WHEN 6 THEN 'Воскресенье'
    END AS day_of_week;

SELECT DAYNAME(NOW());

# Вывести номер текущего месяца
SELECT EXTRACT(MONTH FROM NOW());

# Вывести номер дня в дате “2020-03-18”
SELECT EXTRACT(DAY FROM '2020-03-18');

# Подключиться к базе данных shop (которая находится на удаленном сервере)
USE shop;

# Определить какие из покупок были совершены в апреле (4-й месяц)
SELECT * FROM ORDERS
WHERE EXTRACT(MONTH FROM ODATE) = 4;

# Определить количество покупок в 2022-м году
SELECT COUNT(*) FROM ORDERS
WHERE DATE_FORMAT(ODATE, '%Y') = 2022;

# Определить, сколько покупок было совершено в каждый день. Отсортировать строки в
# порядке возрастания количества покупок. Вывести два поля - дату и количество покупок
SELECT ODATE, COUNT(*) AS orders_amount
FROM ORDERS
GROUP BY ODATE
ORDER BY orders_amount;

# Определить среднюю стоимость покупок в апреле
SELECT AVG(AMT)
FROM ORDERS
WHERE EXTRACT(MONTH FROM ODATE) = 4;