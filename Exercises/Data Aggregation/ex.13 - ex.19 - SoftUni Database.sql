USE SoftUni

--EXCERCISES 13

SELECT e.DepartmentID,SUM(e.Salary) AS TotalSalary
FROM Employees AS e
GROUP BY e.DepartmentID
ORDER BY e.DepartmentID

--EXCERCISES 14

SELECT e.DepartmentID, MIN(e.Salary)
FROM Employees AS e
WHERE e.HireDate>'01/01/2000' AND e.DepartmentID IN(2,5,7)
GROUP BY e.DepartmentID

--EXCERCISES 15

SELECT *
INTO NewSoftUni
FROM Employees
WHERE Salary>30000

DELETE FROM NewSoftUni WHERE ManagerID = 42

UPDATE NewSoftUni
SET Salary = Salary + 5000
WHERE DepartmentID = 1

SELECT nsu.DepartmentID,AVG(nsu.Salary)
FROM NewSoftUni AS nsu
GROUP BY nsu.DepartmentID

--EXCERCISES 16

SELECT e.DepartmentID, MAX(e.Salary)
FROM Employees AS e
GROUP BY e.DepartmentID
HAVING MAX(e.Salary) NOT BETWEEN 30000 AND 70000

--EXCERCISES 17

SELECT COUNT(e.Salary)
FROM Employees AS e
WHERE e.ManagerID IS NULL

--EXCERCISES 18

SELECT e.DepartmentID, e.Salary AS [ThirdHighestSalary] FROM (
	SELECT e.DepartmentID, e.Salary, 
	DENSE_RANK() OVER(PARTITION BY e.DepartmentID 
	ORDER BY e.Salary DESC) 
	AS [RankSalaries]
	FROM Employees AS e) AS e
WHERE [RankSalaries]=3
GROUP BY DepartmentID, Salary

--EXCERCISES 19

SELECT TOP(10) e1.FirstName, e1.LastName, e1.DepartmentID
FROM Employees AS e1
WHERE e1.Salary> (	
					SELECT AVG(e2.Salary)
					FROM Employees AS e2
					WHERE e2.DepartmentID = e1.DepartmentID
					GROUP BY e2.DepartmentID
					)
ORDER BY e1.DepartmentID
