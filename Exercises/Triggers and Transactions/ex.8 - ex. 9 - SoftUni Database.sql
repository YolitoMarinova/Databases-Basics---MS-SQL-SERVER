USE SoftUni

--EXCERCISE 8

      CREATE PROC usp_AssignProject (@emloyeeId INT, @projectID INT)
               AS
BEGIN TRANSACTION
	  INSERT INTO EmployeesProjects (EmployeeID, ProjectID)
		   VALUES (@emloyeeId, @projectID)

			   IF ((SELECT COUNT(*) FROM EmployeesProjects WHERE EmployeeID = @emloyeeId) > 3)
			BEGIN
		 ROLLBACK
		RAISERROR ('The employee has too many projects!',16,1)
		   RETURN
			  END
		   COMMIT 

--EXERCISE 9

CREATE TABLE Deleted_Employees(
EmployeeId INT PRIMARY KEY IDENTITY,
FirstName NVARCHAR(50) NOT NULL,
LastName NVARCHAR(50) NOT NULL,
MiddleName NVARCHAR(50),
JobTitle NVARCHAR(50) NOT NULL,
DepartmentId INT NOT NULL,
Salary DECIMAL(18,2) NOT NULL
)


CREATE TRIGGER tr_InsertDeletedEmployees ON Employees FOR DELETE
			AS
		 BEGIN
			INSERT INTO Deleted_Employees (FirstName, LastName, MiddleName, JobTitle, DepartmentId, Salary)
				 SELECT FirstName, LastName, MiddleName, JobTitle, DepartmentID, Salary
			       FROM deleted
		   END

