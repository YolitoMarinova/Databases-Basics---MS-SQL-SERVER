USE Bank

--EXCERCISE 9

CREATE PROC usp_GetHoldersFullName
		 AS
	  BEGIN
	 SELECT CONCAT(a.FirstName, ' ', a.LastName)  AS [Full Name]
	   FROM AccountHolders AS a
	    END

EXEC dbo.usp_GetHoldersFullName

--EXCERCISE 10

CREATE PROC usp_GetHoldersWithBalanceHigherThan (@money MONEY)
		 AS
	  BEGIN	 
     SELECT ah.FirstName, ah.LastName
	   FROM Accounts AS a
	   JOIN AccountHolders AS ah
	     ON ah.Id = a.AccountHolderId
   GROUP BY ah.FirstName, ah.LastName
	 HAVING SUM(a.Balance) > @money
   ORDER BY ah.FirstName, ah.LastName
		END

EXEC dbo.usp_GetHoldersWithBalanceHigherThan 50000

--EXCERCISE 11

CREATE FUNCTION ufn_CalculateFutureValue (@sum DECIMAL(18,4), @yearlyInterestRate FLOAT, @numberOfYears INT)
		RETURNS DECIMAL(18,4)
			 AS
		  BEGIN
			 DECLARE @futureValue DECIMAL(18,4)
			     SET @futureValue=@sum * (POWER ((1+@yearlyInterestRate), @numberOfYears))
		      RETURN @futureValue;
			END

--EXCERCISE 12

CREATE PROC usp_CalculateFutureValueForAccount (@accountId INT, @yearlyInterestRate FLOAT)
		 AS
	  BEGIN
	   DECLARE @numberOfYears INT = 5
		SELECT TOP(1) ah.Id, ah.FirstName, ah.LastName, a.Balance, dbo.ufn_CalculateFutureValue(a.Balance,@yearlyInterestRate,@numberOfYears) AS [Balance in 5 years]
		  FROM Accounts AS a
		  JOIN AccountHolders AS ah
		    ON ah.Id = a.AccountHolderId
		 WHERE ah.Id = @accountId
	    END

EXEC dbo.usp_CalculateFutureValueForAccount 1, 0.1


