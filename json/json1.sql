-- {
--   "user_id": 101,
--   "name": "John Doe",
--   "email": "john.doe@example.com",
--   "address": {
--     "street": "123 Main St",
--     "city": "New York",
--     "state": "NY",
--     "zip": "10001"
--   },
--   "phone_numbers": [
--     {"type": "mobile", "number": "555-1234"},
--     {"type": "home", "number": "555-5678"}
--   ],
--   "preferences": {
--     "newsletter": true,
--     "sms_notifications": false
--   },
--   "membership": {
--     "status": "active",
--     "join_date": "2022-01-15"
--   }
-- }
-- $.address.street

select * from cities;
# вставляем в таблицу значения в колонку city Katmandu, в колонку streets - json со списком городов
insert into cities (city, streets) values ('Katmandu', '{"streets": []}');

# вычисляем длину массива в json и записываем в переменную
select json_length(streets, "$.streets") into @street_counter from cities where id = 0;

update cities
set streets = json_set(streets, concat("$.streets[", cast(@street_counter as char(10)), "]"), "Main str.")
where id = 0;
# добавляем улицу в массив на позицию с индексом равным длине массива, т.е. последним элементом
# cast преобразует число из переменной в строку, чтобы сконкатенировать и получить формат типа "$.streets[3]"

select json_length(streets, "$.streets") into @street_counter from cities where id = 0;

update cities
set streets = json_set(streets, concat("$.streets[", cast(@street_counter as char(10)), "]"), "Street1 str.")
where id = 0;

select json_length(streets, "$.streets") into @street_counter from cities where id = 0;

update cities
set streets = json_set(streets, concat("$.streets[", cast(@street_counter as char(10)), "]"), "Street2 str.")
where id = 0;


update cities
set streets = json_set(streets, "$.streets[3]", "Street3 str.")
where id = 0;

select * from cities;

set @abc = 123;

select @abc;

select json_length(streets, "$.streets") from cities where id = 0;