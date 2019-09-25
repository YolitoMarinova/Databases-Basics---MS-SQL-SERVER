USE Diablo

SELECT * FROM Games

SELECT TOP(50) [Name],FORMAT([Start],'yyy-MM-dd') AS [Start] FROM Games
WHERE [Start] BETWEEN '01-01-2011' AND '12-31-2012'
ORDER BY [Start],[Name]

SELECT * FROM Users

  SELECT Username,RIGHT(Email,LEN(Email)-CHARINDEX('@',Email)) AS [Email Provider]
	FROM Users
ORDER BY [Email Provider],Username

SELECT Username,IpAddress 
FROM Users
WHERE IpAddress LIKE '___.1%.%.___'
ORDER BY Username

SELECT * FROM Games

  SELECT [Name] AS Game, IIF(DATEPART(HOUR,[Start])>=0 AND DATEPART(HOUR,[Start])<12,'Morning',IIF(DATEPART(HOUR,[Start])>=12 AND DATEPART(HOUR,[Start])<18,'Afternoon','Evening')) 
	  AS [Part of the Day],
	 IIF(Duration>=0 AND Duration<=3,'Extra Short',IIF(Duration>3 AND Duration<=6,'Short',IIF(Duration>6,'Long','Extra Long'))) 
	  AS Duration
	FROM Games
ORDER BY Game,Duration,[Part of the Day]