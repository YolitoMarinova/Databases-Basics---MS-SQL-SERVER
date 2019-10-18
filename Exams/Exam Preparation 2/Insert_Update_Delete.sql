USE School

-- INSERT

INSERT INTO Teachers(FirstName, LastName, [Address], Phone, SubjectId)
     VALUES 
	        ('Ruthanne', 'Bamb', '84948 Mesta Junction', '3105500146', 6),
			('Gerrard', 'Lowin', '370 Talisman Plaza', '3324874824', 2),
			('Merrile', 'Lambdin', '81 Dahle Plaza', '4373065154', 5),
			('Bert', 'Ivie', '2 Gateway Circle', '4409584510', 4)

INSERT INTO Subjects([Name], Lessons)
     VALUES 
	        ('Geometry', 12),
			('Health', 10),
			('Drama', 7),
			('Sports', 9)

-- UPDATE

UPDATE ss
   SET ss.Grade = 6.00
  FROM StudentsSubjects AS ss
 WHERE ss.Grade >= 5.50 AND ss.SubjectId IN (1,2)

-- DELETE

DELETE st
  FROM StudentsTeachers AS st
  JOIN Teachers AS t
    ON t.Id = st.TeacherId
 WHERE t.Phone LIKE '%72%'

DELETE 
  FROM Teachers 
 WHERE Phone LIKE '%72%'