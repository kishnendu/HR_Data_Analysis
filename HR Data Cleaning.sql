CREATE DATABASE projects;

USE projects;

SELECT * FROM hr_data;

ALTER TABLE hr_data
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

DESCRIBE hr_data;

SELECT birthdate FROM hr_data;

SET sql_safe_updates = 0;

UPDATE hr_data
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr_data
MODIFY COLUMN birthdate DATE;

UPDATE hr_data
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr_data
MODIFY COLUMN hire_date DATE;

UPDATE hr_data
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != ' ';

ALTER TABLE hr_data
MODIFY COLUMN termdate DATE;

ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr_data
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT 
	min(age) AS youngest,
    max(age) AS oldest
FROM hr_data;

SELECT count(*) FROM hr_data WHERE age < 18;

SELECT COUNT(*) FROM hr_data WHERE termdate > CURDATE();

SELECT COUNT(*)
FROM hr
WHERE termdate = '0000-00-00';

SELECT location FROM hr;
