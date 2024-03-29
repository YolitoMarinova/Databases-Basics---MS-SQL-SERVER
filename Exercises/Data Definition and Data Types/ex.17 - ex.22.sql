USE SoftUni

INSERT INTO Towns([Name])
VALUES 
('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas')

INSERT INTO Departments([Name])
VALUES
('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance')

INSERT INTO Employees(FirstName,MiddleName,LastName,JobTitle,DepartmentId,HireDate,Salary)
VALUES
('Ivan', 'Ivanov', 'Ivanov','.NET Developer',4,'02/01/2013',3500.00),
('Petar', 'Petrov', 'Petrov','Senior Engineer',1,'02/02/2004',4000.00),
('Maria', 'Petrova', 'Ivanova','Intern',5,'08/28/2016',525.25),
('Georgi', 'Teziev', 'Ivanov','CEO',2,'12/09/2007',3000.00),
('Peter' ,'Pan',' Pan','Intern',3,'08/28/2016',599.88)

SELECT [Name] FROM Towns
ORDER BY [Name]

SELECT [Name] FROM Departments
ORDER BY [Name]

SELECT FirstName,LastName,JobTitle,Salary FROM Employees
ORDER BY Salary DESC

UPDATE  Employees
SET Salary+=0.1*Salary

SELECT Salary FROM Employees