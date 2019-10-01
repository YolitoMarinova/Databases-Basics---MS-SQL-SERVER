USE Gringotts

--EXCERCISES 1

SELECT COUNT(*) FROM WizzardDeposits

----EXCERCISES 2

SELECT MAX(MagicWandSize) AS LongestMagicWand
 FROM WizzardDeposits

--EXCERCISES 3

SELECT W.DepositGroup, MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits W
GROUP BY W.DepositGroup

--EXCERCISES 4

SELECT TOP(2) W.DepositGroup
FROM WizzardDeposits W
GROUP BY W.DepositGroup
ORDER BY AVG(W.MagicWandSize)

--EXCERCISES 5

SELECT W.DepositGroup, SUM(W.DepositAmount) AS TotalSum
FROM WizzardDeposits W
GROUP BY W.DepositGroup

--EXCERCISES 6

SELECT W.DepositGroup, SUM(W.DepositAmount) AS TotalSum
FROM WizzardDeposits W
WHERE W.MagicWandCreator='Ollivander family'
GROUP BY W.DepositGroup

--EXCERCISES 7

SELECT W.DepositGroup, SUM(W.DepositAmount) AS TotalSum
FROM WizzardDeposits W
WHERE W.MagicWandCreator='Ollivander family'
GROUP BY W.DepositGroup
HAVING SUM(W.DepositAmount) < 150000
ORDER BY SUM(W.DepositAmount) DESC

--EXCERCISES 8

SELECT w.DepositGroup, w.MagicWandCreator, MIN(w.DepositCharge) AS MinDepositCharge
FROM WizzardDeposits w
GROUP BY w.MagicWandCreator, w.DepositGroup
ORDER BY w.MagicWandCreator,w.DepositGroup

--EXCERCISES 9

SELECT Age,COUNT(*) AS [WizardCount] FROM(
SELECT
	CASE 
		WHEN w.Age>=0 AND w.Age <=10 THEN '[0-10]'
		WHEN w.Age>=11 AND w.Age <=20 THEN '[11-20]'
		WHEN w.Age>=21 AND w.Age <=30 THEN '[21-30]'
		WHEN w.Age>=31 AND w.Age <=40 THEN '[31-40]'
		WHEN w.Age>=41 AND w.Age <=50 THEN '[41-50]'
		WHEN w.Age>=51 AND w.Age <=60 THEN '[51-60]'
		ELSE '[61+]'
		END AS Age
		FROM WizzardDeposits w
) AS a
GROUP BY Age

--EXCERCISES 10

SELECT LEFT(FirstName,1) AS FirstLetter
FROM WizzardDeposits
WHERE DepositGroup='Troll Chest'
GROUP BY LEFT(FirstName,1)
ORDER BY FirstLetter

--EXCERCISES 11

SELECT w.DepositGroup, w.IsDepositExpired,AVG(w.DepositInterest)
FROM WizzardDeposits w
WHERE w.DepositStartDate>'01/01/1985'
GROUP BY w.DepositGroup,w.IsDepositExpired
ORDER BY w.DepositGroup DESC, w.IsDepositExpired

--EXCERCISES 12

SELECT SUM([Difference]) FROM (SELECT w.FirstName AS [Host Wizard],
	   w.DepositAmount AS [Host Wizard Deposit],
	   LEAD(w.FirstName) OVER(ORDER BY w.Id) AS [Guest Wizard],
	   LEAD(w.DepositAmount) OVER(ORDER BY Id) AS [Guest Wizard Deposit],
	   w.DepositAmount - LEAD(w.DepositAmount) OVER(ORDER BY Id) AS [Difference]
FROM WizzardDeposits w) AS DiffTable