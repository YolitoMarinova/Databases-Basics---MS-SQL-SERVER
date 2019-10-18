USE School

-- EXCERCISE 5

  SELECT FirstName, LastName, Age
    FROM Students
   WHERE Age >= 12
ORDER BY FirstName, LastName

-- EXCERCISE 6

  SELECT s.FirstName, s.LastName, COUNT(st.TeacherId) AS TeachersCount
    FROM StudentsTeachers AS st
	JOIN Students AS s
	  ON s.Id = st.StudentId
GROUP BY st.StudentId, s.FirstName, s.LastName
ORDER BY s.LastName

-- EXCERCISE 7

    SELECT CONCAT(s.FirstName, ' ', s.LastName) AS [Full Name]
      FROM StudentsExams AS se
RIGHT JOIN Students AS s
	    ON s.Id = se.StudentId
	 WHERE se.StudentId IS NULL
  ORDER BY [Full Name]

-- EXCERCISE 8

  SELECT TOP(10) s.FirstName, s.LastName, CAST((SUM(se.Grade) / COUNT(se.ExamId))AS DECIMAL(5,2)) AS [Grade]
    FROM StudentsExams AS se
    JOIN Students AS s
      ON s.Id = se.StudentId
GROUP BY s.FirstName, s.LastName
ORDER BY [Grade] DESC, s.FirstName, s.LastName

-- EXCERCISE 9

   SELECT CONCAT(s.FirstName, ' ', IIF(s.MiddleName IS NOT NULL, s.MiddleName + ' ', ''), s.LastName) AS [Full Name]
     FROM Students AS s
LEFT JOIN StudentsSubjects AS ss
       ON ss.StudentId = s.Id
	WHERE ss.StudentId IS NULL
 ORDER BY [Full Name]

-- EXCERCISE 10
  
  SELECT s.Name, (SUM(ss.Grade) / COUNT(ss.StudentId)) AS AverageGrade
    FROM Subjects AS s
    JOIN StudentsSubjects AS ss
	  ON ss.SubjectId = s.Id
GROUP BY s.Name, s.Id
ORDER BY s.Id

-- EXCERCISE 11

 CREATE FUNCTION udf_ExamGradesToUpdate (@studentId INT, @grade DECIMAL(15,2))
RETURNS NVARCHAR(100)
     AS
  BEGIN
DECLARE @studentExist INT = (SELECT TOP(1) StudentId FROM StudentsExams WHERE StudentId = @studentId);
     IF (@studentExist IS NULL)
  BEGIN
 RETURN ('The student with provided id does not exist in the school!')
    END

     IF (@grade > 6.00)
  BEGIN
 RETURN ('Grade cannot be above 6.00!')
    END
DECLARE @studentFirstName NVARCHAR(20) = (SELECT TOP(1) FirstName FROM Students WHERE Id = @studentId);
DECLARE @biggestGrade DECIMAL(15,2) = @grade + 0.50;
DECLARE @count INT = (SELECT Count(Grade) FROM StudentsExams
  WHERE StudentId = @studentId AND Grade >= @grade AND Grade <= @biggestGrade)
 RETURN ('You have to update ' + CAST(@count AS nvarchar(10)) + ' grades for the student ' + @studentFirstName)
    END

-- EXCERCISE 12

CREATE PROC usp_ExcludeFromSchool (@StudentId INT)
         AS 
    DECLARE @TargetStudentId INT = (SELECT Id FROM Students WHERE Id = @StudentId)

         IF (@TargetStudentId IS NULL)
      BEGIN
  RAISERROR('This school has no student with the provided id!', 16, 1)
	 RETURN
        END

     DELETE FROM StudentsExams
      WHERE StudentId = 5

     DELETE FROM StudentsSubjects
      WHERE StudentId = 5

     DELETE FROM StudentsTeachers
      WHERE StudentId = 5

     DELETE FROM Students
      WHERE Id = 5
