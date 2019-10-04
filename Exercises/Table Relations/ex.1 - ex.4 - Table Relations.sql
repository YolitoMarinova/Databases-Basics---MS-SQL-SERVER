CREATE DATABASE TableRelations

USE TableRelations

-- EXCERCISE 1 - One-To-One

CREATE TABLE Passports(
PassportID INT PRIMARY KEY IDENTITY,
PassportNumber NVARCHAR(10) NOT NULL
)

CREATE TABLE Persons(
PersonID INT PRIMARY KEY IDENTITY,
FirstName NVARCHAR(50) NOT NULL,
Salary DECIMAL(15,2) NOT NULL,
PassportID INT UNIQUE FOREIGN KEY REFERENCES Passports(PassportID)
)

SET IDENTITY_INSERT Passports ON 

INSERT INTO Passports(PassportID,PassportNumber)
VALUES
(101,'N34FG21B'),
(102,'K65LO4R7'),
(103,'ZE657QP2')

SET IDENTITY_INSERT Passports OFF

INSERT INTO Persons(FirstName,Salary,PassportID)
VALUES
('Roberto',43300.00,102),
('Tom',56100.00,103),
('Yana',60200.00,101)

-- EXCERCISE 2 - One-To-Many

CREATE TABLE Manufacturers(
ManufacturerID INT PRIMARY KEY IDENTITY,
[Name] VARCHAR(50) NOT NULL,
EstablishedOn DATE NOT NULL
)

CREATE TABLE Models(
ModelID INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(50) NOT NULL,
ManufacturerID INT FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
)

INSERT INTO Manufacturers([Name],EstablishedOn)
VALUES
('BMW','07/03/1916'),
('Tesla','01/01/2003'),
('Lada','01/05/1966')

SET IDENTITY_INSERT Models ON

INSERT INTO Models(ModelID,[Name],ManufacturerID)
VALUES
(101,'X1',1),
(102,'i6',1),
(103,'Model S',2),
(104,'Model X',2),
(105,'Model 3',2),
(106,'Nova',3)

SET IDENTITY_INSERT Models OFF

-- EXCERCISE 3 - Many-To-Many

CREATE TABLE Students(
StudentID INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(50)
)

INSERT INTO Students([Name])
VALUES
('Mila'),
('Toni'),
('Ron')

CREATE TABLE Exams(
ExamID INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(50)
)

SET IDENTITY_INSERT Exams ON

INSERT INTO Exams(ExamID,[Name])
VALUES
(101,'SpringMVC'),
(102,'Neo4j'),
(103,'Oracle 11g')

SET IDENTITY_INSERT Exams OFF

CREATE TABLE StudentsExams(
StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
ExamID INT FOREIGN KEY REFERENCES Exams(ExamID)

PRIMARY KEY(StudentID,ExamID)
)

INSERT INTO StudentsExams(StudentID,ExamID)
VALUES
(1,101),
(1,102),
(2,101),
(3,103),
(2,102),
(2,103)

-- EXCERCISE 4 - Self-Referencing

CREATE TABLE Teachers(
TeacherID INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(50) NOT NULL,
ManagerID INT FOREIGN KEY REFERENCES Teachers(TeacherID)
)

SET IDENTITY_INSERT Teachers ON;

INSERT INTO Teachers(TeacherID,[Name],ManagerID)
VALUES
(101,'John',NULL),
(102,'Maya',106),
(103,'Silvia',106),
(104,'Ted',105),
(105,'Mark',101),
(106,'Greta',101)

SET IDENTITY_INSERT Teachers OFF;