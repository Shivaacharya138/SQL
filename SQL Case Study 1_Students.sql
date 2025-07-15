CREATE DATABASE SQLCLS296

USE SQLCLS296

CREATE TABLE STUDENTS 
(Student_id INT, Student_name Varchar(20), Registered_date DATE)


INSERT INTO STUDENTS VALUES
(1, 'Rohan', '2022-01-01'),
(2, 'Priya', '2022-03-15'),
(3, 'Soham', '2022-06-10'),
(4, 'Neha', '2022-07-01');

SELECT * FROM STUDENTS

CREATE TABLE COURSES 
(Course_id INT, Course_name VARCHAR(50), Instructor_id INT)


INSERT INTO COURSES VALUES
(101, 'SQL Mastery', 11),
(102, 'Python for Data', 12),
(103, 'Power BI Basics', 11);

SELECT * FROM COURSES

CREATE TABLE ENROLLMENTS
(Enroll_id INT, Student_id INT, Course_id INT, Enroll_date DATE, Completion_Status VArchar(20))


INSERT INTO ENROLLMENTS (Enroll_id, Student_id, Course_id,
Enroll_date, Completion_Status) values
(501, 1, 101, '2022-01-05', 'Completed'),
(502, 2, 101, '2022-03-20', 'In Progress'),
(503, 3, 102, '2022-06-15', 'Completed'),
(504, 4, 101, '2022-07-10', 'Completed'),
(505, 2, 103, '2022-04-01', 'Completed'),
(506, 1, 103, '2022-01-20', 'Completed');

SELECT * FROM ENROLLMENTS

CREATE TABLE Instructors
(Instructor_id INT, Instructor_name Varchar(30))

INSERT INTO Instructors values 
(11, 'Mr. Aakash'),
(12, 'Ms. Divya');


SELECT * FROM Instructors


--Your Task:
--Write a SQL query to return the following per course:
-- Instructor Name
-- Course Name
-- Total Students Enrolled
-- Number of Students Completed
-- Completion Rate (%) (rounded to 2 decimal places)
-- Rank of Course based on Completion Rate (1 = highest)


--Note:
--Only include courses where at least 2 students are enrolled.

SELECT Top 2 * FROM STUDENTS
SELECT Top 2 * FROM COURSES
SELECT Top 2 * FROM ENROLLMENTS
SELECT Top 2 * FROM Instructors

WITH A
AS
(
SELECT I.Instructor_name, C.Course_name, Count(E.Student_id) No_of_Enroll_students, Count(CASE WHEN E.Completion_status = 'Completed' Then 1 END) Total_Students,
ROUND(((CAST(Count(CASE WHEN E.Completion_status = 'Completed' Then 1 END) AS FLOAT)/Count(E.Student_id))*100), 2) Completion_Rate
FROM COURSES C INNER JOIN Instructors I ON (C.Instructor_id = i.Instructor_id)
INNER JOIN ENROLLMENTS E ON C.COURSE_id = E.Course_id Group BY I.Instructor_name, C.Course_name HAVING Count(E.Student_id)>=2
)
SELECT *, DENSE_RANK() OVER(ORDER BY Completion_rate DESC) DR FROM A




