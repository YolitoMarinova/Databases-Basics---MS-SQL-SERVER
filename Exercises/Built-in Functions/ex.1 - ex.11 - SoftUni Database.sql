USE SoftUni

SELECT * FROM Employees

	SELECT FirstName, LastName 
	  FROM Employees
	 WHERE FirstName LIKE 'SA%'

	SELECT FirstName, LastName 
	  FROM Employees
	 WHERE LastName LIKE '%EI%'

SELECT FirstName 
  FROM Employees
 WHERE DepartmentID IN(3,10) AND 
	   HireDate BETWEEN '01-01-1995' AND '12-31-2005'

SELECT FirstName,LastName 
  FROM Employees
 WHERE JobTitle NOT LIKE '%ENGINEER%'

SELECT * FROM Towns

	SELECT [Name] 
	  FROM Towns
	 WHERE LEN([Name]) IN (5,6)
  ORDER BY [Name]

  SELECT * 
    FROM Towns
   WHERE [Name] LIKE '[M,K,B,E]%'
ORDER BY [Name]

	  SELECT * 
	    FROM Towns
	   WHERE [Name] LIKE '[^R,B,D]%'
	ORDER BY [Name]

CREATE VIEW V_EmployeesHiredAfter2000 AS
	 SELECT FirstName,LastName FROM Employees
	  WHERE HireDate>='01-01-2001'

SELECT FirstName,LastName 
  FROM Employees
 WHERE LEN(LastName)=5

	  SELECT EmployeeID,FirstName,LastName,Salary,
DENSE_RANK() OVER
(PARTITION BY Salary
	 ORDER BY EmployeeID ) AS TKTKT
		 FROM Employees
		WHERE Salary BETWEEN 10000 AND 50000
	 ORDER BY Salary DESC

	 SELECT * 
	   FROM ( 
	 SELECT EmployeeID,FirstName,LastName,Salary,
DENSE_RANK() OVER(PARTITION BY Salary ORDER BY EmployeeID ) AS TKTKT
	  FROM Employees
	 WHERE Salary BETWEEN 10000 AND 50000) T
	 WHERE TKTKT=2
  ORDER BY Salary DESC

