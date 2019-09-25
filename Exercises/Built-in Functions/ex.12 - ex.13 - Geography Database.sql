USE Geography

SELECT * FROM Countries

SELECT CountryName,IsoCode FROM Countries
WHERE CountryName LIKE '%A%A%A%'
ORDER BY IsoCode

SELECT p.PeakName, r.RiverName, LOWER(CONCAT(LEFT(p.PeakName,LEN(p.PeakName)-1),r.RiverName)) AS Mix
 FROM Peaks AS p, Rivers AS r
 WHERE RIGHT(p.PeakName,1) = LEFT(r.RiverName,1)
 ORDER BY Mix