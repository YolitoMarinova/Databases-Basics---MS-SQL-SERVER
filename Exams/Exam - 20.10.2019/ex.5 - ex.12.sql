USE [Service]

-- EXCERCISE 5

  SELECT r.[Description], FORMAT( r.OpenDate, 'dd-MM-yyyy') AS OpenDate
    FROM Reports AS r
   WHERE r.EmployeeId IS NULL
ORDER BY r.OpenDate, r.[Description]

-- EXCERCISE 6

  SELECT r.[Description], c.[Name]
    FROM Reports AS r
    JOIN Categories AS c
      ON c.Id = r.CategoryId
   WHERE CategoryId IS NOT NULL
ORDER BY r.[Description], c.[Name]

-- EXCERCISE 7

SELECT TOP(5) c.[Name], COUNT(r.Id)
  FROM Reports AS r
  JOIN Categories AS c
    ON c.Id = r.CategoryId
GROUP BY r.CategoryId, c.[Name]
ORDER BY COUNT(r.Id) DESC, c.[Name]

-- EXCERCISE 8

   SELECT u.Username, c.[Name]
     FROM Reports AS r
     JOIN Users AS u
       ON u.Id = r.UserId
     JOIN Categories AS c
       ON c.Id = r.CategoryId
    WHERE DATEPART(DAY,r.OpenDate) = DATEPART(DAY,u.Birthdate) AND DATEPART(MONTH, r.OpenDate) = DATEPART(MONTH,u.Birthdate)
 ORDER BY u.Username, c.[Name]

-- EXCERCISE 9

   SELECT CONCAT(e.FirstName, ' ', e.LastName) AS [FullName],  COUNT(DISTINCT r.UserId) AS [UsersCount]
     FROM Reports AS r
RIGHT JOIN Employees AS e
       ON e.Id = r.EmployeeId
 GROUP BY r.EmployeeId, e.FirstName, e.LastName
 ORDER BY [UsersCount] DESC, [FullName]

-- EXCERCISE 10

  SELECT IIF((CONCAT(e.FirstName, ' ', e.LastName)) IS NULL 
         OR (CONCAT(e.FirstName, ' ', e.LastName)) = '' , 'None',
		    (CONCAT(e.FirstName, ' ', e.LastName))) AS [Employee], 
         ISNULL(d.[Name], 'None') AS [Department],
  	     c.[Name] AS [Category],
  	     r.[Description],
  	     FORMAT( r.OpenDate, 'dd.MM.yyyy') AS OpenDate,
  	     s.Label AS [Status],
  	     IIF(u.[Name] IS NULL, 'None', u.[Name])  AS [User]
    FROM Reports AS r
    LEFT JOIN Employees AS e
      ON e.Id = r.EmployeeId
    LEFT JOIN Departments AS d
      ON d.Id = e.DepartmentId
    LEFT JOIN Categories AS c
      ON c.Id = r.CategoryId
    LEFT JOIN [Status] AS s
      ON s.Id = r.StatusId
    LEFT JOIN Users AS u
      ON u.Id = r.UserId
ORDER BY e.FirstName DESC, e.LastName DESC, [Department], [Category], r.[Description], r.OpenDate, [Status], [User]

-- EXCERCISE 11

CREATE FUNCTION udf_HoursToComplete (@StartDate DATETIME, @EndDate DATETIME)
    RETURNS INT
             AS
          BEGIN
        DECLARE @hours INT

             IF (@StartDate IS NULL OR @EndDate IS NULL)
          BEGIN 
         RETURN 0
            END

            SET @hours = DATEDIFF(HOUR, @StartDate, @EndDate)
         RETURN @hours
            END

-- EXCERCISE 12

CREATE PROC usp_AssignEmployeeToReport (@EmployeeId INT, @ReportId INT)
		 AS
	  BEGIN 

	  DECLARE @employeeDepartmentId INT = (SELECT DepartmentId FROM Employees WHERE Id = @EmployeeId)
	  DECLARE @categoryDepartmentId INT = (SELECT c.DepartmentId FROM Reports AS r
									       JOIN Categories AS c
										     ON c.Id = r.CategoryId
											WHERE r.Id = @ReportId)

		IF (@employeeDepartmentId <> @categoryDepartmentId)
		BEGIN
		RAISERROR('Employee doesn''t belong to the appropriate department!',16, 1)
		END
		
	  UPDATE Reports
	  SET EmployeeId = @EmployeeId
	  WHERE r.Id = @ReportId	  
	END

