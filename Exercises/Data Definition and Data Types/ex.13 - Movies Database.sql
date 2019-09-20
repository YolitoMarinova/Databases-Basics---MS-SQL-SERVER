CREATE DATABASE Movies

CREATE TABLE Directors(
Id INT PRIMARY KEY IDENTITY,
DirectorName NVARCHAR(50) NOT NULL,
Notes NVARCHAR(MAX)
)

INSERT INTO Directors(DirectorName,Notes) VALUES
('Mariqn',NULL),
('Martin','Главен директор'),
('Maq',NULL),
('Pastrisha','From England'),
('Lola',NULL)

CREATE TABLE Genres(
Id INT PRIMARY KEY IDENTITY,
GenreName NVARCHAR(50) NOT NULL,
Notes NVARCHAR(MAX)
)

INSERT INTO Genres(GenreName,Notes) VALUES
('Drama',NULL),
('Romans',NULL),
('Creepy',NULL),
('Comedy',NULL),
('Drama Comedy',NULL)

CREATE TABLE Categories(
Id INT PRIMARY KEY IDENTITY,
CategoryName NVARCHAR(50) NOT NULL,
Notes NVARCHAR(MAX)
)

INSERT INTO Categories(CategoryName,Notes) VALUES
('BG',NULL),
('BG',NULL),
('BG',NULL),
('EN',NULL),
('EN',NULL)

CREATE TABLE Movies(
Id INT PRIMARY KEY IDENTITY,
Title NVARCHAR(30) NOT NULL,
DirectorId INT NOT NULL,
CopyrightYear CHAR(4) NOT NULL,
[Length] INT,
GenreId INT NOT NULL, 
CategoryId INT NOT NULL,
Rating DECIMAL(3,1),
Notes NVARCHAR(MAX),
FOREIGN KEY (DirectorId) REFERENCES Directors(Id),
FOREIGN KEY (GenreId) REFERENCES Genres(Id),
FOREIGN KEY (CategoryId) REFERENCES Categories(Id)
)

INSERT INTO Movies(Title,DirectorId,CopyrightYear,[Length],GenreId,CategoryId,Rating,Notes)
VALUES 
('Zabravena',1,'2012',NULL,1,2,0.5,NULL),
('Otmustiteli',2,'1998',NULL,1,2,0.5,NULL),
('Blq Blq',3,'2001',NULL,1,2,0.5,NULL),
('Djon Burziq Zaek',4,'2019',NULL,1,2,0.5,NULL),
('Polo',5,'2018',NULL,1,2,0.5,NULL)

