ALTER TABLE Users
DROP CONSTRAINT PK_IdAndUsername

ALTER TABLE Users
ADD CONSTRAINT PK_Id
PRIMARY KEY (Id)

ALTER TABLE Users
ADD CONSTRAINT U_Username UNIQUE (Username),
CHECK (LEN(Username)>=3)

