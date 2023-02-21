-- INSERT NEW ROWS TO TABLES --
INSERT INTO EmployeeDemographics VALUES
(1011, 'Ryan', 'Howard', 26, 'Male'),
(NULL, 'Holly','Flax', NULL, 'Male'),
(1013, 'Darryl', 'Philbin', NULL, 'Male')

INSERT INTO EmployeeSalary VALUES
(1010, NULL, 47000),
(NULL, 'Salesman', 43000)
GO

SELECT *
FROM EmployeeDemographics

SELECT *
FROM EmployeeSalary


-- JOINS --
-- inner join
SELECT *
FROM EmployeeDemographics
INNER JOIN EmployeeSalary
    ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
-- works like an intersections between 2 sets

-- outer join
SELECT *
FROM EmployeeDemographics
FULL OUTER JOIN EmployeeSalary
    ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
-- works like a union between 2 sets

-- left join
SELECT *
FROM EmployeeDemographics
LEFT OUTER JOIN EmployeeSalary
    ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
-- works like a A-B between 2 sets

--right join
SELECT *
FROM EmployeeDemographics
RIGHT OUTER JOIN EmployeeSalary
    ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
-- works like a B-A between 2 sets

-- Use case of Joins
-- Besides Michael Scott who is the highest paid employee in the company
SELECT 
    EmployeeDemographics.EmployeeID, 
    FirstName + ' ' + LastName as EmployeeName, 
    Salary
FROM EmployeeDemographics
JOIN EmployeeSalary
    ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE FirstName != 'Michael'
ORDER BY Salary DESC
--Dwight Schrute is the highest paid employee besides Michael Scott



-- CREATE AND INSERT TABLES --
-- CREATE TABLE
--     WareHouseEmployeeDemographics
--     (
--         EmployeeID int,
--         FirstName varchar(50),
--         LastName varchar(50),
--         Age int,
--         Gender varchar(50)
--     )

INSERT INTO WareHouseEmployeeDemographics 
    VALUES
        (1013, 'Darryl', 'Philbin', NULL, 'Male'),
        (1050, 'Roy', 'Anderson', 31, 'Male'),
        (1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
        (1052, 'Val','Johnson', 31, 'Female')

SELECT *
FROM WareHouseEmployeeDemographics



-- UNIONS --

--unions works well if both tables have the same columns and are identical but just with different values
--UNION
SELECT *
FROM EmployeeDemographics
UNION
SELECT *
FROM WareHouseEmployeeDemographics
--even though darryl is in both tables, it shows once, cos UNION removes duplicates, it works like DISTINCT

--UNION ALL
SELECT *
FROM EmployeeDemographics
UNION ALL
SELECT *
FROM WareHouseEmployeeDemographics
--shows everything including duplicates between the 2 tables




-- CASE statement --

--case statement allows you to specify condition and specify what you want returned when that condition is met
SELECT 
    FirstName,
    LastName,
    Age,
    CASE
        WHEN Age > 30 THEN 'Old'
        WHEN Age BETWEEN 27 AND 30 Then 'Young' 
        Else 'Baby'
    END AS AgeCategory
FROM EmployeeDemographics
WHERE Age is NOT NULL
ORDER BY Age

-- Use case of the CASE statement

-- give salary raises to different roles
SELECT 
    FirstName,
    LastName,
    JobTitle,
    Salary,
    CASE 
        WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
        WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05)
        WHEN JobTitle = 'HR' THEN Salary + (Salary * .000001)
        ELSE Salary + (Salary * .03)
    END AS SalaryAfterRaise
FROM EmployeeDemographics
JOIN EmployeeSalary
    ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID



-- HAVING CLAUSE --
-- works like where but unlike where, it is used with aggregates
SELECT 
    JobTitle,
    AVG(Salary)
FROM EmployeeDemographics
JOIN EmployeeSalary
    ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING AVG(Salary) > 45000
ORDER BY AVG(Salary)



-- UPDATING/DELETING DATA --
UPDATE EmployeeDemographics
SET EmployeeID = 1012, Age = 31, Gender = 'Female'
WHERE FirstName = 'Holly' AND LastName = 'Flax'

DELETE FROM EmployeeDemographics
WHERE EmployeeID = 1005



-- Alliasing --
SELECT 
    FirstName + ' ' + LastName FullName
FROM EmployeeDemographics

SELECT 
    Demo.FirstName
FROM EmployeeDemographics AS Demo
-- you can also alias a table

SELECT 
    Demo.EmployeeID, 
    Demo.FirstName,
    Demo.LastName,
    Sal.JobTitle,
    Ware.Age
FROM EmployeeDemographics AS Demo
LEFT JOIN EmployeeSalary AS Sal
    ON Demo.EmployeeID = Sal.EmployeeID
LEFT JOIN WareHouseEmployeeDemographics AS Ware
    ON Demo.EmployeeID = Ware.EmployeeID



-- PARTITION BY --
SELECT 
    FirstName,
    LastName,
    Gender,
    Salary,
    COUNT(Gender) OVER (PARTITION BY Gender) TotalGender
FROM EmployeeDemographics dem
JOIN EmployeeSalary sal
    ON dem.EmployeeID = sal.EmployeeID
