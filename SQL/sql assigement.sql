/* SQL ASSIGNMENT */


create table company(
	 CompanyID INT,
	 CompanyName varchar(50),
	  Street VARCHAR(50),
	City VARCHAR(50),
    State VARCHAR(50),
    Zip VARCHAR(50)
);


/*1) Statement to create the Contact table  */

CREATE TABLE Contact (
    ContactID INT,
    CompanyID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Street VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    Zip VARCHAR(50),
    IsMain BOOLEAN,
    Email VARCHAR(50),
    Phone VARCHAR(50)
);


/*2) Statement to create the Employee table */

drop table if exists Employee;

CREATE TABLE Employee (
    EmployeeID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    HireDate DATE,
    JobTitle VARCHAR(50),
    Email VARCHAR(50),
    phone varchar(50),
    Salary DECIMAL(10,2)
);


/*3) Statement to create the ContactEmployee table */

CREATE TABLE ContactEmployee (
    ContactEmployeeID INT,
    ContactID INT,
    EmployeeID INT,
    ContactDate DATE,
    Description VARCHAR(100)
);


/*4) In the Employee table, the statement that changes Lesley Bland’s phone number 
to 215-555-8800  */

UPDATE Employee
SET Phone = '215-555-8800'
WHERE FirstName = 'Lesley' AND LastName = 'Bland';


/*5) In the Company table, the statement that changes the name of “Urban 
Outfitters, Inc.” to “Urban Outfitters” . */

UPDATE Company
SET CompanyName = 'Urban Outfitters'
WHERE CompanyName = 'Urban Outfitters, Inc.';


/*6)  In ContactEmployee table, the statement that removes Dianne Connor’s contact 
event with Jack Lee (one statement).*/

DELETE FROM ContactEmployee
WHERE ContactID = (
    SELECT ContactID FROM Contact
    WHERE FirstName = 'Dianne' AND LastName = 'Connor'
)
AND EmployeeID = (
    SELECT EmployeeID FROM Employee
    WHERE FirstName = 'Jack' AND LastName = 'Lee'
);


/*7) Write the SQL SELECT query that displays the names of the employees that 
have contacted Toll Brothers (one statement). Run the SQL SELECT query in 
MySQL Workbench. Copy the results below as well.*/

SELECT e.FirstName, e.LastName
FROM Employee e
JOIN ContactEmployee ce ON e.EmployeeID = ce.EmployeeID
JOIN Contact c ON ce.ContactID = c.ContactID
JOIN Company co ON c.CompanyID = co.CompanyID
WHERE co.CompanyName = 'Toll Brothers';


/*8) What is the significance of “%” and “_” operators in the LIKE statement?  */

/*% matches zero or more characters.

Example: 'A%' matches "Amy", "Andrew", "Ankit".

_ matches exactly one character.

Example: 'A_' matches "Al", "Ax", but not "Amy".*/


/*9) Explain normalization in the context of databases. */

/*Normalization is a process to organize data in a database to:

Reduce data redundancy

Improve data integrity

Divide data into related tables
Common forms: 1NF, 2NF, 3NF.*/


/*10) What does a join in MySQL mean? */

/*JOIN is used to combine rows from two or more tables based on a related column between them.*/


/*11) 19.What do you understand about DDL, DCL, and DML in MySQL?*/

/*DDL (Data Definition Language): Deals with schema and structure (e.g., CREATE, ALTER, DROP)*/

/*DCL (Data Control Language): Controls access (e.g., GRANT, REVOKE)*/

/*DML (Data Manipulation Language): Manages data (e.g., SELECT, INSERT, UPDATE, DELETE)*/



/*12). What is the role of the MySQL JOIN clause in a query, and what are some 
common types of joins?*/ 

/*INNER JOIN: Returns records with matching values in both tables.*/

/*LEFT JOIN: Returns all records from left table, even if there’s no match in right.*/

/*RIGHT JOIN: Returns all records from right table, even if no match in left.*/

/*FULL JOIN (Not in MySQL, use UNION instead): All matching records from both tables.*/








