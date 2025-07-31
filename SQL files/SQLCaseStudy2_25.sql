USE SQLCASESTUDIES_25

CREATE TABLE Location
(Location_ID INT PRIMARY KEY, City VARCHAR(50));

INSERT INTO Location VALUES
	 (122, 'New York'),
     (123, 'Dallas'),
     (124, 'Chicago'),
     (167, 'Boston');

SELECT * FROM Location

CREATE Table Department (Department_Id INT PRIMARY KEY, 
Name Varchar(50), Location_Id INT FOREIGN KEY REFERENCES Location(Location_id));

INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES (10, 'Accounting', 122),
       (20, 'Sales', 124),
       (30, 'Research', 123),
       (40, 'Operations', 167);

SELECT * FROM Department

CREATE TABLE Job (
  Job_ID INT PRIMARY KEY,
  Designation VARCHAR(50)
);

INSERT  INTO Job VALUES
(667, 'CLERK'),
(668,'STAFF'),
(669,'ANALYST'),
(670,'SALES_PERSON'),
(671,'MANAGER'),
(672, 'PRESIDENT')

SELECT * FROM Job

CREATE TABLE Employee (Employee_Id INT, Last_Name VARCHAR(20), First_Name VARCHAR(20),
Middle_Name VARCHAR(20), Job_Id INT FOREIGN KEY REFERENCES Job(Job_Id), Manager_Id INT, Hire_Date DATE, Salary INT,
Comm INT, Department_Id INT FOREIGN KEY REFERENCES Department(Department_Id))

INSERT INTO Employee VALUES
(7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-84',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULl,30),
(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30)


SELECT * FROM Employee

--Simple Queries:
--1. List all the employee details.
SELECT * FROM Employee

--2. List all the department details.
SELECT * FROM Department

--3. List all job details.
SELECT * FROM Job

--4. List all the locations.
SELECT * FROM Location

--5. List out the First Name, Last Name, Salary, Commission for all Employees.
SELECT First_Name, Last_Name, Salary, Comm Comission
FROM Employee

--6. List out the Employee ID, Last Name, Department ID for all employees 
--and alias Employee ID as "ID of the Employee", Last Name as "Name of the Employee", Department ID as "Dep_id".
SELECT Employee_Id 'ID of the Empoyee', Last_Name 'Name of the Employee', Department_Id Dep_id
FROM Employee

--7. List out the annual salary of the employees with their names only.
SELECT First_Name, Salary 'Annual Salary'
FROM Employee


--WHERE Condition:
--1. List the details about "Smith".
SELECT * FROM Employee WHERE Last_Name = 'Smith'

--2. List out the employees who are working in department 20.
SELECT * FROM Employee WHERE Department_Id = 20

--3. List out the employees who are earning salary between 2000 and 3000.
SELECT * FROM Employee WHERE Salary BETWEEN 2000 AND 3000

--4. List out the employees who are working in department 10 or 20.
SELECT * FROM Employee WHERE Department_Id IN (10, 20)
--OR--
SELECT * FROM Employee WHERE Department_Id = 10 OR Department_Id = 20

--5. Find out the employees who are not working in department 10 or 30.
SELECT * FROM Employee WHERE Department_Id NOT IN (10, 30)

--6. List out the employees whose name starts with 'L'.
SELECT * FROM Employee WHERE First_Name LIKE 'L%'

--7. List out the employees whose name starts with 'L' and ends with 'E'.
SELECT * FROM Employee WHERE First_Name LIKE 'L%' AND Last_Name LIKE '%E'

--8. List out the employees whose name length is 4 and start with 'J'.
SELECT * FROM Employee WHERE LEN(First_Name) = 4 AND First_Name LIKE 'J%'

--9. List out the employees who are working in department 30 and draw the salaries more than 2500.
SELECT * FROM Employee WHERE Department_Id = 30 AND Salary > 2500

--10. List out the employees who are not receiving commission.
SELECT * FROM Employee WHERE Comm IS NULL


--ORDER BY Clause:
--1. List out the Employee ID and Last Name in ascending order based on the Employee ID.
SELECT Employee_Id, Last_Name FROM Employee ORDER BY Employee_Id ASC

--2. List out the Employee ID and Name in descending order based on salary.
SELECT Employee_Id, First_Name + ' ' + Last_Name Name FROM Employee ORDER BY Salary DESC

--3. List out the employee details according to their Last Name in ascending-order.
SELECT * FROM Employee ORDER BY Last_Name ASC

--4. List out the employee details according to their Last Name in ascending order and then Department ID in descending order.
SELECT * FROM Employee ORDER BY Last_Name ASC , Department_Id DESC

--GROUP BY and HAVING Clause:
--1. List out the department wise maximum salary, minimum salary and average salary of the employees.
SELECT Department_Id, MAX(SALARY) MAX_SALARY, MIN(SALARY) MIN_SALARY, AVG(SALARY) AVG_SALARY
FROM Employee GROUP BY Department_Id

--2. List out the job wise maximum salary, minimum salary and average salary of the employees.
SELECT Job_Id, MAX(SALARY) MAX_SALARY, MIN(SALARY) MIN_SALARY, AVG(SALARY) AVG_SALARY
FROM Employee GROUP BY Job_Id

--3. List out the number of employees who joined each month in ascending order.
SELECT DATENAME(MM, Hire_Date) Month , COUNT(*) NO_OF_EMP
FROM Employee GROUP BY DATENAME(MM, Hire_Date) ORDER BY NO_OF_EMP ASC

--4. List out the number of employees for each month and year in ascending order based on the year and month.
SELECT YEAR(Hire_Date) Year, MONTH(Hire_Date) Month, COUNT(*) NO_OF_EMP
FROM Employee GROUP BY MONTH(Hire_Date), YEAR(Hire_Date) ORDER BY Year, Month ASC

--5. List out the Department ID having at least four employees.
SELECT Department_Id, COUNT(*) NO_OF_EMP FROM Employee GROUP BY Department_Id HAVING COUNT(*) >=4
--OR--
SELECT * FROM (
SELECT Department_Id, COUNT(*) NO_OF_EMP
FROM Employee GROUP BY Department_Id 
) ABC 
WHERE NO_OF_EMP >=4

--6. How many employees joined in February month.
SELECT DATENAME(MM, Hire_date) MONTH, COUNT(*) NO_OF_EMP FROM Employee GROUP BY DATENAME(MM, Hire_date) HAVING DATENAME(MM, Hire_date) = 'February'

--7. How many employees joined in May or June month.
SELECT DATENAME(MM, Hire_date) MONTH, COUNT(*) NO_OF_EMP FROM Employee GROUP BY DATENAME(MM, Hire_date) HAVING DATENAME(MM, Hire_date) in ('May' , 'June')
--or--
SELECT COUNT(*) Emp_joined_in_may_June FROM Employee WHERE MONTH(Hire_Date) in (5,6)

--8. How many employees joined in 1985?
SELECT YEAR(Hire_Date) Year, Count(*) Emp_Joined FROM Employee GROUP BY YEAR(Hire_Date) HAVING YEAR(Hire_Date) = 1985

--9. How many employees joined each month in 1985?
SELECT YEAR(Hire_Date) Year, MONTH(Hire_Date) Month, Count(*) Emp_Joined FROM Employee GROUP BY YEAR(Hire_Date), MONTH(Hire_Date) HAVING YEAR(Hire_Date) = 1985

--10. How many employees were joined in April 1985?
SELECT YEAR(Hire_Date) Year, MONTH(Hire_Date) Month, Count(*) Emp_Joined FROM Employee 
GROUP BY YEAR(Hire_Date), MONTH(Hire_Date) HAVING YEAR(Hire_Date) = 1985 and MONTH(Hire_Date) = 4

--or--
SELECT COUNT(*) EMP_Joined_Apr1985 FROM Employee WHERE YEAR(Hire_Date) = 1985 and MONTH(Hire_Date) = 4


--11. Which is the Department ID having greater than or equal to 3 employees joining in April 1985?

SELECT Department_id, COUNT(*) EMP_Joined_Apr1985 FROM Employee WHERE YEAR(Hire_Date) = 1985 and MONTH(Hire_Date) = 4 GROUP BY Department_Id HAVING Count(*) >=3


--Joins:
--1. List out employees with their department names.
SELECT E.Employee_Id,E.First_Name, E.Last_Name,  D.Name FROM Employee E INNER JOIN Department D ON E.Department_Id = D.Department_Id

--2. Display employees with their designations.
SELECT E.Employee_Id,E.First_Name, E.Last_Name, J.Designation FROM Employee E INNER JOIN Job J ON E.Job_Id = J.Job_ID 

--3. Display the employees with their department names and city.
SELECT E.Employee_Id,E.First_Name, E.Last_Name, D.Name Department, L.City FROM Employee E 
INNER JOIN Department D ON E.Department_Id = D.Department_Id 
INNER JOIN LOCATION L ON D.Location_Id = L.Location_ID

--4. How many employees are working in different departments? Display with department names.
SELECT E.Department_Id, D.Name Department, COUNT(*) No_Of_Employees
FROM Employee E INNER JOIN Department D ON E.Department_Id = D.Department_Id GROUP BY E.Department_Id, D.Name

--5. How many employees are working in the sales department?
SELECT E.Department_Id, D.Name Department, COUNT(*) No_Of_Employees
FROM Employee E INNER JOIN Department D ON E.Department_Id = D.Department_Id  WHERE D.Name = 'Sales' GROUP BY E.Department_Id, D.Name

--6. Which is the department having greater than or equal to 3 employees and display the department names in ascending order.
SELECT D.Name Department, COUNT(*) No_Of_Emp
FROM Employee E INNER JOIN Department D ON E.Department_Id = D.Department_Id GROUP BY D.Name HAVING Count(*) >=3 ORDER BY Department

--7. How many employees are working in 'Dallas'?
SELECT L.City, COUNT(*) NO_OF_EMP FROM Employee E 
INNER JOIN Department D ON E.Department_Id = D.Department_Id 
INNER JOIN LOCATION L ON D.Location_Id = L.Location_ID WHERE L.City =  'Dallas' GROUP BY L.City

--8. Display all employees in sales or operation departments.
Select * FROM Employee E INNER JOIN Department D
ON E.Department_Id = D.Department_Id WHERE D.Name IN ('sales', 'Operations') 

--CONDITIONAL STATEMENT
--1. Display the employee details with salary grades. Use conditional statement to create a grade column.
SELECT *,
CASE
	WHEN Salary < 1000 THEN 'LOW'
	WHEN Salary BETWEEN 1000 AND 2000 THEN 'MEDIUM'
	ELSE 'HIGH'
	END AS Salary_Grades
	FROM Employee

--2. List out the number of employees grade wise. Use conditional statement to create a grade column.

SELECT Salary_Grades, COUNT(*) EMP_COUNT FROM(
SELECT *,
CASE
	WHEN Salary < 1000 THEN 'LOW'
	WHEN Salary BETWEEN 1000 AND 2000 THEN 'MEDIUM'
	ELSE 'HIGH'
	END AS Salary_Grades
	FROM Employee) EMP GROUP BY Salary_Grades


--3. Display the employee salary grades and the number of employees between 2000 to 5000 range of salary.

SELECT Salary_Grades, COUNT(*) EMP_COUNT FROM(
SELECT *,
CASE
	WHEN Salary < 1000 THEN 'LOW'
	WHEN Salary BETWEEN 1000 AND 2000 THEN 'MEDIUM'
	WHEN Salary BETWEEN 2000 AND 5000 THEN 'HIGH'
	ELSE 'V HIGH'
	END AS Salary_Grades
	FROM Employee) EMP WHERE Salary_Grades ='HIGH' GROUP BY Salary_Grades


--Subqueries:
--1. Display the employees list who got the maximum salary.
SELECT * FROM Employee WHERE Salary = (SELECT MAX(Salary) FROM Employee)

--2. Display the employees who are working in the sales department.
SELECT * FROM Employee WHERE Department_Id = (SELECT Department_Id FROM Department WHERE Name = 'Sales')

--3. Display the employees who are working as 'Clerk'.
SELECT * FROM Employee WHERE Job_Id = (SELECT Job_Id FROM JOB WHERE Designation = 'CLERK')

--4. Display the list of employees who are living in 'Boston'.
SELECT * FROM Employee E INNER JOIN Department D ON E.Department_Id = D.Department_Id
WHERE D.Location_Id = (SELECT Location_Id FROM Location WHERE City = 'Boston')

--5. Find out the number of employees working in the sales department.
SELECT COUNT(*) No_of_Emp_in_Sales FROM Employee WHERE Department_Id = (SELECT Department_Id FROM Department WHERE Name = 'Sales')

--6. Update the salaries of employees who are working as clerks on the basis of 10%.
UPDATE Employee
SET Salary = SALARY+0.1*Salary WHERE Job_Id = (SELECT Job_Id FROM JOB WHERE Designation = 'CLERK')

SELECT * FROM Employee

--7. Display the second highest salary drawing employee details.
SELECT * FROM Employee WHERE SALARY =(SELECT MAX(SALARY) FROM Employee WHERE Salary NOT IN (SELECT MAX(SALARY) FROM EMPLOYEE))

--8. List out the employees who earn more than every employee in department 30.

SELECT * FROM Employee WHERE SALARY > (
SELECT MAX(SALARY) FROM Employee WHERE Department_Id = 30)

--9. Find out which department has no employees.
SELECT NAME FROM Department WHERE Department_Id NOT IN (SELECT DISTINCT Department_Id FROM Employee WHERE Department_Id IS NOT NULL)

--10. Find out the employees who earn greater than the average salary for their department.

SELECT * FROM Employee E INNER JOIN (
SELECT Department_Id, AVG(SALARY) AVG_SALARY FROM Employee GROUP BY Department_Id) AE ON E.Department_Id = AE.Department_Id where salary > AVG_SALARY

--USING CORRELATED SUBQUERY i'e., The Subquery refers to the Outer Query
SELECT * FROM EMPLOYEE E1 WHERE SALARY > (SELECT AVG(SALARY) FROM Employee E2 WHERE E1.Department_Id = E2.Department_Id)

