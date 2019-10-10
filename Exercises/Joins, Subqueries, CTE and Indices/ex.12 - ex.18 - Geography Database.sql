USE [Geography]

--EXCERCISE 12

SELECT mc.CountryCode, m.MountainRange, p.PeakName, p.Elevation
FROM MountainsCountries AS mc
JOIN Mountains AS m
ON m.Id = mc.MountainId
JOIN Peaks AS p
ON p.MountainId = mc.MountainId
WHERE p.Elevation > 2835 AND mc.CountryCode = 'BG'
ORDER BY p.Elevation DESC

--EXCERCISE 13

SELECT mc.CountryCode, COUNT(mc.MountainId)
FROM MountainsCountries AS mc
WHERE mc.CountryCode IN ('BG', 'RU', 'US')
GROUP BY mc.CountryCode

--EXCERCISE 14

SELECT TOP(5) c.CountryName, r.RiverName
FROM Countries AS c
LEFT JOIN CountriesRivers AS cr
ON cr.CountryCode = c.CountryCode
LEFT JOIN Rivers AS r
ON r.Id = cr.RiverId 
WHERE c.ContinentCode = 'AF'
ORDER BY c.CountryName

--EXCERCISE 15

SELECT k.ContinentCode, k.CurrencyCode, k.CountOfCurrency
  FROM (
  SELECT c.ContinentCode, 
	     c.CurrencyCode, COUNT(c.CurrencyCode) AS [CountOfCurrency], 
	     DENSE_RANK() OVER (PARTITION BY c.ContinentCode ORDER BY COUNT(c.CurrencyCode) DESC) AS [CurrencyRank]
    FROM Countries AS c
GROUP BY c.ContinentCode, c.CurrencyCode
HAVING COUNT(c.CurrencyCode) > 1) AS k
WHERE k.CurrencyRank = 1
ORDER BY k.ContinentCode

--EXCERCISE 16

    SELECT COUNT(c.CountryCode)
      FROM Countries AS c
LEFT  JOIN MountainsCountries AS mc
        ON mc.CountryCode = c.CountryCode
     WHERE mc.MountainId IS NULL

--EXCERCISE 17

   SELECT TOP(5) c.CountryName, 
          MAX(p.Elevation) AS [HighestPeakElevation], 
		  MAX(r.[Length]) AS [LongestRiverLength]
     FROM Countries AS c
LEFT JOIN MountainsCountries AS mc
       ON mc.CountryCode = c.CountryCode
LEFT JOIN Mountains AS m
       ON m.Id = mc.MountainId
LEFT JOIN Peaks AS p
       ON p.MountainId = m.Id
LEFT JOIN CountriesRivers AS cr
       ON cr.CountryCode = c.CountryCode
LEFT JOIN Rivers AS r
       ON r.Id = cr.RiverId 
 GROUP BY c.CountryName
 ORDER BY HighestPeakElevation DESC, LongestRiverLength DESC, c.CountryName

--EXCERCISE 18

   SELECT TOP(5) k.CountryName, 
          IIF (k.PeakName IS NULL, '(no highest peak)', k.PeakName) AS [HighestPeakName], 
   		  IIF (k.Elevation IS NULL, '0', k.Elevation) AS [HighestPeakElevation], 
   	      IIF (k.MountainRange IS NULL, '(no mountain)', k.MountainRange) AS [Mountain]
     FROM
      (    SELECT c.CountryName, p.PeakName, p.Elevation, m.MountainRange, DENSE_RANK() OVER(PARTITION BY c.CountryName ORDER BY p.Elevation DESC) AS [Rank]
   	         FROM Countries AS c
        LEFT JOIN MountainsCountries AS mc
   	           ON mc.CountryCode = c.CountryCode
        LEFT JOIN Mountains AS m
   	           ON m.Id = mc.MountainId
        LEFT JOIN Peaks AS p
   	           ON p.MountainId = m.Id
	   ) AS k
    WHERE [Rank] =  1
 ORDER BY k.CountryName, HighestPeakName