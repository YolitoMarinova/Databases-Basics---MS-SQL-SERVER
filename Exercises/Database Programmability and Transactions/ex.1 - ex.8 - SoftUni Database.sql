USE SoftUni

--EXCERCISE 1

CREATE PROC usp_GetEmployeesSalaryAbove35000
         AS
     SELECT e.FirstName, e.LastName
       FROM Employees AS e
	  WHERE e.Salary>35000

EXEC dbo.usp_GetEmployeesSalaryAbove35000

--EXCERCISE 2

CREATE PROC usp_GetEmployeesSalaryAboveNumber (@salaryNumber DECIMAL(18,4))
	     AS
	 SELECT e.FirstName, e.LastName
	   FROM Employees AS e
	  WHERE e.Salary >= @salaryNumber

EXEC dbo.usp_GetEmployeesSalaryAboveNumber 5000

--EXCERCISE 3

CREATE PROC usp_GetTownsStartingWith (@townFirstLetter NVARCHAR(30))
         AS
	 SELECT t.[Name] AS [Town]
	   FROM Towns AS t
	  WHERE UPPER(t.[Name]) LIKE @townFirstLetter + '%'

EXEC dbo.usp_GetTownsStartingWith C

--EXCERCISE 4

CREATE PROC usp_GetEmployeesFromTown (@town NVARCHAR(50))
         AS
     SELECT e.FirstName, e.LastName
	   FROM Employees AS e
	   JOIN Addresses AS a
	     ON a.AddressID = e.AddressID
	   JOIN Towns AS t
	     ON t.TownID = a.TownID
	  WHERE t.[Name] = @town

EXEC dbo.usp_GetEmployeesFromTown  Sofia

--EXCERCISE 5

CREATE FUNCTION ufn_GetSalaryLevel (@salary DECIMAL(18,4))
		RETURNS NVARCHAR(10)
		     AS
		  BEGIN
			DECLARE @text NVARCHAR(10)
				 IF (@salary < 30000)
			  BEGIN
				SET @text = 'Low'
				END
			ELSE IF (@salary >= 30000 AND @salary <=50000)
			  BEGIN
				SET @text = 'Average'
				END
			ELSE IF (@salary > 50000)
			  BEGIN
				SET @text = 'High'
				END
			RETURN @text
		   END

SELECT e.FirstName, e.LastName, e.Salary, dbo.ufn_GetSalaryLevel(e.Salary) AS [SalaryLevel]
  FROM Employees AS e

--EXCERCISE 6

CREATE PROC usp_EmployeesBySalaryLevel (@salaryLevel NVARCHAR(10))
         AS
	 SELECT e.FirstName, e.LastName
	   FROM Employees AS e
	  WHERE dbo.ufn_GetSalaryLevel(e.Salary) = @salaryLevel

EXEC dbo.usp_EmployeesBySalaryLevel High

--EXCERCISE 7

CREATE FUNCTION ufn_IsWordComprised(@setOfLetters NVARCHAR(50), @word NVARCHAR(50))
		RETURNS BIT
		     AS
		  BEGIN
		DECLARE @counter INT = 1
		DECLARE @currentLetter CHAR

			   WHILE @counter <= LEN(@word)
			   BEGIN
				 SET @currentLetter = SUBSTRING(@word,@counter,1)

				  IF (CHARINDEX(@currentLetter,@setOfLetters)<=0)
			   BEGIN
			  RETURN 0;
				 END
				 SET @counter+=1
				 END

		 RETURN 1
		    END

SELECT dbo.ufn_IsWordComprised('GAudy', FirstName)
  FROM Employees
 WHERE FirstName = 'Guy'

 --EXCERCISE 8

 CREATE PROC usp_DeleteEmployeesFromDepartment (@departmentId INT)
		  AS
		  BEGIN	

	DELETE FROM EmployeesProjects
	WHERE EmployeeID IN (
		SELECT EmployeeID 
		  FROM Employees
		 WHERE DepartmentID = @departmentId
	)

	UPDATE Employees
	SET ManagerID = NULL
	WHERE ManagerID IN (SELECT EmployeeID 
						  FROM Employees 
						 WHERE DepartmentID = @departmentId
	)

	ALTER TABLE Departments
	ALTER COLUMN ManagerID INT NULL

	UPDATE Departments
	SET ManagerID = NULL
	WHERE DepartmentID = @departmentId

	DELETE FROM Employees
	WHERE DepartmentID = @departmentId

	DELETE FROM Departments
	WHERE DepartmentID = @departmentId

	SELECT COUNT(*)
	FROM Employees AS e
	WHERE e.DepartmentID = @departmentId
	END

EXEC dbo.usp_DeleteEmployeesFromDepartment 2
		
