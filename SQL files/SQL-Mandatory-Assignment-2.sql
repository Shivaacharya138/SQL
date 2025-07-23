USE ASSIGNMENTS_25

--Jomato.csv file inserted as below

--Right-click on the target database > Choose Tasks > Select Import Flat File.
--Click Next.
--Browse and select your CSV file.
--Click Next to define the table structure (you can modify column types if needed).
--Click Next > Review summary > Click Finish.
--Data will be imported into a new table.

SELECT * FROM Jomato

--1. Create a user-defined functions to stuff the Chicken into ‘Quick Bites’. Eg: ‘Quick Chicken Bites’.

CREATE OR ALTER FUNCTION Stuffing(@stuffingitem VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
SELECT RestaurantName, RestaurantType, 
	STUFF(RestaurantType, CHARINDEX(' ', RestaurantType)+1, 0 , @stuffingitem+' ') ModifiedRestaurantItem FROM Jomato  --SyntaxSTUFF(original_string, start_position, length_to_replace, string_to_insert)
	WHERE CHARINDEX(' ', RestaurantType) >0
);
	
SELECT * FROM dbo.Stuffing('Chicken')

--2. Use the function to display the restaurant name and cuisine type which has the maximum number of rating.

SELECT * FROM Jomato

CREATE FUNCTION MAX_RATINGS()
RETURNS INT
AS
BEGIN
	DECLARE @Ratings INT

	SELECT @Ratings = MAX(No_of_Rating) FROM Jomato
RETURN @Ratings
END;


select dbo.max_ratings() Max_Ratings

SELECT RestaurantName, CuisinesType, No_of_Rating FROM Jomato WHERE No_of_rating = dbo.MAX_Ratings()

--Checking whether the function is getting auto update when i insert the values with the higher no of ratings than the existing values in table
--Im using transactions since i dont want to change the existing data i just need to Verify whether my code is correct
BEGIN TRANSACTION
INSERT INTO Jomato values(
7105, 'shivudu', ' sea ban', 4.0587, 20500, 1825, 1, 1, 'South Indian', 'Hyderabad, Telangana', 'Kondapur', 38)

SELECT RestaurantName, CuisinesType, No_of_Rating FROM Jomato WHERE No_of_rating = dbo.MAX_Ratings()

ROLLBACK

--3. Create a Rating Status column to display the rating as ‘Excellent’ if it has more the 4
--start rating, ‘Good’ if it has above 3.5 and below 4 star rating, ‘Average’ if it is above 3
--and below 3.5 and ‘Bad’ if it is below 3 star rating and

SELECT *,
CASE 
	WHEN RATING > 4 THEN 'EXCELLENT'
	WHEN RATING BETWEEN 3.5 and 4 THEN 'GOOD'
	WHEN RATING BETWEEN 3 AND 3.5 THEN 'AVEGARGE'
	WHEN RATING < 3 THEN 'BAD'
END AS RATING_STATUS
FROM JOMATO


ALTER TABLE JOMATO
ADD RATING_STATUS VARCHAR(50)

UPDATE JOMATO
SET RATING_STATUS =
CASE 
	WHEN RATING > 4 THEN 'EXCELLENT'
	WHEN RATING BETWEEN 3.5 and 4 THEN 'GOOD'
	WHEN RATING BETWEEN 3 AND 3.5 THEN 'AVEGARGE'
	WHEN RATING < 3 THEN 'BAD'
END;	

SELECT * FROM JOMATO

--4. Find the Ceil, floor and absolute values of the rating column and display the current
--date and separately display the year, month_name and day.

SELECT CEILING(Rating) CEIL, FLOOR(Rating) FLOOR, ABS(Rating) ABSOLUTE , GETDATE() CURRENTDATE, 
YEAR(GETDATE()) YEAR, DATENAME(MM, GETDATE()) MONTH, DAY(GETDATE()) DAY FROM JOMATO

--5. Display the restaurant type and total average cost using rollup.

SELECT RestaurantType, AverageCost FROM JOMATO ROLLUP


