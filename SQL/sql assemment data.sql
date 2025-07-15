
USE assessment; 
 drop table if exists employees;
CREATE TABLE employees ( 
Employee_id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR (100), 
position VARCHAR (100), salary DECIMAL (10, 2), hire_date DATE 
); 
 
 drop table if exists employee_audit;
 
CREATE TABLE employee_audit ( 
audit_id INT AUTO_INCREMENT PRIMARY KEY, 
employee_id INT, 
name VARCHAR 
(100), 
position VARCHAR (100), salary DECIMAL (10, 2), hire_date DATE, 
action_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
); 
 
INSERT INTO employees (name, position, salary, hire_date) VALUES ('John Doe', 
'Software Engineer', 80000.00, '2022-01-15'), 
('Jane Smith', 'Project Manager', 90000.00, '2021-05-22'), 
('Alice Johnson', 'UX Designer', 75000.00, '2023-03-01');

DELIMITER $$
CREATE TRIGGER after_update_employees
AFTER insert ON employees
FOR EACH ROW
BEGIN
	INSERT INTO employee_audit(employee_id,name,position)
    values (new.employee_id,new.name,new.position);
END $$
DELIMITER ;

drop procedure AUTO_UPDATE_EMP;

delimiter $$
create procedure AUTO_UPDATE_EMP (in x int, in y varchar (50), in z varchar (50))
begin 
	INSERT INTO employees (employee_id,name,position)
    values (x, y, z);
end $$
delimiter ;

 CALL AUTO_UPDATE_EMP(4, 'Mark Lee', 'QA Analyst');









