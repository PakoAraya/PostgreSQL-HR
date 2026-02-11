/**********************************************************************************************
* Project         : HR Schema (Based on Oracle HR Sample Schema)
* Script Name     : hr_queries.sql
* Description     : SQL Training Lab: Joins, Subqueries, Aggregations and Analytics.
*   
* Database        : PostgreSQL 16.1.0
* Schema Name     : hr
* 
* Author          : PaKo Araya
* E-mail          : franarayah@gmail.com
* Created Date    : 2026-02-11
* Last Modified   : 2026-02-11
* 
* Script Version  : 1.0.0
* Risk Level      : Low (Read-Only /DQL)

* Purpose         :
* - Practice advanced SQL querying techniques.
* - Analyze emplouyee, departments, and locations data.
* - Develop reporting skills using PostgreSQL Extensions.

* Exercises Included:
* - [√] Basic SELECT & Filtering
* - [√] Multi-table JOINs (Inner, Left, Right)
* - [√] Aggregate Functions (Group By, Having)
* - [ ] Subqueries & CTEs (Common Table Expressions)
* - [ ] Window Functions (RANK, ROW_NUMBER)
*
* Notes:
* - These queries are designed for the 'hr' database.
* - Does not modify data (Read-Only).
**********************************************************************************************/


-- Set Environment
SET search_path TO hr;

-- =====================================================================
-- LAB 01: BASIC QUERIES EXERCISES
-- Goal: Learn best practices for declaring queries in databases
-- =====================================================================

/* 001
 * Develop a query that list the employee's name, department code and the  
 * hire date, sorting the results by departments and hire date with the most
 * recent hire appearing first.
*/
SELECT e.first_name, e.department_id, e.hire_date 
FROM hr.employees e
ORDER BY e.department_id, e.hire_date DESC;

-- =====================================================================

/* 002
 *  Develop a query that list employee´s code, first and last names of the
 * employees, and their respective managers, along with the titles of the
 * employee and manager boss, with job title manager
*/


-- =====================================================================


/* 003
 *  Developer a query that list all countries by region. The data to be 
 * displayed is the region's name, with the names of its countries.
*/


-- =====================================================================


/* 004
 *  Run a query that displays employee's id, first and last names, start
 * and end date of the employee´s job history
*/


-- =====================================================================


/* 005
 *  Create a query that displays the employee's first and last name,
 * with the title "Employee", their salary, commission percentage,
 * commission and total salary
*/


-- =====================================================================


/* 006
 * Create a query that list the job title and salary of employees who
 * are managers, whose code is 100 or 125, and whose salary is grater 
 * than 6000 
*/


-- =====================================================================


/* 007
 * Develop a query that list the locality code, city, and department
 * name only for those located outside the United States (US) 
*/


-- =====================================================================


/* 008
 * Perform a query that displays the region code, region name and the 
 * names of the countries names located in "Asia". 
*/


-- =====================================================================


/* 009
 * Create a query that list the region code, the region name, locality
 * code city and country name for only those localities larger than 
 * 2400 
*/


-- =====================================================================


/* 010
 * Develop a query that displays the region code with a region alias,
 * the region name with a "region name" label, and a string (concatenation)
 * that says the following phrase: "Country Code: CA Name: Canada," where
 * CA is the country code and Canada is the country name with the country
 * label. The location code with the location label, the street address
 * with the address label, and the postal code with the "Postal Code" label.
 * In turn, postal codes that are null should not appear. 
*/


-- =====================================================================


/* 011
 * Develop a query that displays the average salary of employees in 
 * departments 30 and 80. 
*/


-- =====================================================================


/* 012
 * Develop a query that displays the name of the region, the name of the
 * country, the state of the province, the code of the employee who are
 * managers, and the first and last names of employees who are managers
 * in the United Kingdom (UK) and the United States (US), respectively,
 * in the states of Washington and Oxford. 
*/


-- =====================================================================


/* 013
 * Perform a query that displays the first and last names of employees
 * who work for departments located in countries whose names begin with
 * the letter C, showing the name of the country. 
*/


-- =====================================================================


/* 014
 * Develop a query that list the job title, the first and last name of
 * the employee who holds that position, whose email is 'NKOCHHAR', on
 * September 21, 1989. 
*/


-- =====================================================================


/* 015
 * Write a single query that list employees in departments 10, 20 and 80
 * who were hired more than 180 days ago, earn a commission of at least
 * 20% and whose first or last name begins with the leter 'J'. 
*/


-- =====================================================================


/* 016
 * Perform a query that displays the first name, last name and department
 * name of employees whose phone number has the area code 515 
 * (12-digit number: 3 area code digits, 7 number digits, and a colon),
 * excluding phone numbers that are not 12 characters long. 
*/


-- =====================================================================


/* 017
 * Develop a query that displays the code, first and last name separated
 * by a comma with the header title "full name", the salary with the 
 * title "salary", the department code with the title "department code"
 * and the name of the department to which they belong with the title
 * "description". Only queries belonging to the IT department are desired,
 * and the information should be sorted by descending salary. 
*/


-- =====================================================================


/* 018
 * Perform a query that list the first and last name, salary of the 
 * employee, the name of the department to which they belong, the address,
 * the zip code, and the city where the department is located. Only those
 * from departments 100, 80 and 50, respectively, should be displayed.
 * They must also belong only to the city of South San Francisco, and the
 * salary range must be between 4000 and 8000, including the limit values. 
*/


-- =====================================================================


/* 019
 * Develop a query where you select the employee code, whose alias will
 * be code, the last name concatenated with the employee's first name but 
 * separated by a comma (,) whose alias will be Names, the email where 
 * the initial is capitalized and all have the domain @eisi.ues.edu.sv, 
 * that is, it must be concatenated with that domain, whose alias is 
 * email. In addition, if the phone number is stored in the field in this
 * way, 515.123.4567, it myst be converted to the following format
 * (515)-123-4567. If you hava a phone number with this length, 
 * 011.44.1344.429268, i.e., longer than the previous format, it should
 * appear in the following format (011-44-1344-429268).
 * Queries you can make using functions for this exercises, such as LENGTH
 * and SUBSTR. This information should be sorted by employee code. 
*/


-- =====================================================================


/* 020
 * Develop a query that allows you to select cities, their country code,
 * and if it is from the United Kingdom (UK), change it to (UNKing);
 * otherwise, if it is not from the United Kingdom (Non-UNKing), cities
 * must start with the letter S. 
*/


-- =====================================================================


/* 021
 * Develop a query that displays the department code with the title
 * "Department Code", counting the employees grouped by department, 
 * sorted by department code. 
*/


-- =====================================================================


/* 022
 * Run a query that shows only the names of employees that are repeated. 
*/


-- =====================================================================


/* 023
 * Develop a query that displays only the names of employees that are not
 * repeated. 
*/


-- =====================================================================


/* 024
 * Perform a query that shows the number of countries per region. The
 * query should show the code and name of the region, as well as the 
 * number of the countries in each region, sorting the results by the
 * region with the highest number of countries. 
*/


-- =====================================================================


/* 025
 * Develop a query that lists the job codes with the number of employees
 * belonging to each job, sorted by the number of employees. The jobs
 * with the most employees appear first. 
*/


-- =====================================================================


/* 026
 * Develop a query that displays the number of employees per department, 
 * sorted alphabetically by department name. 
*/


-- =====================================================================


/* 027
 * Perform a query that shows the number of departments per region. 
*/


-- =====================================================================


/* 028
 * Run a query that shows the salary paid by each departments (excluding
 * commissions), sorted in descending order by salary paid. The code and
 * name of the department and the salary paid will be displayed. 
*/


-- =====================================================================


/* 029
 * Develop a query that displays the year of hire, the lowest, highest 
 * and average salary for all employees by year of hire. Sort the results
 * by year of hire (most recent first). 
*/


-- =====================================================================


/* 030
 * Develop a query that displays the department code with the title
 * "Department Code", the job code with the title "Job Position" and
 * counts the employees in departments 50 and 80, sorting the results
 * by department and job position. 
*/


-- =====================================================================


/* 031
 *  
*/


-- =====================================================================


/* 032
 *  
*/


-- =====================================================================


/* 033
 *  
*/


-- =====================================================================


/* 034
 *  
*/


-- =====================================================================


/* 035
 *  
*/


-- =====================================================================


/* 036
 *  
*/


-- =====================================================================


/* 037
 *  
*/


-- =====================================================================


/* 038
 *  
*/


-- =====================================================================


/* 039
 *  
*/


-- =====================================================================


/* 040
 *  
*/


-- =====================================================================


/* 041
 *  
*/


-- =====================================================================


/* 042
 *  
*/


-- =====================================================================


/* 043
 *  
*/


-- =====================================================================


/* 044
 *  
*/


-- =====================================================================





























