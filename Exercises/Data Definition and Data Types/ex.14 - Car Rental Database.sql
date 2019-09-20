CREATE DATABASE CarRental

CREATE TABLE Categories(
Id INT PRIMARY KEY IDENTITY,
CategoryName NVARCHAR(30) NOT NULL,
DailyRate DECIMAL(5,2) NOT NULL,
WeeklyRate DECIMAL(5,2) NOT NULL,
MonthlyRate DECIMAL(5,2) NOT NULL,
WeekendRate DECIMAL(5,2) NOT NULL
)

INSERT INTO Categories(CategoryName,DailyRate,WeeklyRate,MonthlyRate,WeekendRate)
VALUES
('Cheap',20,80,520,60),
('Standart',35,100,720,75),
('Expencive',50,130,780,100)

CREATE TABLE Cars(
Id INT PRIMARY KEY IDENTITY,
PlateNumber BIGINT NOT NULL,
Manufacturer NVARCHAR(30) NOT NULL,
Model NVARCHAR(30) NOT NULL,
CarYear CHAR(4) NOT NULL,
CategoryId INT NOT NULL,
Doors INT NOT NULL,
Picture VARBINARY(MAX),
Condition NVARCHAR(30) NOT NULL,
Available BIT NOT NULL,
FOREIGN KEY (CategoryId) REFERENCES Categories(Id)
)


INSERT INTO Cars(PlateNumber,Manufacturer,Model,CarYear,CategoryId,Doors,Picture,Condition,Available)
VALUES
(175,'Dacia','Duster','2013',2,4,NULL,'New',1),
(177,'Mercedes','S Class','2017',3,4,NULL,'New',0),
(196,'Wolsklagen','Golf 1','1996',1,2,NULL,'Old',1)

CREATE TABLE Employees(
Id INT PRIMARY KEY IDENTITY,
FirstName NVARCHAR(30) NOT NULL,
LastName NVARCHAR(30) NOT NULL,
Title NVARCHAR(30) NOT NULL,
Notes NVARCHAR(MAX)
)

INSERT INTO Employees(FirstName,LastName,Title,Notes)
VALUES
('Mihail','Petrov','Director',NULL),
('Tanq','Mladenova','Consult','Служител на месеца'),
('Georgi','Filchev','Manager',NULL)

CREATE TABLE Customers(
Id INT PRIMARY KEY IDENTITY,
DriverLicenseNumber BIGINT UNIQUE NOT NULL,
FullName NVARCHAR(130) NOT NULL,
Adress NVARCHAR(100) NOT NULL,
City NVARCHAR(50) NOT NULL,
ZIPCode INT NOT NULL,
Notes NVARCHAR(MAX)
)

INSERT INTO Customers(DriverLicenseNumber,FullName,Adress,City,ZIPCode,Notes)
VALUES
(18956,'Marian Marianov Marianov','Blq Blq','Blq',4444,NULL),
(18569,'Gosho Goshev Goshev','Blq Blq','Blq',4444,NULL),
(23659,'Pesho Peshev Peshev','Blq Blq','Blq',4444,NULL)

CREATE TABLE RentalOrders(
Id INT PRIMARY KEY IDENTITY,
EmployeeId INT NOT NULL,
CustomerId INT NOT NULL,
CarId INT NOT NULL,
TankLevel NVARCHAR(30) NOT NULL,
KilometrageStart INT NOT NULL,
KilometrageEnd INT NOT NULL,
TotalKilometrage INT NOT NULL,
StartDate DATE NOT NULL,
EndDate DATE NOT NULL,
TotalDays INT NOT NULL,
RateApplied DECIMAL (10,2) NOT NULL,
TaxRate DECIMAL (10,2) NOT NULL,
OrderStatus NVARCHAR(50) NOT NULL,
Notes NVARCHAR (MAX),
FOREIGN KEY (EmployeeId) REFERENCES Employees(Id),
FOREIGN KEY (CustomerId) REFERENCES Customers(Id),
FOREIGN KEY (CarId) REFERENCES Cars(Id)
)

INSERT INTO RentalOrders(EmployeeId,CustomerId,CarId,TankLevel,KilometrageStart,KilometrageEnd,TotalKilometrage,
StartDate,EndDate,TotalDays,RateApplied,TaxRate,OrderStatus,Notes)
VALUES
(1,1,2,'Full',100,120,20,'10/12/2012','12/12/2012',2,20,20,'Ready',NULL),
(2,1,3,'Full',100,120,20,'10/12/2012','12/12/2012',2,20,20,'Ready',NULL),
(3,2,1,'Full',100,120,20,'10/12/2012','12/12/2012',2,20,20,'Ready',NULL)