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
use crime;

/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Tables Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [3] Creating the tables:
--     Make sure the column you assign as a primary key should uniquely identify each row.

/* List of tables to be created.
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
	victim_sex CHAR(1),
	victim_age INTEGER,
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

DROP TABLE IF EXISTS officer_t;

CREATE TABLE officer_t
(
    officer_code INTEGER,
    officer_name VARCHAR(30),
    officer_sex CHAR(1),
    avg_close_days INTEGER,
	precinct_code INTEGER,
	PRIMARY KEY(officer_code)
);add

