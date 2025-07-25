USE ASSIGNMENTS_25

SELECT * FROM Jomato

--1. Create a stored procedure to display the restaurant name, type and cuisine where the table booking is not zero.

CREATE PROCEDURE Reserved_Tables
AS
BEGIN
SELECT RestaurantName, RestaurantType, CuisinesType, TableBooking
FROM Jomato WHERE TableBooking !=0
END

EXEC Reserved_Tables


--2. Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’. Check the result and rollback it.

BEGIN TRANSACTION

SELECT * FROM Jomato

UPDATE Jomato
SET CuisinesType = 'Cafeteria' WHERE CuisinesType = 'Cafe'

SELECT * FROM Jomato

ROLLBACK


SELECT * FROM Jomato WHERE CuisinesType = 'Cafe'


--3. Generate a row number column and find the top 5 areas with the highest rating of restaurants.

SELECT TOP 5 Area, RestaurantName, RestaurantType, Rating, ROW_NUMBER() OVER (ORDER BY Rating DESC) Row_Number FROM Jomato

--OR--

SELECT TOP 5 Area, MAX(Rating) Max_Rating, ROW_NUMBER() OVER (ORDER BY MAX(Rating) DESC) Row_Number FROM Jomato GROUP BY Area



--4. Use the while loop to display the 1 to 50.

DECLARE @Number INT = 1

WHILE @Number <= 50
BEGIN
	PRINT @Number
	SET @Number += 1
END

--OR-- TO DISPLAY 1 TO 50 ORDERID RECORDS THE CODE IS AS BELOW

DECLARE @OrderID INT
SET @OrderID = 0
WHILE @OrderID <=50
BEGIN
	SELECT * FROM Jomato WHERE OrderId = @OrderID
	SET @OrderID += 1
END


--5. Write a query to Create a Top rating view to store the generated top 5 highest rating of restaurants.

--Simply using Top 5 to display the records
CREATE VIEW Top5_Rating_Restaurants as
SELECT TOP 5 * FROM Jomato ORDER BY Rating DESC

--As i see multiple restaurants have the same ratings, so i want to include all
CREATE OR ALTER VIEW Top5_Rating_Restaurants as
SELECT * FROM(
SELECT *, DENSE_RANK() OVER (ORDER BY Rating DESC) Ratings_Rank FROM Jomato ) AS ranked Where Ratings_Rank <=5

SELECT * FROM Top5_Rating_Restaurants


--6. Create a trigger that give an message whenever a new record is inserted.

CREATE TRIGGER Insert_alert
ON
Jomato
AFTER
INSERT
AS 
BEGIN
	PRINT('New Record has been Inserted into Jomato Table')
END;