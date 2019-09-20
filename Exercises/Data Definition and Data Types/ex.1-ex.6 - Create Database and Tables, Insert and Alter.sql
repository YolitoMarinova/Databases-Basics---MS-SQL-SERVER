CREATE  DATABASE Minions

CREATE TABLE Minions (
Id INT NOT NULL,
[Name] NVARCHAR(50),
Age INT
)

CREATE TABLE Towns(
Id INT NOT NULL,
[Name] NVARCHAR(50)
)

ALTER TABLE Minions
ADD CONSTRAINT PK_MinionId PRIMARY KEY (Id)

ALTER TABLE Towns
ADD CONSTRAINT PK_TownId PRIMARY KEY (Id)

ALTER TABLE Minions
ADD TownId INT NOT NULL

ALTER TABLE Minions
ADD CONSTRAINT FK_TownId 
FOREIGN KEY (TownId) REFERENCES Towns(Id)

INSERT INTO Towns(Id,[Name])
VALUES (1,'Sofia')

INSERT INTO Towns(Id,[Name])
VALUES (2,'Plovdiv')

INSERT INTO Towns(Id,[Name])
VALUES (3,'Varna')

INSERT INTO Minions(Id,[Name],Age,TownId)
VALUES (1,'Kevin',22,1)

INSERT INTO Minions(Id,[Name],Age,TownId)
VALUES (2,'Bob',15,3)

INSERT INTO Minions(Id,[Name],Age,TownId)
VALUES (3,'Steward',NULL,2)

TRUNCATE TABLE Minions;

DROP TABLE Minions;

DROP TABLE Towns;