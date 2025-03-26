CREATE PROCEDURE large_salary_Alex()
SELECT *
FROM employees
WHERE salary > 10000;

CALL large_salary_Alex();

DELIMITER $$
CREATE PROCEDURE large_salary2_Alex()
BEGIN
    SELECT *
    FROM employees
    WHERE salary > 10000;
    SELECT *
    FROM employees
    WHERE salary < 15000;
END $$
DELIMITER ;

CALL large_salary2_Alex();


DELIMITER $$
CREATE PROCEDURE find_salary_by_id(emp_id INT)
BEGIN
    SELECT salary
    FROM employees
    WHERE employee_id = emp_id;
END $$
DELIMITER ;

DROP PROCEDURE find_salary_by_id;

CALL find_salary_by_id(101);


DELIMITER $$
CREATE PROCEDURE employee_salary(fname varchar(30), lname varchar(25))
BEGIN
    SELECT salary
    FROM employees
    WHERE first_name = fname
      AND last_name = lname;
END $$
DELIMITER ;

create table if not exists queries(
	id int primary key auto_increment,
    `name` varchar(20),
    `query` longtext);

insert into queries(name, query)
values ('show all employees', 'select * from employees;');

select * from queries;

DELIMITER $$
CREATE PROCEDURE ExecuteScript(IN script_id INT)
BEGIN
    SELECT query INTO @sql FROM queries WHERE id =script_id;
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END $$
DELIMITER ;

CALL ExecuteScript(1);

SELECT * FROM employees;