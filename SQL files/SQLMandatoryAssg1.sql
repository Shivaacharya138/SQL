CREATE DATABASE ASSIGNMENTS_25

USE ASSIGNMENTS_25

--Salesman table creation

CREATE TABLE Salesman (
SalesmanId INT,
Name VARCHAR(255),
Commission DECIMAL(10, 2),
City VARCHAR(255),
Age INT
);

--Salesman table record insertion

INSERT INTO Salesman (SalesmanId, Name, Commission, City, Age)
VALUES
(101, 'Joe', 50, 'California', 17),
(102, 'Simon', 75, 'Texas', 25),
(103, 'Jessie', 105, 'Florida', 35),
(104, 'Danny', 100, 'Texas', 22),
(105, 'Lia', 65, 'New Jersey', 30);

SELECT * FROM Salesman

--Customer table creation

CREATE TABLE Customer (
SalesmanId INT,
CustomerId INT,
CustomerName VARCHAR(255),
PurchaseAmount INT,
);

--Customer table record insertion

INSERT INTO Customer (SalesmanId, CustomerId, CustomerName, PurchaseAmount)
VALUES
(101, 2345, 'Andrew', 550),
(103, 1575, 'Lucky', 4500),
(104, 2345, 'Andrew', 4000),
(107, 3747, 'Remona', 2700),
(110, 4004, 'Julia', 4545);

SELECT * FROM Customer

--Orders table Creation

CREATE TABLE Orders (OrderId int, CustomerId int, SalesmanId int, Orderdate Date, Amount
money)

--Orders table record insertion

INSERT INTO Orders Values
(5001,2345,101,'2021-07-01',550),
(5003,1234,105,'2022-02-15',1500);

SELECT * FROM Orders

--Tasks to be Performed: 
 
--1. Insert a new record in your Orders table. 

INSERT INTO Orders VALUES
(5004, 4004, 110, GETDATE(), 4545)


--2. a. Add Primary key constraint for SalesmanId column in Salesman table. Add default  
--	constraint for City column in Salesman table. 
--	b. Add Foreign key constraint for SalesmanId column in Customer table. 
--	c. Add not null constraint in Customer_name column for the Customer table. 

--a.
ALTER TABLE Salesman
ALTER COLUMN Salesmanid INT NOT NULL

ALTER TABLE Salesman
ADD CONSTRAINT PK_Salesman PRIMARY KEY(Salesmanid), Default('Texas') FOR City;

EXEC sp_help Salesman

--b.
ALTER TABLE Customer
ALTER COLUMN Salesmanid INT NOT NULL


ALTER TABLE Customer
ADD CONSTRAINT FK_Customer_Salesman_Salesmanid FOREIGN KEY(Salesmanid) REFERENCES Salesman(Salesmanid)

--getting Error Message
--Msg 547, Level 16, State 0, Line 94
--The ALTER TABLE statement conflicted with the FOREIGN KEY constraint "FK_Customer_Salesman_Salesmanid". 
--The conflict occurred in database "ASSIGNMENTS_25", table "dbo.Salesman", column 'SalesmanId'.

SELECT *
FROM Customer
WHERE SalesmanId NOT IN (SELECT SalesmanId FROM Salesman);

DELETE FROM Customer
WHERE SalesmanId NOT IN (SELECT SalesmanId FROM Salesman);

ALTER TABLE Customer
ADD CONSTRAINT FK_Customer_Salesman_Salesmanid FOREIGN KEY(Salesmanid) REFERENCES Salesman(Salesmanid)

--c.
ALTER TABLE Customer
ALTER COLUMN CustomerName Varchar(255) NOT NULL;

EXEC SP_HELP Customer

--3. Fetch the data where the Customer’s name is ending with ‘N’ also get the purchase 
--	amount value greater than 500. 

SELECT * FROM Customer
WHERE CustomerName LIKE '%N' and PurchaseAmount > 500

--4. Using SET operators, retrieve the first result with unique SalesmanId values from two 
--	tables, and the other result containing SalesmanId with duplicates from two tables. 

--RESULT 1
SELECT SalesmanId FROM Salesman
UNION
SELECT SalesmanId FROM Customer

--RESULT 2
SELECT SalesmanId FROM Salesman
UNION ALL
SELECT SalesmanId FROM Customer

--5. Display the below columns which has the matching data. 
--	Orderdate, Salesman Name, Customer Name, Commission, and City which has the range of Purchase Amount between 500 to 1500. 

SELECT O.Orderdate, S.Name salesman_Name, C.CustomerName, S.Commission, S.City
FROM Salesman S INNER JOIN Customer C  ON S.SalesmanId = C. SalesmanId INNER JOIN Orders O ON S.SalesmanId = O.SalesmanId
WHERE c.PurchaseAmount BETWEEN 500 AND 5500;

--6. Using right join fetch all the results from Salesman and Orders table. 

SELECT * FROM Salesman S RIGHT JOIN Orders O ON S.SalesmanId = O.SalesmanId


SELECT TOP 2 * FROM Salesman
SELECT TOP 2 * FROM Customer
SELECT TOP 2 * FROM Orders


