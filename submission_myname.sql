/*

-----------------------------------------------------------------------------------------------------------------------------------
                                               Guidelines
-----------------------------------------------------------------------------------------------------------------------------------

The provided document is a guide for the project. Follow the instructions and take the necessary steps to finish
the project in the SQL file			
-----------------------------------------------------------------------------------------------------------------------------------

											Database Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------
*/

-- [1] To begin with the project, you need to create the database first
-- Write the Query below to create a Database


-- [2] Now, after creating the database, you need to tell MYSQL which database is to be used.
-- Write the Query below to call your Database


/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Tables Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [3] Creating the tables:

/*Note:
---> To create the table, refer to the ER diagram and the solution architecture. 
---> Refer to the column names along with the data type while creating a table from the ER diagram.
---> If needed revisit the videos Week 2: Data Modeling and Architecture: Creating DDLs for Your Main Dataset and Normalized Datasets
---> While creating a table, make sure the column you assign as a primary key should uniquely identify each row.
---> If needed revisit the codes used to create tables for the gl_eats database. 
     This will help in getting a better understanding of table creation.*/

-- Syntax to create table-

-- To drop the table if already exists
DROP TABLE IF EXISTS table_name; -- Change the name of table_name to the name you have given.                             


-- To create a table- 
CREATE TABLE table_name (
	column_name1 datatype, 
    column_name2 datatype,
    ..
    ..
    ..
	PRIMARY KEY (column_name as primary key)                    
);                                                             

/* List of tables to be created.

 Create a table temp_t, crime_t, location_t, officer_t, report_t, victim_t */


/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Stored Procedures Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [4] Creating the Stored Procedures:

/*Note:

---> If needed revisit the video: Week 2: Data Modeling and Architecture: Introduction to Stored Procedures.
---> Also revisit the codes used to create stored procedures for the gl_eats database. 
	 This will help in getting a better understanding of the creation of stored procedures.*/

-- Syntax to create stored procedure-

-- To drop the stored procedure if already exists- 
DROP PROCEDURE IF EXISTS procedure_name;

-- Syntax to create a stored procedure-
DELIMITER $$ 
CREATE PROCEDURE procedure_name()
BEGIN
       INSERT INTO table_name (
	column_name1,
    column_name2,
    ..
    ..
    ..              
) SELECT * FROM table_name;
END;


/* List of stored procedures to be created.

   Creating the stored procedure for crime_p, location_p, officer_p, report_p, victim_p */

/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Data Ingestion
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [5] Ingesting the data:
-- Note: Revisit the video: Week-2: Data Modeling and Architecture: Ingesting data into the main table

TRUNCATE temp_t;

LOAD DATA LOCAL INFILE "D:/............/new_wheels_proj/Data/crime...._qtr_1.csv" -- change this location to load another week
INTO TABLE temp_t
FIELDS TERMINATED by ','
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

call crime_p();
call report_p(n);
call officer_p();
call location_p();
call victim_p();

/* Note: 

---> With the help of the above code, you can ingest the data into the temp_t table by ingesting the quarterly data and by calling the stored 
     procedures you can ingest the data into a separate table.
---> You have to run the above ingestion code 4 times as 4 quarters of data are present and you also need to call all the stored procedures 
     4 times. Please change the argument value while calling the stored procedure report_p(n). (n = 1,2,3,4)
---> If needed, revisit the videos: Week 2: Data Modeling and Architecture: Ingesting data into the main table and Ingesting future weeks of data
---> Also revisit the codes used to ingest the data for the gl_eats database. 
     This will help in getting a better understanding of how to ingest the data into various respective tables.*/


/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Views Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [6] Creating the views:

/*Note: 

---> If needed revisit the videos: Week-2: Data Modeling and Architecture: Creating views for answers to business questions
---> Also revisit the codes used to create views for the gl_eats database. 
	 This will help in getting a better understanding of the creation of views.*/

-- Syntax to create view-

-- To drop the views if already exists- 
DROP VIEW IF EXISTS view_name;

-- To create a view-
CREATE VIEW view_name AS
    SELECT
	n1.column_name1,
    n2.column_name2,
    ..
    ..
    ..
FROM table_name1 n1
	INNER JOIN table_name2 n2
	    ON n1.column_name1 = n2.column_name2;

-- List of views to be created are "rep_loc_off_v" , "rep_vict_v"


/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Functions Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [7] Creating the functions:

/*Note: 

---> If needed revisit the videos: Week-2: Data Modeling and Architecture: Creating User Defined Functions
---> Also revisit the codes used to create functions for the gl_eats database. 
     This will help in getting a better understanding of the creation of functions.*/

-- Create the function age_f

-- Syntax to create function-

DELIMITER $$  
CREATE FUNCTION age_f (column_name1 datatype) 
RETURNS DECIMAL
DETERMINISTIC  
BEGIN  

-- statements  

END;


-- Create the function time_f-

DELIMITER $$
CREATE FUNCTION time_f (column_name1 datatype) 
RETURNS INTEGER
DETERMINISTIC
BEGIN  

-- statements

END;

/*-----------------------------------------------------------------------------------------------------------------------------------
Note: 
After creating tables, stored procedures, views and functions, attempt the below questions.
Once you have got the answer to the below questions, download the csv file for each question and use it in Python for visualisations.
------------------------------------------------------------------------------------------------------------------------------------ 

  
  
-----------------------------------------------------------------------------------------------------------------------------------

                                                         Queries
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/
  
/*-- QUESTIONS RELATED TO CUSTOMERS
-- [Q1] Which was the most frequent crime committed each week? 
-- Hint: Use a subquery and the windows function to find out the number of crimes reported each week and assign a rank. 
Then find the highest crime committed each week

Note: For reference, refer to question number 3 - mls_week-1_gl-beats_solution.sql. 
      You'll get an overview of how to use subquery and windows function from this question */



-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q2] Is crime more prevalent in areas with a higher population density, fewer police personnel, and a larger precinct area? 
-- Hint: Add the population density, count the total areas, total officers and cases reported in each precinct code and check the trend*/





-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q3] At what points of the day is the crime rate at its peak? Group this by the type of crime.
-- Hint: 
time day parts
[1] 00:00 to 05:00 = Midnight, 
[2] 05:01 to 12:00 = Morning, 
[3] 12:01 to 18:00 = Afternoon,
[4] 18:01 to 21:00 = Evening, 
[5] 21:00 to 24:00 = Night

Use a subquery, windows function, and the time_f function to find the number of crimes reported each week and assign the rank.
Then find out at what points of the day the crime rate is at its peak.
 
 Note: For reference, refer to question number 3 - mls_week-1_gl-beats_solution.sql. 
      You'll get an overview of how to use subquery, windows function from this question */
      




-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q4] At what point in the day do more crimes occur in a different locality?
-- Hint: 
time day parts
[1] 00:00 to 05:00 = Midnight, 
[2] 05:01 to 12:00 = Morning, 
[3] 12:01 to 18:00 = Afternoon,
[4] 18:01 to 21:00 = Evening, 
[5] 21:00 to 24:00 = Night

Use a subquery, the windows function, and the time_f function to find the number of crimes reported in each area and assign the rank.
Then find out at what point in the day more crimes occur in a different locality.
 
 Note: For reference, refer to question number 3 - mls_week-1_gl-beats_solution.sql. 
      You'll get an overview of how to use subquery, windows function from this question */





-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q5] Which age group of people is more likely to fall victim to crimes at certain points in the day?
-- Hint: Age 0 to 12 kids, 13 to 23 teenage, 24 to 35 Middle age, 36 to 55 Adults, 56 to 120 old.
Use the age_f and time_f functions to find the counts of crimes reported for each age group and in different day parts.*/






-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q6] What is the status of reported crimes?.
-- Hint: Count the number of crimes for different case statuses. */






-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q7] Does the existence of CCTV cameras deter crimes from happening?
-- Hint: Check if there is a correlation between the number of CCTVs in each area and the crime rate.*/
      
      
      
      
      

-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q8] How much footage has been recovered from the CCTV at the crime scene?
-- Hint: Use the case when function, add separately when cctv_flag is true and false and check whether in particular area how many cctv is there,
How much CCTV footage is available? How much CCTV footage is not available?

Note: For reference, refer to question number 7. Week-2: Hands-on (Practice)-GL_EATS_PRACTICE_EXERCISE_SOLUTION.SQL. 
      You'll get an overview of how to use case when function from this question.*/







-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q9] Is crime more likely to be committed by relation of victims than strangers?
-- Hint: Find the distinct crime type along with the count of crime when the offender is related to the victim.*/




-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q10] What are the methods used by the public to report a crime? 
-- Hint: Find the complaint type along with the count of crime.*/





-- --------------------------------------------------------Done----------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------



