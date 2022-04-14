use Examination_System
-------------------------------------------------------------------------
--- examination app procedure (momen):
-------------------------------------------------------------------------------
-- 1st form page:
-- 1st procedure (compares the entered data to the data in student table):
create proc login_user @email varchar(50), @password varchar(50)
as
select count(*) from Student where login = @email and password = @password
-------------------------------------------------------------------------------
-- login table for saving logins:
create table login (id int identity primary key, login_user varchar(50), password varchar(50))
-------------------------------------------------------------------------------
-- 2nd form page:
-- 1st procedure (shows the name of the person who made login):
create proc label_1 @z varchar(50) output
as
begin
select fname+' '+Mname+' '+Lname  from Student, login where Student.Login in
(select top 1 login.login_user from login order by id desc)
end
-- 2nd procedure (executes the first procedure):
create procedure label_1_1
as
declare @z varchar(50) 
execute label_1 @z out
print @z
-- 3rd procedure (takes the course selected and generates the exam ):
-- (first we created a table to save the chosen course)
create table courses_selected (id int primary key identity,course_selected nvarchar(50))
-- then we executed the procedure which inserts the values from the chosen courses
create proc insert_selected_course @course_name nvarchar(50)
as
INSERT INTO courses_selected values (@course_name)
-- then in form 3 we generated the exam questions
--------------------------------------------------------------------------------
-- 3rd form page (exam pages):
-- 1st procedure (exam name):
create proc exam_name @z varchar(50) output
as
select top 1 course_selected from courses_selected order by id desc
go 
create procedure exam_name_out
as
declare @z varchar(50) 
execute exam_name @z out
print @z
-- 2st procedure (generates exam questions randomly):
create proc quest_sql @z varchar(50) output
as
begin
select Question_Formulation from Question where Course_ID in
(select Course_ID from Course where Course_Name in 
(select top 1 course_selected from courses_selected order by id desc)) order by NEWID()
end 
-- 3nd procedure (executes the "quest_sql" procedure): 
create procedure quest_sql_out
as
declare @z varchar(50) 
execute quest_sql @z out
print @z
-- 4rd procedure (executes the four choices of the random question):
create proc question_choices_proc @label varchar(200), @1st_choice nvarchar(120) output,
@2nd_choice nvarchar(120) output,
@3rd_choice nvarchar(120) output,
@4th_choice nvarchar(120) output
as
select @1st_choice = Question_Choice1 from Question_Choices where Question_ID in 
(select Question_ID from Question where Question_Formulation = @label)
select @2nd_choice = Question_Choice2 from Question_Choices where Question_ID in 
(select Question_ID from Question where Question_Formulation = @label)
select @3rd_choice = Question_Choice3 from Question_Choices where Question_ID in 
(select Question_ID from Question where Question_Formulation = @label)
select @4th_choice = Question_Choice4 from Question_Choices where Question_ID in 
(select Question_ID from Question where Question_Formulation = @label)
-- 5th procedure (saves the generated questions):
create proc saving_ques @question varchar(200), @answer nvarchar(120) --@exam_no int
as 
declare @email varchar(50)
declare @model_ans nvarchar(120)
select @model_ans = model_answer from Question where question_Formulation = @question 
select top 1 @email = login_user from login order by id desc
insert into Exam_Taken (Student_ID,exam_id,Question_ID,Student_Answer) values
((select student_id from Student where Login = @email),
(Select top 1 exam_id from exam order by id desc),
(select question_id from Question where Question_Formulation = @question),(@answer))
update Exam_Taken set result = 1 where Student_Answer in (select Student_Answer from Exam_Taken where Question_ID in 
(select Question_ID from Question where Question.Model_Answer = Exam_Taken.Student_Answer)) and question_id in
(select Question_ID from Question where Question.Model_Answer = Exam_Taken.Student_Answer)
-- 6th procedure (saves the exam_id in exam table and fills that table):
create proc saving_exam_id @exam_id int
as
declare @email varchar(50)
select top 1 @email = login_user from login order by id desc
declare @exam_tit nvarchar(50)
select top 1 @exam_tit = course_selected from courses_selected order by id desc
insert into exam (exam_id,exam_title,student_id,course_id,total_result) values ((@exam_id),(@exam_tit),
(select student_id from Student where Login = @email),(select course_id from course where course_name = @exam_tit)
,(select sum(Result) from exam_taken where exam_id = (select top 1 Exam_ID from exam order by id desc)))
------------------------------------------------------------------------------------
-- 4th form page (score pages):
-- 1st procedure (score showing): 
create proc score @z int output
as
select sum(Result)*10 from exam_taken group by Exam_ID having exam_id = (select top 1 Exam_ID from exam order by id desc)
go 
create procedure score_out
as
declare @z int
execute score @z out
print @z
-- 2nd procedure (saves score):
create proc saving_score @score int
as
update exam set Total_Result = @score where Exam_ID = (select top 1 Exam_ID from exam order by id desc)
--------------------------------------------------------------------------------
-- constraint that makes the value default = 0 in result column - exam_taken table
alter table exam_taken ADD CONSTRAINT c1
DEFAULT 0 FOR result
--------------------------------------------------------------------------------
-- 5th form page (registration pages):
create proc saving_regis_data 
@fname varchar(20),
@mname varchar(20),
@lname varchar(20),
@gender varchar(20),
@city nvarchar(50),
@login varchar(50),
@password varchar(50)
as
insert into student(Fname,Mname,Lname,Gender,City,Login,Password)
values ((@fname),(@mname),(@lname),(@gender),(@city),(@login),(@password))
-----------------------------------------------------------------------------------
---- instructors app procedures (samar):
----------------------------------------
-- 1st form (login):
-- 1st procedure (for instructors login)
create proc login_ins @ins_name nvarchar(50), @ins_id int
as
select count(*) from Instructor where @ins_name = Instructor_Fullname and @ins_id = Instructor_ID
-- 2nd procedure (for managers login)
create proc mgr_login @mgr_name nvarchar(50), @ins_id int
as
select count(*) from Department where @mgr_name = DB_Manager and @ins_id = Instructor_ID
---------------------------------------------------------------------------------
--Reports procedures (hala):
--------------------------------------
--	Report that returns the students information according to Department No parameter.
CREATE PROC GetStudentInfo1 @Department_ID INT
AS
	SELECT s.*
	FROM Student s inner join Department d
	on s.Department_ID = d.Department_ID  and d.Department_ID=@Department_ID
	
GetStudentInfo1 1
Go

--	Report that takes the student ID and returns the grades of the student in all courses.
CREATE PROC GetStudent_Grades @Student_ID INT
AS
	SELECT CONCAT(S.Fname, ' ', S.Mname, ' ',S.Lname) AS Fullname ,Exam_Title, ET.total_result AS Grades
	FROM Student S INNER JOIN exam ET
	ON S.Student_ID = ET.Student_ID AND ET.Student_ID = @Student_ID and Total_Result is not null
	
GetStudent_Grades 1

GO
select * from Exam_Taken

--	Report that takes the instructor ID and returns the name of the courses that he teaches and the number of student per course.
CREATE PROC GetInstructorCoursesInfo @Instructor_ID INT
AS
	SELECT C.Course_Name, COUNT(SC.Student_ID) AS NoOfStudents
	FROM Instructor_Course IC INNER JOIN Course C
	ON C.Course_ID = IC.Course_ID AND IC.Instructor_ID = @Instructor_ID
	INNER JOIN Student_Course SC
	ON C.Course_ID = SC.Course_ID
	GROUP BY C.Course_Name

GetInstructorCoursesInfo 1
GO


--	Report that takes course ID and returns its topics  
CREATE PROC GetCourseTopics @CourseID INT
AS
	SELECT T.Topic_Name
	FROM Course C INNER JOIN Topic T
	ON C.Course_ID = T.Course_ID AND C.Course_ID = @CourseID

GetCourseTopics 1
GO

--	Report that takes exam number and returns the Questions in it:
CREATE PROC GetExamQuestions @Exam_ID INT
as
select Question_Formulation ,  Question_Choice1, Question_Choice2, Question_Choice3, Question_Choice4 from Question, Question_Choices
where Question_Choices.Question_ID = Question.Question_ID and Question.Question_ID in
(select Question_ID from Exam_Taken where Exam_ID in (select  Exam_ID from Exam where Exam_ID = @Exam_ID))

GetExamQuestions

GO

--	Report that takes exam number and the student ID then returns the Questions in this exam with the student answers. 
CREATE PROC GetStudentExamAnswer @Exam_ID INT, @Student_ID INT
AS
	SELECT Q.Question_Formulation, ch.Question_Choice1, ch.Question_Choice2, ch.Question_Choice3, ch.Question_Choice4,
    ET.Student_Answer
	FROM Exam_Taken ET INNER JOIN Question Q
	ON Q.Question_ID = Et.Question_ID AND ET.Exam_ID = @Exam_ID AND ET.Student_ID = @Student_ID
	LEFT JOIN Question_Choices CH
	ON Q.Question_ID = CH.Question_ID 

GetStudentExamAnswer

GO
------------------------------------------------------------------------------------



