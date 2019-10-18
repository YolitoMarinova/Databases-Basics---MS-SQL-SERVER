USE Airport

-- EXCERCISE 5

  SELECT *
    FROM Planes
   WHERE LOWER([Name]) LIKE '%tr%'
ORDER BY Id, [Name], Seats, [Range]

-- EXCERCISE 6

  SELECT FlightId, SUM(Price) AS Price
    FROM Tickets
GROUP BY FlightId
ORDER BY Price DESC, FlightId

-- EXCERCISE 7

  SELECT CONCAT(p.FirstName, ' ', p.LastName) AS [Full Name], f.Origin, f.Destination
    FROM Tickets AS t
    JOIN Passengers AS p
      ON p.Id = t.PassengerId
    JOIN Flights AS f
      ON f.Id = t. FlightId
ORDER BY [Full Name], f.Origin, f.Destination

-- EXCERCISE 8

    SELECT p.FirstName, p.LastName, p.Age
      FROM Tickets AS t
RIGHT JOIN Passengers AS p
        ON p.Id = t.PassengerId
     WHERE t.Id IS NULL
  ORDER BY p.Age DESC, p.FirstName, p.LastName

-- EXCERCISE 9

  SELECT CONCAT(p.FirstName, ' ', p.LastName) AS [Full Name],
  	     plane.[Name] AS [Plane Name],
         CONCAT(f.Origin, ' - ', f.Destination) AS [Trip],
  	     lt.[Type] AS [Luggage Type]
    FROM Tickets AS t
    JOIN Passengers AS p
      ON p.Id = t.PassengerId
    JOIN Flights AS f
      ON f.Id = t.FlightId
    JOIN Planes AS plane
      ON plane.Id = f.PlaneId
    JOIN Luggages AS l
      ON l.Id = t.LuggageId
    JOIN LuggageTypes AS lt
      ON lt.Id = l.LuggageTypeId
ORDER BY [Full Name], [Plane Name], f.Origin, f.Destination, lt.[Type]

-- EXCERCISE 10

    SELECT p.[Name], p.Seats, COUNT(t.PassengerId) AS [Passengers Count]
      FROM Tickets AS t
RIGHT JOIN Flights AS f
        ON f.Id = t.FlightId
RIGHT JOIN Planes AS p
        ON p.Id = f.PlaneId
  GROUP BY p.Id, p.[Name], p.Seats
  ORDER BY [Passengers Count] DESC, p.[Name], p.Seats

-- EXCERCISE 11

 CREATE FUNCTION udf_CalculateTickets(@origin NVARCHAR(50), @destination NVARCHAR(50), @peopleCount INT)
RETURNS NVARCHAR(30)
			  AS
		   BEGIN
		 DECLARE @result NVARCHAR(30) = 'Total price '
		 DECLARE @totalPrice DECIMAL(18,2)

			    IF (@peopleCount <= 0 )
		     BEGIN
			   SET @result = 'Invalid people count!'
		       END
		
		   DECLARE @isFlightExist INT = (SELECT COUNT(*)
										   FROM Flights
										  WHERE Origin = @origin AND Destination = @destination
										)
		
		        IF (@isFlightExist <= 0)
		     BEGIN
			   SET @result = 'Invalid flight!'
		       END
			   
			   IF (@peopleCount > 0 AND @isFlightExist > 0) 
			   BEGIN
			   SET @totalPrice = (SELECT SUM(Price) * @peopleCount
			       FROM Tickets AS t
			   	   JOIN Flights AS f
			   	     ON f.Id = t.FlightId
			   	  WHERE f.Origin = @origin AND f.Destination = @destination
			   GROUP BY f.Origin, f.Destination)

			   SET @result += CAST(@totalPrice AS NVARCHAR)
			   END			   

			   RETURN @result
			 END

-- EXCERCISE 12

CREATE PROC usp_CancelFlights
         AS
			UPDATE Flights
			   SET DepartureTime = NULL, ArrivalTime = NULL
			 WHERE (DATEDIFF(day, ArrivalTime, DepartureTime)) <= 0
         GO