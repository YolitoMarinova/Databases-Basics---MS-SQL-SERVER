CREATE DATABASE School

USE School

CREATE TABLE Students(
Id INT PRIMARY KEY IDENTITY,
FirstName NVARCHAR(30) NOT NULL,
MiddleName NVARCHAR(25),
LastName NVARCHAR(30) NOT NULL,
Age INT NOT NULL CHECK (Age > 0),
[Address] NVARCHAR(50),
Phone NVARCHAR(10)
)

CREATE TABLE Subjects(
Id INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(20) NOT NULL,
Lessons INT NOT NULL CHECK(Lessons > 0)
)

CREATE TABLE StudentsSubjects(
Id INT PRIMARY KEY IDENTITY,
StudentId INT NOT NULL FOREIGN KEY REFERENCES Students(Id),
SubjectId INT NOT NULL FOREIGN KEY REFERENCES Subjects(Id),
Grade DECIMAL(5,2) NOT NULL CHECK(Grade >=2 AND Grade <= 6)
)

CREATE TABLE Exams(
Id INT PRIMARY KEY IDENTITY,
[Date] DATETIME,
SubjectId INT NOT NULL FOREIGN KEY REFERENCES Subjects(Id)
)

CREATE TABLE StudentsExams(
StudentId INT NOT NULL FOREIGN KEY REFERENCES Students(Id),
ExamId INT NOT NULL FOREIGN KEY REFERENCES Exams(Id),
Grade DECIMAL(5,2) NOT NULL CHECK(Grade >=2 AND Grade <= 6)

PRIMARY KEY (StudentId, ExamId)
)

CREATE TABLE Teachers(
Id INT PRIMARY KEY IDENTITY,
FirstName NVARCHAR(20) NOT NULL,
LastName NVARCHAR(20) NOT NULL,
[Address] NVARCHAR(20) NOT NULL,
Phone CHAR(10),
SubjectId INT NOT NULL FOREIGN KEY REFERENCES Subjects(Id)
)

CREATE TABLE StudentsTeachers(
StudentId INT NOT NULL FOREIGN KEY REFERENCES Students(Id),
TeacherId INT NOT NULL FOREIGN KEY REFERENCES Teachers(Id)

PRIMARY KEY(StudentId, TeacherId)
)