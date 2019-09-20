CREATE TABLE Users(
Id BIGINT PRIMARY KEY IDENTITY,
Username VARCHAR(30) UNIQUE NOT NULL,
[Password] VARCHAR(26) NOT NULL,
ProfilePicture VARBINARY(MAX),
CHECK(DATALENGTH(ProfilePicture)<=921600),
LastLoginTime DATETIME,
IsDeleted BIT
)

INSERT INTO Users (Username,[Password],ProfilePicture,LastLoginTime,IsDeleted)
 VALUES
('Goshko','123',NULL,NULL,1),
('Moshko','123',NULL,NULL,0),
('Boshko','123',NULL,NULL,1),
('Toshko','123',NULL,NULL,0),
('Loshko','123',NULL,NULL,1)

SELECT * FROM Users
