USE Examination_System

GO
---student
---department
---instructor
---courses
---topics

---------------------------------------------------The Primary Tables-----------------------------------------------------
-- START with Student table
---------------------------------------------------------INSERT-----------------------------------------------------------
CREATE PROC Insert_Student @Student_ID int, @Fname nvarchar(20), @Mname nvarchar(20), @Lname nvarchar(20), @Gender nvarchar(10), @DOB date, 
						   @City nvarchar(20), @Street nvarchar(50), @ZipCode int, @SocialAccount text, 
						   @Login nvarchar(50), @Password nvarchar(50), @Department_ID int
AS
BEGIN
  IF NOT EXISTS (SELECT Student_ID FROM Student WHERE Student_ID = @Student_ID)
    INSERT INTO Student (Student_ID, Fname, Mname, Lname, Gender, DOB, City, Street, ZipCode, SocialAccount, Login, Password, Department_ID)
    VALUES (@Student_ID, @Fname, @Mname, @Lname, @Gender, @DOB, @City, @Street, @ZipCode, @SocialAccount, @Login, @Password, @Department_ID)
  ELSE
    PRINT ('Student "' + @Fname + ' ' + @Lname + '" already exists')
END

GO
---------------------------------------------------------UPDATE-----------------------------------------------------------
CREATE PROC Update_Student @Student_ID int, @Fname nvarchar(20), @Mname nvarchar(20), @Lname nvarchar(20), @Gender nvarchar(10), @DOB date, 
						   @City nvarchar(20), @Street nvarchar(50), @ZipCode int, @SocialAccount text, 
						   @Login nvarchar(50), @Password nvarchar(50), @Department_ID int
AS
BEGIN
  IF EXISTS (SELECT Student_ID FROM Student WHERE Student_ID = @Student_ID)
  BEGIN
    UPDATE Student 
	SET Fname = @Fname, Mname = @Mname, Lname = @Lname, Gender = @Gender, DOB =CONVERT(date, CONVERT(varchar(8), 101)), City = @City, Street = @Street,
		ZipCode = @ZipCode, Department_ID = @Department_ID  
	WHERE Student_ID = @Student_ID
  END
  ELSE
    PRINT ('Student #' + CAST(@Student_ID AS varchar(20)) + ' doesn''t exists')
END

GO
---------------------------------------------------------DELETE-----------------------------------------------------------
CREATE PROC Delete_Student @Student_ID int
AS
BEGIN
  IF EXISTS (SELECT Student_ID FROM Student WHERE Student_ID = @Student_ID)
    DELETE FROM Student WHERE Student_ID = @Student_ID
  ELSE
    PRINT ('Student #' + CAST(@ST_ID AS varchar(20)) + ' doesn''t exists')
END

GO
---------------------------------------------------------SELECT-----------------------------------------------------------
CREATE PROC Select_Student @Student_ID int
AS
BEGIN
  SELECT Student_ID 
  FROM Student 
  WHERE City like 'Alex';  
END

GO
-- End Student table

-- START with Department table
---------------------------------------------------------INSERT-----------------------------------------------------------
CREATE PROC Insert_Department @Department_ID int, @Department_Name nvarchar(50), @DB_Manager nvarchar(50), @Instructor_ID int
AS
BEGIN
  IF NOT EXISTS (SELECT Department_ID FROM Department WHERE Department_ID = @Department_ID)
    INSERT INTO Department (Department_ID, Department_Name, DB_Manager) 
	VALUES (@Department_ID, @Department_Name, @DB_Manager)
  ELSE
    PRINT ('Department ' + @Department_Name + ' already exists')
END

GO
---------------------------------------------------------UPDATE-----------------------------------------------------------
CREATE PROC Update_Department @Department_ID int, @Department_Name nvarchar(50), @DB_Manager nvarchar(50), @Instructor_ID int
AS
BEGIN
  IF EXISTS (SELECT Department_ID FROM Department WHERE Department_ID = @Department_ID)
    UPDATE Department 
	SET Department_Name = @Department_Name
	WHERE Department_ID = @Department_ID
  ELSE
    PRINT ('Department #' + CAST(@Department_ID AS varchar(20))+ @Department_Name + ' doesn''t exists')
END

GO
---------------------------------------------------------DELETE-----------------------------------------------------------
CREATE PROC Delete_Department @Department_ID int
AS
BEGIN
  IF EXISTS (SELECT Department_ID FROM Department WHERE Department_ID = @Department_ID)
  BEGIN
    IF NOT EXISTS (SELECT Department_ID FROM Department WHERE Department_ID = @Department_ID)
      DELETE Department WHERE Department_ID = @Department_ID
    ELSE
      PRINT ('Department #' + CAST(@Department_ID AS varchar(20)) + ' can''t be deleted')
  END
  ELSE
    PRINT ('Department #' + CAST(@Department_ID AS varchar(20)) + ' doesn''t exists')
END

GO
---------------------------------------------------------SELECT-----------------------------------------------------------
CREATE PROC Select_Department @Department_ID int
AS
BEGIN
  SELECT Department_ID 
  FROM Department
  WHERE Department_Name = 'Development';  
END

GO
-- End Department table

-- START with Instructor table
---------------------------------------------------------INSERT-----------------------------------------------------------
CREATE PROC Insert_Instructor @Instructor_ID int, @Instructor_Fullname nvarchar(50), @Gender nvarchar(10), @DOB date, @Salary money, @Department_ID int
AS
BEGIN
  IF NOT EXISTS (SELECT Instructor_ID FROM Instructor WHERE Instructor_ID = @Instructor_ID)
    INSERT INTO Instructor (Instructor_ID, Instructor_Fullname, Gender, DOB, Salary, Department_ID)
      VALUES (@Instructor_ID, @Instructor_Fullname, @Gender, @DOB, @Salary, @Department_ID)
  ELSE
    PRINT ('Instructor "' + @Instructor_ID + ' ' + @Instructor_Fullname + '" already exists')
END

GO
---------------------------------------------------------UPDATE-----------------------------------------------------------
CREATE PROC Update_Instructor @Instructor_ID int, @Instructor_Fullname nvarchar(50), @Gender nvarchar(10), @DOB date, @Salary money, @Department_ID int
AS
BEGIN
  IF EXISTS (SELECT Instructor_ID FROM Instructor WHERE Instructor_ID = @Instructor_ID)
  BEGIN
    UPDATE Instructor 
	SET Instructor_Fullname = @Instructor_Fullname, DOB = CONVERT(date, CONVERT(varchar(8), 101)), Salary = @Salary, Department_ID = @Department_ID 
	WHERE Instructor_ID = @Instructor_ID
  END
  ELSE
    PRINT ('Instructor #' + CAST(@Instructor_ID AS varchar(20)) + ' doesn''t exists')
END

GO
---------------------------------------------------------DELETE-----------------------------------------------------------
CREATE PROC Delete_Instructor @Instructor_ID int
AS
BEGIN
  IF EXISTS (SELECT Instructor_ID FROM Instructor WHERE Instructor_ID = @Instructor_ID)
	PRINT ('Instructor "' + @Instructor_ID + ' ' + @Instructor_Fullname + '" already exists')
  ELSE
    PRINT ('Instructor #' + CAST(@Instructor_ID AS varchar(20)) + ' doesn''t exists')
END

GO
---------------------------------------------------------SELECT-----------------------------------------------------------
CREATE PROC Select_Instructor @Instructor_ID int
AS
BEGIN
  SELECT Instructor_ID, Instructor_Fullname
  FROM Instructor
  WHERE Salary >= 8000;  
END

GO
-- End Instructor table

-- START with Course table
---------------------------------------------------------INSERT-----------------------------------------------------------
CREATE PROC Insert_Course @Course_ID int, @Course_Name nvarchar(50), @Course_Hours float, @Course_Category nvarchar(15), @Introduced_by nvarchar(15), @Department_ID int
AS
BEGIN
  IF Not EXISTS (SELECT Course_ID FROM Course WHERE Course_ID = @Course_ID)
    INSERT INTO Course (Course_ID , Course_Name, Course_Hours, Course_Category, Introduced_by, Department_ID)
	VALUES (@Course_ID, @Course_Name, @Course_Hours, @Course_Category, @Introduced_by, @Department_ID)
  ELSE
    PRINT ('Course "' + CAST(@Course_ID AS varchar(20)) + @Course_Name + '" already exists')
END

GO
---------------------------------------------------------UPDATE-----------------------------------------------------------
CREATE PROC Update_Course @Course_ID int, @Course_Name nvarchar(50)
AS
BEGIN
  IF EXISTS (SELECT Course_ID FROM Course WHERE Course_ID = @Course_ID)
    UPDATE Course 
	SET Course_Name = @Course_Name 
	WHERE Course_ID = @Course_ID
  ELSE
    PRINT ('Course #' + CAST(@Course_ID AS varchar(20)) + ' doesn''t exists')
END

GO
---------------------------------------------------------DELETE-----------------------------------------------------------
CREATE PROC Delete_Course @Course_ID int
AS
BEGIN
  IF EXISTS (SELECT Course_ID FROM Course WHERE Course_ID = @Course_ID)
  BEGIN
    IF NOT EXISTS (SELECT Course_ID FROM Instructor_Course WHERE Course_ID = @Course_ID)
	AND NOT EXISTS (SELECT Course_ID FROM Topic WHERE Course_ID = @Course_ID)
	AND NOT EXISTS (SELECT Course_ID FROM Student_Course WHERE Course_ID = @Course_ID)
	AND NOT EXISTS (SELECT Course_ID FROM Exam WHERE Course_ID = @Course_ID)
	AND NOT EXISTS (SELECT Course_ID FROM Question WHERE Course_ID = @Course_ID)
	  DELETE FROM Course WHERE Course_ID = @Course_ID
    ELSE
	 PRINT ('Course #' + CAST(@Course_ID AS varchar(20)) + ' can''t be deleted')
  END
  ELSE
    PRINT ('Course #' + CAST(@Course_ID AS varchar(20)) + ' doesn''t exists')
END

GO
---------------------------------------------------------SELECT-----------------------------------------------------------
CREATE PROC Select_Course @Course_ID int
AS
BEGIN
  SELECT Course_ID, Course_Name
  FROM Course
  WHERE Course_Hours >= 50;  
END

GO
-- End Course table

-- START with Topic table
---------------------------------------------------------INSERT-----------------------------------------------------------
CREATE PROC Insert_Topic @Topic_ID int, @Topic_Name nvarchar(100), @Course_ID int
AS
BEGIN
  IF NOT EXISTS (SELECT Topic_ID FROM Topic WHERE Topic_ID = @Topic_ID AND Course_ID = @Course_ID)
  BEGIN
    INSERT INTO Topic (Topic_ID, Topic_Name, Course_ID) 
	VALUES (@Topic_ID, @Topic_Name, @Course_ID)
  END
  ELSE
    PRINT ('Topic "' + CAST(@Topic_ID AS varchar(20)) + @Topic_Name + '" already exists')
END

GO
---------------------------------------------------------UPDATE-----------------------------------------------------------
CREATE PROC Update_Topic @Topic_ID int, @Topic_Name nvarchar(100), @Course_ID int
AS
BEGIN
  IF EXISTS (SELECT Topic_ID FROM Topic WHERE Topic_ID = @Topic_ID AND Course_ID = @Course_ID)
      UPDATE Topic 
	  SET Topic_Name = @Topic_Name 
	  WHERE Topic_ID = @Topic_ID
  ELSE
    PRINT ('Topic #' + CAST(@Topic_ID AS varchar(20)) + @Topic_Name + ' doesn''t exists')
END

GO
---------------------------------------------------------DELETE-----------------------------------------------------------
CREATE proc Delete_Topic @Topic_ID int, @Topic_Name nvarchar(100), @Course_ID int
AS
BEGIN
  IF EXISTS (SELECT Topic_ID FROM Topic WHERE Topic_ID = @Topic_ID AND Course_ID = @Course_ID)
    DELETE FROM Topic WHERE Topic_ID = @Topic_ID
  ELSE
    PRINT ('Topic #' + CAST(@Topic_ID AS varchar(20)) + @Topic_Name + ' doesn''t exists')
END

GO 
---------------------------------------------------------SELECT-----------------------------------------------------------
CREATE PROC Select_Topic @Topic_ID int
AS
BEGIN
  SELECT t.Topic_ID, t.Topic_Name, c.Course_Name
  FROM Topic as t
  join Course as c
  on t.Course_ID = c.Course_ID;  
END

GO
-- End Topic table

-- START with Exam table
---------------------------------------------------------INSERT-----------------------------------------------------------
CREATE PROC Insert_Exam @Exam_ID int, @Exam_Title nvarchar(50), @Course_ID int, @Student_ID int, @Total_Result int
AS
BEGIN
  IF NOT EXISTS (SELECT Exam_ID FROM Exam WHERE Exam_ID = @Exam_ID)
    INSERT INTO Exam(Exam_ID, Exam_Title, Course_ID, Student_ID, Total_Result)
	VALUES (@Exam_ID,@Exam_Title, @Course_ID, @Student_ID, @Total_Result)
  ELSE
    PRINT ('Exam "' + CAST(@Question_ID AS varchar(20)) + '" already exists')
END

GO
---------------------------------------------------------UPDATE-----------------------------------------------------------
CREATE PROC Update_Exam @Exam_ID int, @Exam_Title nvarchar(50), @Course_ID int, @Student_ID int, @Total_Result int
AS
   begin try
	UPDATE Exam
	SET Exam_ID = @Exam_ID, Exam_Title = @Exam_Title, Course_ID = @Course_ID, Student_ID = @Student_ID	
	WHERE Exam_ID = @Exam_ID
	  end try
   begin catch
	  select 'ERROR: VALUE IS NOT EXISTED'
   end catch
GO
---------------------------------------------------------DELETE-----------------------------------------------------------
CREATE PROC Delete_Exam @Exam_ID INT
AS
   begin try
	DELETE FROM Exam
	WHERE Exam_ID = @Exam_ID
	  end try
   begin catch
	  select 'ERROR: VALUE IS NOT EXISTED'
   end catch
GO
---------------------------------------------------------SELECT-----------------------------------------------------------
CREATE PROC Select_Exam @Exam_ID INT
AS
   begin try
	select * FROM Exam
	WHERE Exam_ID = @Exam_ID
	  end try
   begin catch
	  select 'ERROR: ID IS NOT EXISTED'
   end catch
GO
-- End Exam table

-- START with Question table
---------------------------------------------------------INSERT-----------------------------------------------------------
CREATE PROC Insert_Question @Question_ID int, @Question_Formulation text, @Question_type nvarchar(20), @Model_Answer nvarchar(120), @Question_Score int, @Course_ID int
AS
BEGIN
  IF NOT EXISTS (SELECT @Question_ID FROM Question WHERE Question_ID = @Question_ID)
    INSERT INTO Question(Question_ID,Question_Formulation,Question_Type, Model_Answer)
	VALUES (@Question_ID,@Question_Formulation, @Question_type, @Model_Answer, @Question_Score)
  ELSE
    PRINT ('Question "' + CAST(@Question_ID AS varchar(20)) + '" already exists')
END

GO
---------------------------------------------------------UPDATE-----------------------------------------------------------
CREATE PROC Update_Question @Question_ID int, @Question_Formulation text, @Question_type nvarchar(20), @Model_Answer nvarchar(120), @Question_Score int, @Course_ID int
AS
BEGIN
  IF EXISTS (SELECT Question_ID FROM Question WHERE Question_ID = @Question_ID)
    UPDATE Question 
	SET Question_Formulation = @Question_Formulation 
	WHERE Question_ID = @Question_ID
  ELSE
    PRINT ('ERROR: VALUE IS NOT EXISTED')
END

GO
---------------------------------------------------------DELETE-----------------------------------------------------------
CREATE PROC Delete_Question @Question_ID int
AS
   begin try
	DELETE FROM Question
	WHERE Question_ID = @Question_ID
	  end try
   begin catch
	  select 'ERROR: VALUE IS NOT EXISTED'
   end catch
GO
---------------------------------------------------------SELECT-----------------------------------------------------------
CREATE PROC Select_Questions @Question_ID INT
AS
   begin try
	select * FROM Question
	WHERE Question_ID = @Question_ID
	  end try
   begin catch
	  select 'ERROR: ID IS NOT EXISTED'
   end catch
GO
-- End Question table

---------------------------------------------------The Secondary Tables-----------------------------------------------------
-- START with Student_Course table
---------------------------------------------------------INSERT-----------------------------------------------------------
CREATE PROC Insert_Student_Course @Student_ID int, @Course_ID int
AS
BEGIN
  IF NOT EXISTS (SELECT Student_ID, Course_ID FROM Student_Course WHERE Student_ID = @Student_ID)
    INSERT INTO Student_Course(Student_ID, Course_ID)
	VALUES (@Student_ID, @Course_ID)
  ELSE
    PRINT ('Student Course "' + @Student_ID + '" already exists')
END

GO
---------------------------------------------------------UPDATE-----------------------------------------------------------
CREATE PROC Update_Student_Course @Student_ID int, @Course_ID int
AS
BEGIN
  IF EXISTS (SELECT Student_ID, Course_ID FROM Student_Course WHERE Student_ID = @Student_ID)
    UPDATE Student_Course 
	SET Course_ID = @Course_ID
	WHERE Student_ID = @Student_ID
  ELSE
    PRINT ('ERROR: VALUE IS NOT EXISTED')
END

GO
---------------------------------------------------------DELETE-----------------------------------------------------------
CREATE PROC Delete_Student_Course @Student_ID int
AS
   begin try
	DELETE FROM Student_Course
	WHERE Student_ID = @Student_ID
	  end try
   begin catch
	  select 'ERROR: VALUE IS NOT EXISTED'
   end catch
GO
---------------------------------------------------------SELECT-----------------------------------------------------------
CREATE PROC select_Student_Course @Student_ID INT
AS
   begin try
	select * FROM Student_Course
	WHERE Student_ID = @Student_ID
	  end try
   begin catch
	  select 'ERROR: ID IS NOT EXISTED'
   end catch
GO
-- End Student_Course table

-- START with Student_Phone table
CREATE PROC Insert_StudentPhone @Student_ID int, @PhoneNo1 int , @PhoneNo2 int
AS
BEGIN
  IF NOT EXISTS (SELECT Student_ID FROM Student_Phone WHERE Student_ID = @Student_ID)
    INSERT INTO Student_Phone(Student_ID, PhoneNo1, PhoneNo2)
      VALUES (@Student_ID, @PhoneNo1, @PhoneNo2)
  ELSE
    PRINT ('Student Phone "' + @Student_ID + '" already exists')
END

GO
---------------------------------------------------------UPDATE-----------------------------------------------------------
CREATE PROC Update_Student_Phone @Student_ID int, @PhoneNo1 int ,@PhoneNo2 int
AS
BEGIN
  IF EXISTS (SELECT Student_ID FROM Student_Phone WHERE Student_ID = @Student_ID)
    UPDATE Student_Phone 
	SET PhoneNo1 = @PhoneNo1 , PhoneNo2= @PhoneNo2
	WHERE Student_ID = @Student_ID
  ELSE
    PRINT ('ERROR: VALUE IS NOT EXISTED')
END

GO
---------------------------------------------------------DELETE-----------------------------------------------------------
CREATE PROC Delete_Student_Phone @Student_ID int
AS
   begin try
	DELETE FROM Student_Phone
	WHERE Student_ID = @Student_ID
	  end try
   begin catch
	  select 'ERROR: VALUE IS NOT EXISTED'
   end catch
GO
---------------------------------------------------------SELECT-----------------------------------------------------------
CREATE PROC Select_Student_Phone @Student_ID INT
AS
   begin try
	select * FROM Student_Phone
	WHERE Student_ID = @Student_ID
	  end try
   begin catch
	  select 'ERROR: ID IS NOT EXISTED'
   end catch
GO
-- End Student_Phone table

-- START with Instructor_Course table
---------------------------------------------------------INSERT-----------------------------------------------------------
CREATE PROC Insert_Instructor_Course @Instructor_ID int, @Course_ID int
AS
BEGIN
  IF NOT EXISTS (SELECT Instructor_ID FROM Instructor_Course WHERE Instructor_ID = @Instructor_ID)
    INSERT INTO Instructor_Course(Instructor_ID, Course_ID)
      VALUES (@Instructor_ID, @Course_ID)
  ELSE
    PRINT ('Instructor Course "' + @Instructor_ID + '" already exists')
END

GO
---------------------------------------------------------UPDATE-----------------------------------------------------------
CREATE PROC Update_Instructor_Course @Instructor_ID int, @Course_ID int
AS
BEGIN
  IF EXISTS (SELECT Instructor_ID FROM Instructor_Course WHERE Instructor_ID = @Instructor_ID)
    UPDATE Instructor_Course SET Course_ID = @Course_ID
	WHERE Instructor_ID = @Instructor_ID
  ELSE
    PRINT ('ERROR: VALUE IS NOT EXISTED')
END

GO
---------------------------------------------------------DELETE-----------------------------------------------------------
CREATE PROC Delete_Instructor_Course @Instructor_ID int
AS
   begin try
	DELETE FROM Instructor_Course
	WHERE Instructor_ID = @Instructor_ID
	  end try
   begin catch
	  select 'ERROR: VALUE IS NOT EXISTED'
   end catch
GO
---------------------------------------------------------SELECT-----------------------------------------------------------
CREATE PROC Select_Instructor_Course @Instructor_ID INT
AS
   begin try
	select * FROM Instructor_Course
	WHERE Instructor_ID = @Instructor_ID
	  end try
   begin catch
	  select 'ERROR: ID IS NOT EXISTED'
   end catch
GO
-- End Instructor_Course table

-- START with Exam_Taken table
---------------------------------------------------------INSERT-----------------------------------------------------------
CREATE PROC Insert_Exam_Taken @Exam_Taken_ID int, @Student_ID int, @Student_Answer nvarchar(120), @Question_ID int, @Exam_ID int, @Result int
AS
BEGIN
  IF NOT EXISTS (SELECT @Student_ID FROM Exam_Taken WHERE Student_ID = @Student_ID)
    INSERT INTO Exam_Taken(Exam_Taken_ID, Student_ID, Student_Answer, Question_ID, Exam_ID, Result)
	VALUES (@Exam_Taken_ID, @Question_ID,@Student_Answer, @Question_ID, @Exam_ID, @Result)
  ELSE
    PRINT ('Exam "' + CAST(@Student_ID AS varchar(20)) + '" already taken')
END

GO
---------------------------------------------------------UPDATE-----------------------------------------------------------
CREATE PROC Update_Exam_taken @Exam_Taken_ID int, @Student_ID int, @Student_Answer nvarchar(120), @Question_ID int, @Exam_ID int, @Result int
AS
   begin try
	UPDATE Exam_Taken
	SET Exam_Taken_ID = @Exam_Taken_ID, Student_ID = @Student_ID, Student_Answer = @Student_Answer, Question_ID = @Question_ID, Exam_ID = @Exam_ID, Result = @Result	
	WHERE Student_ID = @Student_ID
	  end try
   begin catch
	  select 'ERROR: VALUE IS NOT EXISTED'
   end catch
GO
---------------------------------------------------------DELETE-----------------------------------------------------------
CREATE PROC Delete_Exam_Taken @Exam_Taken_ID int, @Student_ID INT, @Student_Answer varchar(max), @Question_ID INT, @Exam_ID int , @Result int
AS
   begin try
	DELETE FROM Exam_Taken
	WHERE Exam_Taken_ID = @Exam_Taken_ID AND Student_ID = @Student_ID AND Student_Answer = @Student_Answer AND Question_ID = @Question_ID AND Exam_ID = @Exam_ID AND Result = @Result 
	  end try
   begin catch
	  select 'ERROR: VALUE IS NOT EXISTED'
   end catch
GO
---------------------------------------------------------SELECT-----------------------------------------------------------
CREATE PROC Select_Answer @Student_ID INT, @Student_Answer varchar(max)
AS
   begin try
	select * FROM Exam_Taken
	WHERE Student_ID = @Student_ID AND Student_Answer = @Student_Answer
	  end try
   begin catch
	  select 'ERROR: ID IS NOT EXISTED'
   end catch
GO
-- End Exam_Taken table

-- START with Question_Choices table
---------------------------------------------------------INSERT-----------------------------------------------------------
CREATE PROC Insert_Question_Choices @Choice_ID int, @Question_ID int, @Question_Choice1 nvarchar(120), @Question_Choice2 nvarchar(120), @Question_Choice3 nvarchar(120),@Question_Choice4 nvarchar(120)
AS
BEGIN
  IF NOT EXISTS (SELECT @Choice_ID, @Question_ID FROM Question_Choices WHERE Question_ID = @Question_ID)
    INSERT INTO Question_Choices(Choice_ID, Question_ID, Question_Choice1,Question_Choice2,Question_Choice3,Question_Choice4)
	VALUES (@Choice_ID, @Question_ID, @Question_Choice1, @Question_Choice2 ,@Question_Choice3, @Question_Choice4)
  ELSE 
    PRINT ('Question "' + CAST(@Question_ID AS varchar(20)) + '" already exists')
END

GO
---------------------------------------------------------UPDATE-----------------------------------------------------------
CREATE PROC Update_Question_Choices  @Choice_ID int, @Question_ID int, @Question_Choice1 nvarchar(120), @Question_Choice2 nvarchar(120), @Question_Choice3 nvarchar(120),@Question_Choice4 nvarchar(120)
AS
   begin try
	UPDATE Question_Choices
	SET Choice_ID = @Choice_ID, Question_Choice1 = @Question_Choice1, Question_Choice2 = @Question_Choice2 , Question_Choice3 = @Question_Choice3, Question_Choice4 = @Question_Choice4
	WHERE Question_ID = @Question_ID
	  end try
   begin catch
	  select 'ERROR: VALUE IS NOT EXISTED'
   end catch
GO
---------------------------------------------------------DELETE-----------------------------------------------------------
CREATE PROC Delete_Question_Choices @Choice_ID int, @Question_ID int
AS
   begin try
	DELETE FROM Question_Choices
	WHERE Choice_ID = @Choice_ID and Question_ID = @Question_ID
	  end try
   begin catch
	  select 'ERROR: VALUE IS NOT EXISTED'
   end catch
GO
---------------------------------------------------------SELECT-----------------------------------------------------------
CREATE PROC Select_Question_Choices @Choice_ID int, @Question_ID int
AS
   begin try
	select * FROM Question_Choices
	WHERE Choice_ID = @Choice_ID and Question_ID = @Question_ID
	  end try
   begin catch
	  select 'ERROR: ID IS NOT EXISTED'
   end catch
GO
-- End Question_Choices table