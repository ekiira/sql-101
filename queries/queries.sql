SELECT *
FROM EmployeeDemographics

SELECT TOP 5 *
FROM EmployeeSalary

SELECT 
    FirstName,
    LastName
FROM EmployeeDemographics

-- unique, no duplicates - DISTINCT
SELECT 
    DISTINCT (Gender)
FROM EmployeeDemographics

SELECT 
    DISTINCT (EmployeeID)
FROM EmployeeSalary

-- length of non-null values - COUNT
SELECT 
    COUNT (FirstName)
FROM EmployeeDemographics

-- naming with AS
SELECT 
    COUNT (FirstName) AS LastNameCount
FROM EmployeeDemographics

-- using min,max, avg
SELECT 
    MIN (Salary) AS MinimumSalary,
    MAX (Salary) AS MaximumSalary,
    AVG (Salary) AS AverageSalary
FROM EmployeeSalary


-- WHERE statement 
SELECT *
FROM EmployeeDemographics
WHERE FirstName = 'Jim'

SELECT *
FROM EmployeeDemographics
WHERE Age > 30

-- using AND, OR
SELECT *
FROM EmployeeDemographics
WHERE Age >= 30 AND Gender = 'Male'

SELECT *
FROM EmployeeDemographics
WHERE Age <= 30 OR Gender = 'Male'

-- using LIKE
SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE 'S%'
-- meaning where the Lastname start with an S

SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE '%S%'
-- meaning where the Lastname has S in it

SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE 'H%P%'
-- meaning where the Lastname starts with S and has P in it

-- using NULL, Not NULL
SELECT *
FROM EmployeeDemographics
WHERE FirstName IS NULL

SELECT *
FROM EmployeeDemographics
WHERE FirstName IS NOT NULL

-- using IN
SELECT *
FROM EmployeeDemographics
WHERE FirstName IN ('jim', 'pam')


-- GROUP BY
SELECT Gender
FROM EmployeeDemographics
GROUP BY Gender
-- similar to DISTINCT command but in GROUP BY, 
-- it returns the unique a values and compresses them in one column 
-- as seen below
SELECT Gender, COUNT(Gender)
FROM EmployeeDemographics
GROUP BY Gender

SELECT Gender, Age, COUNT(Gender), COUNT(Age)
FROM EmployeeDemographics
GROUP BY Gender, Age
-- none of them are the same age AND gender

SELECT Gender, Age
FROM EmployeeDemographics
WHERE Age > 31
GROUP BY Gender, Age

--  ORDER BY
SELECT *
FROM EmployeeDemographics
ORDER BY Age
-- lowest to highest

SELECT *
FROM EmployeeDemographics
ORDER BY Age DESC
-- highest to lowest
