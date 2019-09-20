CREATE DATABASE Hotel

CREATE TABLE Employees(
Id INT PRIMARY KEY IDENTITY,
FirstName NVARCHAR(50) NOT NULL,
LastName NVARCHAR(50) NOT NULL,
Title NVARCHAR(50) NOT NULL,
Notes NVARCHAR(MAX)
)

INSERT INTO Employees(FirstName,LastName,Title,Notes)
VALUES
('Gosho','Goshev','Director',NULL),
('Mariq','Mariikova','Cleaning Master',NULL),
('Yoana','Marinova','Manager',NULL)

CREATE TABLE Customers(
AccountNumber INT PRIMARY KEY NOT NULL,
FirstName NVARCHAR(50) NOT NULL,
LastName NVARCHAR(50) NOT NULL,
PhoneNumber INT NOT NULL,
EmergencyName NVARCHAR(50) NOT NULL,
EmergencyNumber INT NOT NULL,
Notes NVARCHAR(MAX)
)

INSERT INTO Customers(AccountNumber,FirstName,LastName,PhoneNumber,EmergencyName,EmergencyNumber,Notes)
VALUES 
(123,'Valentin','Petrov',087785962,'Mariq',0895920848,NULL),
(596,'Teodora','Nikolova',088888888,'Konstantin',0896496568,NULL),
(896,'Filip','Atanasov',0896598633,'Radostina',096858995,NULL)

CREATE TABLE RoomStatus(
RoomStatus NVARCHAR(30) PRIMARY KEY NOT NULL,
Notes NVARCHAR(MAX)
)

INSERT INTO RoomStatus(RoomStatus,Notes)
VALUES
('Clean',NULL),
('In Process','Will be clean soon.'),
('Dirty',NULL)

CREATE TABLE RoomTypes(
RoomType NVARCHAR(50) PRIMARY KEY NOT NULL,
Notes NVARCHAR(MAX)
)

INSERT INTO RoomTypes(RoomType,Notes)
VALUES
('Double',NULL),
('Apartament',NULL),
('Studio',NULL)

CREATE TABLE BedTypes(
BedType NVARCHAR(30) PRIMARY KEY NOT NULL,
Notes NVARCHAR(MAX)
)

INSERT INTO BedTypes(BedType,Notes)
VALUES
('For One Person',NULL),
('Double Bed',NULL),
('Extra Large Double Bed',NULL)

CREATE TABLE Rooms(
RoomNumber INT PRIMARY KEY NOT NULL,
RoomType NVARCHAR(50) NOT NULL,
BedType NVARCHAR(30) NOT NULL,
Rate DECIMAL(15,2) NOT NULL,
RoomStatus NVARCHAR(30) NOT NULL,
Notes NVARCHAR(MAX),
FOREIGN KEY (RoomType) REFERENCES RoomTypes(RoomType),
FOREIGN KEY (BedType) REFERENCES BedTypes(BedType),
FOREIGN KEY (RoomStatus) REFERENCES RoomStatus(RoomStatus)
)

INSERT INTO Rooms(RoomNumber,RoomType,BedType,Rate,RoomStatus,Notes)
VALUES 
(12,'Double','Double Bed',250.00,'Clean',NULL),
(25,'Apartament','Extra Large Double Bed',250.00,'Clean',NULL),
(78,'Studio','For One Person',250.00,'Clean',NULL)

CREATE TABLE Payments(
Id INT PRIMARY KEY IDENTITY,
EmployeeId INT NOT NULL,
PaymentDate DATE NOT NULL,
AccountNumber INT NOT NULL,
FirstDateOccupied DATE NOT NULL,
LastDateOccupied DATE NOT NULL,
TotalDays INT NOT NULL,
AmountCharged DECIMAL(10,2) NOT NULL,
TaxRate DECIMAL (10,2) NOT NULL,
TaxAmount DECIMAL (10,2) NOT NULL,
PaymentTotal DECIMAL (10,2) NOT NULL,
Notes NVARCHAR(MAX),
FOREIGN KEY (EmployeeId) REFERENCES Employees(Id),
FOREIGN KEY (AccountNumber) REFERENCES Customers(AccountNumber)
)

INSERT INTO Payments(EmployeeId,PaymentDate,AccountNumber,FirstDateOccupied,LastDateOccupied,
TotalDays,AmountCharged,TaxRate,TaxAmount,PaymentTotal,Notes)
VALUES
(1,'10/02/2019',123,'01/02/2019','10/02/2019',10,20,20,20,20,NULL),
(2,'10/02/2019',596,'01/02/2019','10/02/2019',10,20,20,20,20,NULL),
(3,'10/02/2019',896,'01/02/2019','10/02/2019',10,20,20,20,20,NULL)

CREATE TABLE Occupancies(
Id INT PRIMARY KEY IDENTITY,
EmployeeId INT NOT NULL,
DateOccupied DATE NOT NULL,
AccountNumber INT NOT NULL,
RoomNumber INT NOT NULL,
RateApplied DECIMAL(10,2) NOT NULL,
PhoneCharge DECIMAL(10,2) NOT NULL,
Notes NVARCHAR(MAX),
FOREIGN KEY (EmployeeId) REFERENCES Employees(Id),
FOREIGN KEY (AccountNumber) REFERENCES Customers(AccountNumber),
FOREIGN KEY (RoomNumber) REFERENCES Rooms(RoomNumber)
)

INSERT INTO Occupancies(EmployeeId,DateOccupied,AccountNumber,RoomNumber,RateApplied,PhoneCharge,Notes)
VALUES
(1,'10/02/2019',123,12,10,10,NULL),
(2,'10/02/2019',596,25,10,10,NULL),
(3,'10/02/2019',896,78,10,10,NULL)