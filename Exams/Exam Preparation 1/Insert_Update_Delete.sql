USE  Airport

-- INSERT

INSERT INTO Planes([Name], Seats, [Range])
	 VALUES 
			('Airbus 336', 112, 5132),
			('Airbus 330', 432, 5325),
			('Boeing 369', 231, 2355),
			('Stelt 297', 254, 2143),
			('Boeing 338', 165, 5111),
			('Airbus 558', 387, 1342),
			('Boeing 128', 345, 5541)

INSERT INTO LuggageTypes([Type])
	 VALUES 
		    ('Crossbody Bag'),
			('School Backpack'),
			('Shoulder Bag')

-- UPDATE

UPDATE t
   SET Price = Price + (Price * 13/100)
  FROM Tickets AS t
  JOIN Flights AS f
    ON f.Id = t.FlightId
 WHERE f.Destination = 'Carlsbad'

-- DELETE

DELETE t
  FROM Tickets AS t
  JOIN Flights AS f
    ON f.Id = t.FlightId
 WHERE f.Destination = 'Ayn Halagim'

DELETE 
  FROM Flights 
 WHERE Destination = 'Ayn Halagim'