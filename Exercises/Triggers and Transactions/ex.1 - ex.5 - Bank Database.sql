USE Bank

--EXCERCISE 1

CREATE TABLE Logs(
LogId INT PRIMARY KEY IDENTITY, 
AccountId INT FOREIGN KEY REFERENCES Accounts(Id),
OldSum DECIMAL(18,2) NOT NULL,
NewSum DECIMAL(18,2) NOT NULL
)

CREATE TRIGGER tr_createLogWhenBalanceIsUpdated ON Accounts INSTEAD OF UPDATE
			AS
		 BEGIN
   INSERT INTO Logs (AccountId, OldSum, NewSum)
	    SELECT i.Id, a.Balance, i.Balance 
	      FROM Accounts AS a
	      JOIN inserted AS i
	        ON i.Id = a.Id
		   END

UPDATE Accounts
   SET Balance = 160
 WHERE Id = 4

--EXCERCISE 2

CREATE TABLE NotificationEmails(
Id INT PRIMARY KEY IDENTITY,
Recipient INT FOREIGN KEY REFERENCES Accounts(Id),
[Subject] NVARCHAR(100) NOT NULL,
Body NVARCHAR(300) NOT NULL
)

CREATE TRIGGER tr_createNewEmail ON Logs FOR INSERT
		    AS
		 BEGIN
   INSERT INTO NotificationEmails (Recipient, [Subject], Body)
	    SELECT AccountId, CONCAT('Balance change for account: ', AccountId), CONCAT('On ',GETDATE(), ' your balance was changed from ', OldSum, ' to ', NewSum,'.')
		  FROM inserted
		   END

--EXCERCISE 3

      CREATE PROC usp_DepositMoney (@AccountId INT, @MoneyAmount DECIMAL(18,4))
       		   AS
BEGIN TRANSACTION				 

		   UPDATE Accounts
			  SET Balance = Balance + @MoneyAmount
		    WHERE Id = @AccountId

		       IF (@MoneyAmount < 0.0)
		    BEGIN
				ROLLBACK
				RETURN
			  END
		   COMMIT

EXEC dbo.usp_DepositMoney 1,10

--EXCERCISE 4

      CREATE PROC usp_WithdrawMoney (@AccountId INT, @MoneyAmount DECIMAL(18,4))
               AS
BEGIN TRANSACTION
		   UPDATE Accounts
			  SET Balance = Balance - @MoneyAmount
			WHERE Id = @AccountId

			   IF (@MoneyAmount < 0.0) AND ((SELECT Balance FROM Accounts WHERE Id=@AccountId) < 0)
			BEGIN
				ROLLBACK
				RETURN				
			  END
		   COMMIT

--EXCERCISE 5

      CREATE PROC usp_TransferMoney (@SenderId INT, @ReceiverId INT, @Amount DECIMAL(18,4))
			   AS
BEGIN TRANSACTION
		     EXEC usp_WithdrawMoney @SenderId, @Amount
		     EXEC usp_DepositMoney @ReceiverId, @Amount
		   COMMIT

