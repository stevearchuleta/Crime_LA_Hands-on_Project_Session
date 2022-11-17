/*

-----------------------------------------------------------------------------------------------------------------------------------
                                               Guidelines
-----------------------------------------------------------------------------------------------------------------------------------

The provided document is a guide for the project. 
Follow the instructions and take the necessary steps to finish
the project in the SQL file.
-- FUNCTIONALITY:
-- OBSERVATIONS:
-- INSIGHTS:
-----------------------------------------------------------------------------------------------------------------------------------

											Database Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------
*/

-- [1] To begin the project, first create the database.
--     Write the Query below to create a crime Database.
--     FUNCTIONALITY: Drop Database if it already exisits (or if I need to correct any of my errors and then re-run the CREATE code).
--     OBSERVATIONS: Without a current crimes database, the DROP command will throw an Action Output warning because no database yet exists.
--     INSIGHTS: Two Databases with the same name cannot be created (MySQL Schema namespaces are reserved for unique database names)
--               Ingestion Layer of Data Modelling and Architecture
DROP DATABASE IF EXISTS crime;
CREATE DATABASE crime;


-- [2] After creating the database, tell MYSQL which database is to be used.
--     Write the Query below to call the crime Database.
-- FUNCTIONALITY: USE <database namespace> will use the named database as the active/current schema. 
-- OBSERVATIONS: Within the mySQL Navigator field, the database name in use will be bold typed.
-- INSIGHTS:  By double clicking on a database name, that particular database will then become the active/current/bold-typed schema.
--               Ingestion Layer of Data Modelling and Architecture
use crime;

/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Tables Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [3] Creating the tables:
--     Make sure the column(s) assigned as a primary key are uniquely identifing each row.
-- FUNCTIONALITY: 	DROP TABLE if it already exisits (or if I need to correct any of my errors and then re-run the CREATE code).
-- 					CREATE temp_t table.
-- OBSERVATIONS:    Herein, the datatypes of each column name must be delcared
-- INSIGHTS:		In essence, this is the same code that will be used to CREATE the crimes TABLE.
 -- 			    Herein, I've organized columns by the smaller, normalized tables that I'll be creating later in the project.
 --                 Ingestion Layer of Data Modelling and Architecture

/* List of tables to be created:
   temp_t, crime_t, location_t, officer_t, report_t, victim_t */
 
-- Create a table temp_t-
DROP TABLE IF EXISTS temp_t;
CREATE TABLE temp_t
(
    -- LOCATION_t 
    area_code INTEGER,
    area_name VARCHAR(20),
    cctv_count INTEGER,
    population_density INTEGER,
    rounds_per_day INTEGER,
    
    -- VICTIM_t
    victim_code INTEGER,
    victim_name VARCHAR(20),
    victim_age INTEGER,
    victim_sex CHAR(1),
    was_victim_alone VARCHAR(3),
     is_victim_insured VARCHAR(3),
    
	-- REPORT_t
    report_no INTEGER,
    incident_time TIME,
    complaint_type VARCHAR(10),
    cctv_flag VARCHAR(5),
    -- area_code (FK),
    -- victim_code (FK),
    -- officer_code (FK)
    offender_code INTEGER,
    offender_name VARCHAR(20),
    offender_age INTEGER,
    offender_sex CHAR(1),
    repeated_offender VARCHAR(3),
    no_of_offences INTEGER,
    offender_relation VARCHAR(3),
    crime_code INTEGER,
    crime_type VARCHAR(30),
	weapon_code INTEGER,
    weapon_desc VARCHAR(30),
    case_status_code CHAR(2),
    case_status_desc VARCHAR(30),
    week_number INTEGER,
         
    -- OFFICER_t
    officer_code INTEGER,
    officer_name VARCHAR(30),
    officer_sex VARCHAR(1),
    precinct_code INTEGER,
    avg_close_days INTEGER,
    
	PRIMARY KEY(area_code, victim_code, report_no, officer_code)
);


-- Create a table crime_t-
DROP TABLE IF EXISTS crime_t;
CREATE TABLE crime_t
(
    -- LOCATION_t 
    area_code INTEGER,
    area_name VARCHAR(20),
    cctv_count INTEGER,
    population_density INTEGER,
    rounds_per_day INTEGER,
    
    -- VICTIM_t
    victim_code INTEGER,
    victim_name VARCHAR(20),
    victim_age INTEGER,
    victim_sex CHAR(1),
    was_victim_alone VARCHAR(3),
     is_victim_insured VARCHAR(3),
    
	-- REPORT_t
    report_no INTEGER,
    incident_time TIME,
    complaint_type VARCHAR(10),
    cctv_flag VARCHAR(5),
    -- area_code (FK),
    -- victim_code (FK),
    -- officer_code (FK)
    offender_code INTEGER,
    offender_name VARCHAR(20),
    offender_age INTEGER,
    offender_sex CHAR(1),
    repeated_offender VARCHAR(3),
    no_of_offences INTEGER,
    offender_relation VARCHAR(3),
    crime_code INTEGER,
    crime_type VARCHAR(30),
	weapon_code INTEGER,
    weapon_desc VARCHAR(30),
    case_status_code CHAR(2),
    case_status_desc VARCHAR(30),
    week_number INTEGER,
         
    -- OFFICER_t
    officer_code INTEGER,
    officer_name VARCHAR(30),
    officer_sex VARCHAR(1),
    precinct_code INTEGER,
    avg_close_days INTEGER,
    
	PRIMARY KEY(area_code, victim_code, report_no, officer_code)
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

DROP TABLE IF EXISTS victim_t;

CREATE TABLE victim_t
(
    victim_code INTEGER,
    victim_name VARCHAR(20),
	victim_age INTEGER,
	victim_sex CHAR(1),
    was_victim_alone VARCHAR(3),
    is_victim_insured VARCHAR(3),
	PRIMARY KEY(victim_code)
);

DROP TABLE IF EXISTS report_t;

CREATE TABLE report_t
(
	report_no INTEGER,
	incident_time TIME,
    complaint_type VARCHAR(10),
    cctv_flag VARCHAR(5),
    area_code INTEGER,
    victim_code INTEGER,
    officer_code INTEGER,
    offender_code INTEGER,
	offender_name VARCHAR(20),
    offender_age INTEGER,
    offender_sex CHAR(1),
	repeated_offender VARCHAR(3),
    no_of_offences INTEGER,
    offender_relation VARCHAR(3),
	crime_code INTEGER,
    crime_type VARCHAR(30),
	weapon_code INTEGER,
    weapon_desc VARCHAR(30),
	case_status_code CHAR(2),
    case_status_desc VARCHAR(30),
	week_number INTEGER,
	PRIMARY KEY(report_no)
);

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

/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Stored Procedures Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [4] Creating the Stored Procedures:
-- FUNCTIONALITY: CREATE PROCEDURE crime_p() will insert the columns and, when called, the column data from the temp_t table into the main crime_t ingestion table.
--                For the Nomralized tables, each respective procedure will populated each respective table with the specified columns and, when called, the column data from the crime_t table.
-- OBSERVATIONS:  Herein, there is no need to re-define column datatypes.
--               For calls on location_p(), vicitm_p(), report_p(), and officer_p(), their respective tables only get populated when new data is dumped into it.
--               Hence, no duplicate data loading; the distinct area codes of locations where primary key was already populated into crime_t table are not duplicated.  
-- INSIGHTS:	 The crime_p() procedure must be called, in order to populate the main crime_t(); refresh the Navigator Schema then verify the rows.
--               Transactional Layer of Data Modelling and Architecture

/* List of stored procedures to be created.
   crime_p, location_p, officer_p, report_p, victim_p */

-- Create a Stored Procedure crime_p-

DROP PROCEDURE IF EXISTS crime_p;

DELIMITER $$
CREATE PROCEDURE crime_p()
BEGIN
	INSERT INTO crime_t(
    area_code,
    area_name,
    cctv_count,
    population_density,
    rounds_per_day,
     victim_code,
     victim_name,
     victim_age,
     victim_sex,
     was_victim_alone,
     is_victim_insured,
     report_no,
     incident_time,
     complaint_type,
     cctv_flag,
     offender_code,
     offender_name,
     offender_age,
     offender_sex,
     repeated_offender,
     no_of_offences,
     offender_relation,
     crime_code,
     crime_type,
     weapon_code,
     weapon_desc,
     case_status_code,
     case_status_desc,
     week_number,
     officer_code,
     officer_name,
     officer_sex,
     precinct_code,
     avg_close_days
     ) 
SELECT
	DISTINCT
		 area_code,
		area_name,
		cctv_count,
		population_density,
		rounds_per_day,
		 victim_code,
		 victim_name,
		 victim_age,
		 victim_sex,
		 was_victim_alone,
		 is_victim_insured,
		 report_no,
		 incident_time,
		 complaint_type,
		 cctv_flag,
		 offender_code,
		 offender_name,
		 offender_age,
		 offender_sex,
		 repeated_offender,
		 no_of_offences,
		 offender_relation,
		 crime_code,
		 crime_type,
		 weapon_code,
		 weapon_desc,
		 case_status_code,
		 case_status_desc,
		 week_number,
		 officer_code,
		 officer_name,
		 officer_sex,
		 precinct_code,
		 avg_close_days
FROM temp_t;
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


-- Create a Stored Procedure victim_p-

DROP PROCEDURE IF EXISTS victim_p;

DELIMITER $$
CREATE PROCEDURE victim_p()
BEGIN
       INSERT INTO victim_t(
			victim_code,
			victim_name,
			victim_age,
			victim_sex,
			was_victim_alone,
			is_victim_insured
) SELECT 
      DISTINCT 
			victim_code,
			victim_name,
			victim_age,
            victim_sex,
			was_victim_alone,
			is_victim_insured
FROM
     crime_t
  WHERE victim_code NOT IN(SELECT DISTINCT victim_code FROM victim_t);
END;


-- Create a Stored Procedure report_p

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
    officer_code,
    offender_code,
	offender_name,
    offender_age,
	offender_sex,
    repeated_offender,
    no_of_offences,
    offender_relation,
    crime_code,
    crime_type,
    weapon_code,
    weapon_desc,
	case_status_code,
    case_status_desc,
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


/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Data Ingestion
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [5] Ingesting the data:
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- WEEKLY DATA DUMP (weekly_temp_dump.sql) IS STORED IN THE PROCEDURES DIRECTORY 
-- This weekly_temp_dump file will load subsequent week's-worth of data (and since previous data is already in the temp_t file, it should not be reloaded).

-- FUNCTIONALITY: 	Truncate is like a "refresh"; Truncate empties the temporary table, which will drop the previous week's data dump. 
-- 					Then the subsequest week's data can be appended. 
--                  Call the stored procedures to ingest the data into a separate tables; Change the argument in report_p(n) to (n = 1,2,3,4) as needed for weekly dumps.
-- OBSERVATIONS:	LOCAL INFILE takes in the PATH of the flat file (.csv); 
-- 					Becasue all of the dump files are within the same folder, all that needs to be changed for future dumps is: w1,w2,w3,w4 (for that week's data dump).
-- 					Run the ingestion code four (4) times because four (4) weeks of data are present as four (4) .csv files; call all the stored procedures four (4) times.
-- INSIGHTS:        .csv files are separated by commas; data may be in the form of strings ""; and new rows begin on a new line '\n'; the header LINE 1 is ignored
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

TRUNCATE temp_t;

LOAD DATA LOCAL INFILE 'C:/Users/steve/Documents/SQL_and_Databases/Crime_LA_Hands-On_Project_Session/Data/crime_la_w1.csv' 
INTO TABLE temp_t
FIELDS TERMINATED by ','
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

call crime_p();
call report_p(1);
call officer_p();
call location_p();
call victim_p();

/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Views Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [6] Creating the views:

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


-- Create the function age_f

DROP FUNCTION IF EXISTS age_f;

DELIMITER $$  
CREATE FUNCTION age_f (victim_age varchar(10)) 
RETURNS varchar(10)
DETERMINISTIC  
BEGIN  
  DECLARE age_category varchar(10);
		IF (victim_age >= 0) AND (victim_age <= 12) THEN SET age_category = 'Child';
		ELSEIF (victim_age > 12) AND (victim_age <= 23) THEN SET age_category = 'Teenager';
		ELSEIF (victim_age > 23) AND (victim_age <= 35) THEN SET age_category = 'Middle-aged';
		ELSEIF (victim_age > 35) AND (victim_age <= 55) THEN  SET age_category = 'Adults';
		ELSEIF victim_age > 55 THEN SET age_category = 'Elderly';
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
