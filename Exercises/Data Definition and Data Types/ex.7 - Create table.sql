CREATE TABLE People(
Id INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(200) NOT NULL,
Picture VARBINARY(MAX),
Height DECIMAL(3,2),
[Weight] DECIMAL (5,2),
Gender CHAR(1) NOT NULL,
Birthdate DATE NOT NULL,
Biography NVARCHAR(MAX)
)

ALTER TABLE People
ADD CHECK (LEN(Picture)<=2097152)

ALTER TABLE People
ADD CHECK (Gender='f' OR Gender='m')

INSERT INTO People([Name],Picture,Height,[Weight],Gender,Birthdate,Biography) VALUES
('Georgi',NULL,1.80,77,'m','1991-02-05',NULL),
('Yoana',NULL,1.53,55,'f','1998-08-10','Really good girl'),
('Mariqn',NULL,1.90,96,'m','1978-02-05',NULL),
('Stoqn',NULL,2.10,110,'m','1993-02-05',NULL),
('Mariika',NULL,1.30,33,'f','2010-02-05',NULL)

SELECT * FROM People

