create table if not exists employees(
	employee_id int not null,
    first_name varchar(127),
    last_name varchar(127),
    hourly_pay decimal(10, 2)
);

select * from employees;

INSERT INTO employees (employee_id, first_name, last_name, hourly_pay)
VALUES
(1, 'John', 'Doe', 25.50),
(2, 'Jane', 'Smith', 28.75),
(3, 'Michael', 'Johnson', 30.00),
(4, 'Emily', 'Davis', 27.80),
(5, 'Daniel', 'Wilson', 26.25);

select * from employees;

alter table employees
add column salary decimal(10, 2);

select * from employees;

update employees
set salary = hourly_pay*2080;

select * from employees;

update employees
set hourly_pay = hourly_pay + 1
where employee_id = 1;

create trigger before_hourly_pay_update
before update on employees
for each row
set new.salary = new.hourly_pay *2080;

update employees
set hourly_pay = hourly_pay + 1;

show triggers;

create table expenses(
	id int,
    name varchar(30),
    total decimal(10, 2)
);

select * from expenses;

insert into expenses
values (1, 'salaries', 0), (2, 'supplies', 0), (3, 'taxes', 0);

update expenses
set total = (select sum(salary) from employees)
where id = 1;

create trigger after_delete_mitarbeiter
after delete on employees
for each row
update expenses
set total = total - old.salary
where `name` = 'salaries';

show triggers;

delete from employees
where employee_id = 4;

delete from expenses
where id = 1;

insert into expenses
values (1, 'salaries', 0);
update expenses
set total = (select sum(salary) from employees)
where id = 1;

insert into employees
values (4, 'Alexey', 'Shchukin', 15, NULL);

update employees
set salary = hourly_pay * 2080
where employee_id = 6;

CREATE TRIGGER before_insert_mitarbeiter
BEFORE INSERT ON employees
FOR EACH ROW
SET new.salary = new.hourly_pay * 2080;

create trigger after_insert_mitarbeiter
after insert on employees
for each row
update expenses
set total = total + new.salary
where `name` = 'salaries';

select * from expenses;

CREATE TABLE changes_salary (
    id          INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    old_salary  DECIMAL(10, 2),
    new_salary DECIMAL(10, 2),
    change_date DATETIME
);

DELIMITER //

CREATE TRIGGER logging_changing_salary
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    INSERT changes_salary (employee_id, old_salary, new_salary, change_date)
    VALUES (new.employee_id, old.salary, new.salary, NOW());
END;
//

DELIMITER ;

SELECT * FROM employees;

UPDATE employees
SET hourly_pay = 12.5
WHERE employee_id = 1;

SELECT * FROM changes_salary;
