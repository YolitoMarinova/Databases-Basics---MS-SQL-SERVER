USE Diablo

--EXCERCISE 13

CREATE FUNCTION ufn_CashInUsersGames (@gameName NVARCHAR(50))
  RETURNS TABLE
             AS
         RETURN
         SELECT SUM(r.Cash) AS [SumCash]
           FROM(
               SELECT ug.Cash, ROW_NUMBER() OVER (ORDER BY ug.Cash DESC) AS [Row]
                 FROM UsersGames AS ug
                 JOIN Games AS g
                   ON g.Id = ug.GameId
                WHERE g.[Name] = @gameName) AS r
          WHERE  r.Row % 2 <> 0

SELECT * FROM dbo.ufn_CashInUsersGames ('Love in a mist')