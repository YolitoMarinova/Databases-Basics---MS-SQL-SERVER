USE SoftUni

--EXCERCISE 1

SELECT TOP(5) e.EmployeeID, e.JobTitle, a.AddresSID, a.AddressText
FROM Employees AS e
LEFT JOIN Addresses AS a
ON a.AddressID = e.AddressID
ORDER BY a.AddressID

--EXCERCISE 2

SELECT TOP(50) e.FirstName,e.LastName,t.[Name] AS Town,a.AddressText
FROM Employees AS e
LEFT JOIN Addresses AS a
ON a.AddressID = e.AddressID
LEFT JOIN Towns AS t
ON a.TownID=t.TownID
ORDER BY e.FirstName, e.LastName

--EXCERCISE 3

SELECT e.EmployeeID, e.FirstName, e.LastName, d.[Name] AS [DepartmentName]
FROM Employees AS e
JOIN DeparTments AS d
ON e.DepartmentID = d.DepartmentID
WHERE d.[Name] = 'Sales'
ORDER BY e.EmployeeID

--EXCERCISE 4

SELECT TOP(5) e.EmployeeID, e.FirstName, e.Salary, d.[Name] AS [DepartmentName]
FROM Employees AS e
JOIN Departments AS d
ON e.DepartmentID=d.DepartmentID
WHERE e.Salary > 15000
ORDER BY e.DepartmentID

--EXCERCISE 5

SELECT TOP(3) e.EmployeeID, e.FirstName
FROM Employees AS e
LEFT JOIN EmployeesProjects AS ep
ON e.EmployeeID = ep.EmployeeID
WHERE ep.ProjectID IS NULL
ORDER BY e.EmployeeID

--EXCERCISE 6

SELECT e.FirstName, e.LastName, e.HireDate, d.[Name] AS [DeptName]
FROM Employees AS e
JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID
WHERE e.HireDate>'01/01/1999' AND d.[Name] IN ('Sales','Finance')
ORDER BY e.HireDate

--EXCERCISE 7

SELECT TOP(5) e.EmployeeID, e.FirstName, p.[Name] AS [ProjectName]
FROM Employees AS e
JOIN EmployeesProjects AS ep
ON e.EmployeeID = ep.EmployeeID
JOIN Projects AS p
ON ep.ProjectID = p.ProjectID
WHERE p.StartDate>'08/13/2002' AND p.EndDate IS NULL
ORDER BY e.EmployeeID

--EXCERCISE 8


SELECT  e.EmployeeID, e.FirstName, IIF (p.StartDate>'12/31/2004', NULL, p.[Name]) AS [ProjectName]
FROM Employees AS e
JOIN EmployeesProjects AS ep
ON e.EmployeeID = ep.EmployeeID
JOIN Projects AS p
ON ep.ProjectID = p.ProjectID
WHERE e.EmployeeID = 24

--EXCERCISE 9

SELECT e.EmployeeID, e.FirstName, e.ManagerID, m.FirstName
FROM Employees AS e
JOIN Employees AS m 
ON m.EmployeeID = e.ManagerID
WHERE m.EmployeeID IN (3,7)
ORDER BY e.EmployeeID

--EXCERCISE 10

SELECT TOP(50) e.EmployeeID, 
			   CONCAT(e.FirstName, ' ', e.LastName) AS [EmployeeName], 
			   CONCAT(m.FirstName, ' ', m.LastName) AS  [ManagerName], 
			   d.[Name] AS [DepartmentName]
FROM Employees AS e
JOIN Employees AS m
ON m.EmployeeID = e.ManagerID
JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID
ORDER BY e.EmployeeID

--EXCERCISE 11

SELECT TOP(1) AVG(e.Salary) AS [MinAvarageSalary]
FROM Employees AS e
GROUP BY e.DepartmentID
ORDER BY MinAvarageSalary