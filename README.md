# Examination System
## Background:
Constructing a fully automated examination system in order to perform online exams by instructors and students, in addition, to be automatically corrected based on stored questions and their model answers, using desktop and web apps.
Starting with designing and building SQL database, in addition to building software solutions, ending with system reports and dashboards that would help the managers in managing the organization.

this project was done as a graduation project for the "information technology institute - ITI - MCIT" intensive training program, where me and my colleagues, ahmed, samar, salma, and hala, contributed in making it. 

## components:
- SQL server database (ER Diagram --> database schems --> database --> needed SQL scripts for the project)
- examination application (using C#)
- managers & instructors application (using C#)
- dashboard (using power BI)
- 6 reports connected to the managers & instructors app. (using SSRS)

the used tools and programming languaged are: C#, SQL server (T-SQL), SSRS, Power BI

## 1 - the database:
first we started designing the ER-Diagram to be like the requirements we needed from that project

![ERD](https://user-images.githubusercontent.com/79236835/163408223-132afd8a-40ed-4326-83f2-67b03909c5cb.jpg)

then transferring that diagram to a database schema to start creating the database on SQL Server

![Mapping](https://user-images.githubusercontent.com/79236835/163408433-5ce9553e-17cc-4eb3-9f4c-5fc2c2ee650c.jpg)

then the tables were created in the database according to the schema,and also some stored procedures to manage the connection between the applications and the database and allow interactions on the app to be stored in the database.

## 2 - the applications:
the first application is for the exams, it's a desktop app.,consists of five windowforms (login, test selection, exam, score, registration), the first one is for login and registration, the second is for choosing the test, the third is for the exam itself, in which it's questions are generated randomly, and the last one is for showing the score of the exam.

![examination app flow](https://user-images.githubusercontent.com/79236835/163722230-e326e5e0-985e-4d41-a541-5fd707285475.png)

the second one is for the instructors and the managers to see reports about the exams and the students in the organization, it consists of (login, managers form, instructors form, 6 forms for the reports), the report forms are connected to SSRS reports using "report viewer" tool.

![instructors app](https://user-images.githubusercontent.com/79236835/163722269-eef16ea9-a68d-4b13-b816-e2fe722058de.png)

the two applications are connected to the database using "sqlconnection" ans "sqlcommand" methods.




