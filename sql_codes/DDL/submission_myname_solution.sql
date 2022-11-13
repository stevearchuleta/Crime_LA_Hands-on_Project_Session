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

DROP DATABASE IF EXISTS crime;
CREATE DATABASE crime;

-- [2] Now, after creating the database, you need to tell MYSQL which database is to be used.
-- Write the Query below to call your Database

USE crime;
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

/* List of tables to be created.

 Create a table temp_t, crime_t, location_t, officer_t, report_t, victim_t */
 
-- Create a table temp_t-

DROP TABLE IF EXISTS temp_t;

CREATE TABLE temp_t
(
	report_no INTEGER,
    incident_time TIME,
    complaint_type VARCHAR(10),
    cctv_flag VARCHAR(5),
    precinct_code INTEGER,
    area_code INTEGER,
    area_name VARCHAR(20),
    cctv_count INTEGER,
    population_density INTEGER,
    rounds_per_day INTEGER,
	crime_code INTEGER,
    crime_type VARCHAR(30),
	weapon_code INTEGER,
    weapon_desc VARCHAR(30),
    case_status_code CHAR(2),
    case_status_desc VARCHAR(30),
    victim_code INTEGER,
    victim_name VARCHAR(20),
	victim_sex CHAR(1),
	victim_age INTEGER,
    was_victim_alone VARCHAR(3),
    is_victim_insured VARCHAR(3),
    offender_code INTEGER,
    offender_name VARCHAR(20),
    offender_sex CHAR(1),
    offender_age INTEGER,
    repeated_offender VARCHAR(3),
    no_of_offences INTEGER,
    offender_relation VARCHAR(3),
    officer_code INTEGER,
    officer_name VARCHAR(30),
    officer_sex CHAR(1),
    avg_close_days INTEGER,
	week_number INTEGER,
	PRIMARY KEY(report_no)
);


-- Create a table crime_t-

DROP TABLE IF EXISTS crime_t;

CREATE TABLE crime_t
(
	report_no INTEGER,
    incident_time TIME,
    complaint_type VARCHAR(10),
    cctv_flag VARCHAR(5),
    precinct_code INTEGER,
    area_code INTEGER,
    area_name VARCHAR(20),
    cctv_count INTEGER,
    population_density INTEGER,
    rounds_per_day INTEGER,
	crime_code INTEGER,
    crime_type VARCHAR(30),
	weapon_code INTEGER,
    weapon_desc VARCHAR(30),
    case_status_code CHAR(2),
    case_status_desc VARCHAR(30),
    victim_code INTEGER,
    victim_name VARCHAR(20),
	victim_sex CHAR(1),
	victim_age INTEGER,
    was_victim_alone VARCHAR(3),
    is_victim_insured VARCHAR(3),
    offender_code INTEGER,
    offender_name VARCHAR(20),
    offender_sex CHAR(1),
    offender_age INTEGER,
    repeated_offender VARCHAR(3),
    no_of_offences INTEGER,
    offender_relation VARCHAR(3),
    officer_code INTEGER,
    officer_name VARCHAR(30),
    officer_sex CHAR(1),
    avg_close_days INTEGER,
	week_number INTEGER,
	PRIMARY KEY(report_no)
);

-- Create a table victim_t-

DROP TABLE IF EXISTS victim_t;

CREATE TABLE victim_t
(
    victim_code INTEGER,
    victim_name VARCHAR(20),
	victim_sex CHAR(1),
	victim_age INTEGER,
    was_victim_alone VARCHAR(3),
    is_victim_insured VARCHAR(3),
	PRIMARY KEY(victim_code)
);

-- Create a table report_t-

DROP TABLE IF EXISTS report_t;

CREATE TABLE report_t
(
	report_no INTEGER,
	incident_time TIME,
    complaint_type VARCHAR(10),
    cctv_flag VARCHAR(5),
    area_code INTEGER,
    victim_code INTEGER,
    offender_code INTEGER,
	offender_name VARCHAR(20),
    offender_sex CHAR(1),
	offender_age INTEGER,
    repeated_offender VARCHAR(3),
    no_of_offences INTEGER,
    offender_relation VARCHAR(3),
	officer_code INTEGER,
	case_status_code CHAR(2),
    case_status_desc VARCHAR(30),
	crime_code INTEGER,
    crime_type VARCHAR(30),
	weapon_code INTEGER,
    weapon_desc VARCHAR(30),
	week_number INTEGER,
	PRIMARY KEY(report_no)
);

-- Create a table officer_t-

DROP TABLE IF EXISTS officer_t;

CREATE TABLE officer_t
(
    officer_code INTEGER,
    officer_name VARCHAR(30),
    officer_sex CHAR(1),
    avg_close_days INTEGER,
	precinct_code INTEGER,
	PRIMARY KEY(officer_code)
);


-- Create a table location_t-

DROP TABLE IF EXISTS location_t;

CREATE TABLE location_t
(
    area_code INTEGER,
    area_name VARCHAR(20),
    cctv_count INTEGER,
    population_density INTEGER,
    rounds_per_day INTEGER,
	PRIMARY KEY(area_code)
);


/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Stored Procedures Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [4] Creating the Stored Procedures:

/*Note:

---> If needed revisit the video: Week 2: Data Modeling and Architecture: Introduction to Stored Procedures.
---> Also revisit the codes used to create stored procedures for the gl_eats database. 
	 This will help in getting a better understanding of the creation of stored procedures.*/

/* List of stored procedures to be created.

   Creating the stored procedure for crime_p, location_p, officer_p, report_p, victim_p */
   

-- Create a Stored Procedure crime_p-

DROP PROCEDURE IF EXISTS crime_p;

DELIMITER $$
CREATE PROCEDURE crime_p()
BEGIN
       INSERT INTO crime_t(
	report_no,
    incident_time,
    complaint_type,
    cctv_flag,
    precinct_code,
    area_code,
    area_name,
    cctv_count,
    population_density,
    rounds_per_day,
	crime_code,
    crime_type,
	weapon_code,
    weapon_desc,
    case_status_code,
    case_status_desc,
    victim_code,
    victim_name,
	victim_sex,
	victim_age,
    was_victim_alone,
    is_victim_insured,
    offender_code,
    offender_name,
    offender_sex,
    offender_age,
    repeated_offender,
    no_of_offences,
    offender_relation,
    officer_code,
    officer_name,
    officer_sex,
    avg_close_days,
	week_number
) SELECT * from temp_t;
END;

-- Create a Stored Procedure victim_p-

DROP PROCEDURE IF EXISTS victim_p;

DELIMITER $$
CREATE PROCEDURE victim_p()
BEGIN
       INSERT INTO victim_t(
			victim_code,
			victim_name,
			victim_sex,
			victim_age,
			was_victim_alone,
			is_victim_insured
) SELECT 
      DISTINCT 
			victim_code,
			victim_name,
			victim_sex,
			victim_age,
			was_victim_alone,
			is_victim_insured
FROM
     crime_t
  WHERE victim_code NOT IN(SELECT DISTINCT victim_code FROM victim_t);
END;

-- Create a Stored Procedure report_p-

DROP PROCEDURE IF EXISTS report_p;

DELIMITER $$
CREATE PROCEDURE report_p(wk_number INTEGER)
BEGIN
	INSERT INTO report_t
(   
    report_no,
	incident_time,
    complaint_type,
    cctv_flag,
    area_code,
    victim_code,
    offender_code,
	offender_name,
    offender_sex,
	offender_age,
    repeated_offender,
    no_of_offences,
    offender_relation,
	officer_code,
	case_status_code,
    case_status_desc,
	crime_code,
    crime_type,
	weapon_code,
    weapon_desc,
	week_number
) SELECT  
    report_no,
	incident_time,
    complaint_type,
    cctv_flag,
    area_code,
    victim_code,
    offender_code,
	offender_name,
    offender_sex,
	offender_age,
    repeated_offender,
    no_of_offences,
    offender_relation,
	officer_code,
	case_status_code,
    case_status_desc,
	crime_code,
    crime_type,
	weapon_code,
    weapon_desc,
	week_number
FROM 
    crime_t
WHERE week_number = wk_number;
END;


-- Create a Stored Procedure officer_p-

DROP PROCEDURE IF EXISTS officer_p;

DELIMITER $$
CREATE PROCEDURE officer_p()
BEGIN
       INSERT INTO officer_t(
		officer_code,
		officer_name,
		officer_sex,
		avg_close_days,
		precinct_code
) SELECT 
      DISTINCT 
		officer_code,
		officer_name,
		officer_sex,
		avg_close_days,
		precinct_code
  FROM
     crime_t
  WHERE officer_code NOT IN(SELECT DISTINCT officer_code FROM officer_t);
END;


-- Create a Stored Procedure location_p-

DROP PROCEDURE IF EXISTS location_p;

DELIMITER $$
CREATE PROCEDURE location_p()
BEGIN
       INSERT INTO location_t(
			area_code,
			area_name,
			cctv_count,
			population_density,
			rounds_per_day
) SELECT 
      DISTINCT 
			area_code,
			area_name,
			cctv_count,
			population_density,
			rounds_per_day
  FROM
     crime_t
  WHERE area_code NOT IN(SELECT DISTINCT area_code FROM location_t);
END;


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

-- List of views to be created are "rep_loc_off_v" , "rep_vict_v"

-- Create a view rep_loc_off_v-

DROP VIEW IF EXISTS rep_loc_off_v;

CREATE VIEW rep_loc_off_v AS
SELECT 
            r.report_no,
			r.incident_time,
			r.complaint_type,
			r.cctv_flag,
			r.crime_code,
            r.case_status_desc,
            r.case_status_code,
			r.crime_type,
            r.week_number,
			l.area_code,
			l.area_name,
			l.cctv_count,
			l.population_density,
            o.officer_code,
            o.precinct_code
FROM report_t as r
INNER JOIN location_t as l
    ON l.area_code = r.area_code
INNER JOIN officer_t as o
    ON r.officer_code = o.officer_code;

-- Create a view rep_vict_v-

DROP VIEW IF EXISTS rep_vict_v;

CREATE VIEW rep_vict_v AS
SELECT 
			r.report_no,
	        r.offender_relation,
            r.incident_time,
            r.crime_type,
            v.victim_code,
			v.victim_age
FROM report_t as r
INNER JOIN victim_t as v
    ON v.victim_code = r.victim_code;

/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Functions Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [7] Creating the functions:

/*Note: 

---> If needed revisit the videos: Week-2: Data Modeling and Architecture: Creating User Defined Functions
---> Also revisit the codes used to create functions for the gl_eats database. 
     This will help in getting a better understanding of the creation of functions.*/

-- Create the function age_f

DROP FUNCTION IF EXISTS age_f;
DELIMITER $$  
CREATE FUNCTION age_f (victim_age varchar(10)) 
RETURNS varchar(10)
DETERMINISTIC  
BEGIN  
  DECLARE age_category varchar(10);
		IF (victim_age >= 0) AND (victim_age <= 12) THEN SET age_category = 'Kids';
		ELSEIF (victim_age > 12) AND (victim_age <= 23) THEN SET age_category = 'Teenage';
		ELSEIF (victim_age > 23) AND (victim_age <= 35) THEN SET age_category = 'Middle age';
		ELSEIF (victim_age > 35) AND (victim_age <= 55) THEN  SET age_category = 'Adults';
		ELSEIF victim_age > 55 THEN SET age_category = 'Old';
        ELSE SET age_category = 'Unknown';
  END IF;
  RETURN age_category;
END;


-- Create the function time_f-

DROP FUNCTION IF EXISTS time_f;
DELIMITER $$  
CREATE FUNCTION time_f (incident_time TIME) 
RETURNS VARCHAR(20)
DETERMINISTIC  
BEGIN  
  DECLARE category VARCHAR(20);
		IF (EXTRACT(HOUR FROM incident_time) >= 0 AND EXTRACT(HOUR FROM incident_time) < 5) THEN SET category = 'Midnight';
		ELSEIF (EXTRACT(HOUR FROM incident_time) >= 5 AND EXTRACT(HOUR FROM incident_time) < 12) THEN SET category = 'Morning';
		ELSEIF (EXTRACT(HOUR FROM incident_time) >=12 AND EXTRACT(HOUR FROM incident_time) < 18) THEN SET category = 'Afternoon';
		ELSEIF (EXTRACT(HOUR FROM incident_time) >= 18 AND EXTRACT(HOUR FROM incident_time) <=21) THEN  SET category = 'Evening';
		ELSEIF EXTRACT(HOUR FROM incident_time) > 21 THEN SET category = 'Night';
  END IF;
  RETURN category;
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

SELECT 
	  week_number,
      crime_type,
      crimes_reported
FROM (SELECT 
        week_number,
        crime_type,
        COUNT(report_no) crimes_reported,
        RANK() OVER(PARTITION BY week_number ORDER BY COUNT(report_no) DESC) high_crime_reported
        FROM rep_loc_off_v
        GROUP BY 
            week_number, 
            crime_type
) wk_crime
WHERE wk_crime.high_crime_reported = 1;

-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q2] Is crime more prevalent in areas with a higher population density, fewer police personnel, and a larger precinct area? 
-- Hint: Add the population density, count the total areas, total officers and cases reported in each precinct code and check the trend*/


SELECT 
        precinct_code,
        SUM(DISTINCT population_density) pop_density,
        COUNT(DISTINCT area_code) total_areas,
        COUNT(DISTINCT officer_code) total_officers,
        COUNT(report_no) cases_reported
FROM rep_loc_off_v
GROUP BY precinct_code
ORDER BY precinct_code;


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
      

SELECT 
	  dayparts,
      crime_type,
      crimes_reported
FROM (SELECT 
        time_f(incident_time) dayparts,
        crime_type,
        COUNT(report_no) crimes_reported,
        RANK() OVER(PARTITION BY  time_f(incident_time) ORDER BY COUNT(report_no) DESC) high_crime_reported
        FROM rep_loc_off_v
        GROUP BY 
            time_f(incident_time), 
            crime_type
) wk_crime
WHERE wk_crime.high_crime_reported = 1;


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


SELECT
		area_name,
		dayparts,
        cases_reported
FROM(
SELECT
	 time_f(incident_time) dayparts,
     RANK() OVER(PARTITION BY area_name ORDER BY COUNT(report_no) DESC) high_crime_reported,
     area_name,
     COUNT(report_no) cases_reported
FROM rep_loc_off_v
GROUP BY dayparts,area_name
ORDER BY cases_reported DESC) d_case
WHERE d_case.high_crime_reported = 1;


-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q5] Which age group of people is more likely to fall victim to crimes at certain points in the day?
-- Hint: Age 0 to 12 kids, 13 to 23 teenage, 24 to 35 Middle age, 36 to 55 Adults, 56 to 120 old.
Use the age_f and time_f functions to find the counts of crimes reported for each age group and in different day parts.*/



SELECT 
	   age_f(victim_age) age_cat,
	   time_f(incident_time) day_parts,
	   COUNT(report_no) as cases_reported
FROM rep_vict_v
GROUP BY age_cat,day_parts
ORDER BY cases_reported DESC;


-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q6] What is the status of reported crimes?.
-- Hint: Count the number of crimes for different case statuses. */


SELECT
		case_status_desc,
        COUNT(report_no) case_count
FROM rep_loc_off_v
GROUP BY case_status_code;


-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q7] Does the existence of CCTV cameras deter crimes from happening?
-- Hint: Check if there is a correlation between the number of CCTVs in each area and the crime rate.*/
      
      
SELECT 
		area_name,
        cctv_count,
        COUNT(report_no) cases_reported
FROM rep_loc_off_v
GROUP BY area_name
ORDER BY cctv_count;
      

-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q8] How much footage has been recovered from the CCTV at the crime scene?
-- Hint: Use the case when function, add separately when cctv_flag is true and false and check whether in particular area how many cctv is there,
How much CCTV footage is available? How much CCTV footage is not available?

Note: For reference, refer to question number 7. Week-2: Hands-on (Practice)-GL_EATS_PRACTICE_EXERCISE_SOLUTION.SQL. 
      You'll get an overview of how to use case when function from this question.*/


SELECT 
	  area_name,
 	  SUM(distinct cctv_count) total_cctv,     
	  SUM(CASE WHEN cctv_flag = 'True' THEN 1 ELSE 0 END)  cctv_footage_available,
	  SUM(CASE WHEN cctv_flag = 'False' THEN 1 ELSE 0 END)  cctv_footage_not_available
FROM rep_loc_off_v
GROUP BY 1;


-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q9] Is crime more likely to be committed by relation of victims than strangers?
-- Hint: Find the distinct crime type along with the count of crime when the offender is related to the victim.*/

SELECT 
		DISTINCT(crime_type),
        COUNT(*) AS cases_reported
FROM rep_vict_v 
WHERE offender_relation = 'Yes'
GROUP BY crime_type;


-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q10] What are the methods used by the public to report a crime? 
-- Hint: Find the complaint type along with the count of crime.*/

SELECT 
      complaint_type,
      count(report_no) cases_reported
FROM rep_loc_off_v
GROUP BY complaint_type;


-- --------------------------------------------------------Done----------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------



