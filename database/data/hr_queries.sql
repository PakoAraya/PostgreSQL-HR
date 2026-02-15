/**********************************************************************************************
* Project         : HR Schema (Based on Oracle HR Sample Schema)
* Script Name     : hr_queries.sql
* Description     : SQL Training Lab: Joins, Subqueries, Aggregations and Analytics.
* * Database        : PostgreSQL 16.1.0
* Schema Name     : hr
* * Author          : PaKo Araya
* E-mail          : franarayah@gmail.com
* Created Date    : 2026-02-11
* Last Modified   : 2026-02-11
* * Script Version  : 1.0.1
* Risk Level      : Low (Read-Only / DQL)

* Purpose         :
* - Practice advanced SQL querying techniques.
* - Analyze employee, departments, and locations data.
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
 * Develop a query that lists the employee's name, department code and the  
 * hire date, sorting the results by departments and hire date with the most
 * recent hire appearing first.
*/
SELECT e.first_name, e.department_id, e.hire_date 
FROM hr.employees e
ORDER BY e.department_id, e.hire_date DESC ;

-- Another Way
SELECT 
  CONCAT(e.first_name, ' ', e.last_name) AS "Employee Name",
  e.department_id,
  e.hire_date 
FROM hr.employees e
ORDER BY e.department_id, e.hire_date DESC;

-- =====================================================================


/* 002
 * Develop a query that lists the employee code, first and last names,
 * and their respective managers, along with the job titles of both
 * the employee and their manager.
*/
SELECT 
  CONCAT(e1.employee_id, ' - ', e1.first_name, ' ', e1.last_name) AS "Employee",
  j1.job_title AS "Employee Title",
  CONCAT(e2.employee_id, ' - ', e2.first_name, ' ', e2.last_name) AS "Manager",
  j2.job_title AS "Manager Title"
FROM hr.employees e1
JOIN hr.jobs j1 ON e1.job_id = j1.job_id
LEFT JOIN hr.employees e2 ON e1.manager_id = e2.employee_id 
LEFT JOIN hr.jobs j2 ON e2.job_id = j2.job_id 
ORDER BY e1.employee_id;

-- =====================================================================


/* 003
 * Develop a query that lists all countries by region. The data to be 
 * displayed is the region's name along with the names of its countries.
*/
SELECT r.region_id , r.region_name, c.country_name 
FROM hr.regions r 
JOIN hr.countries c ON r.region_id = c.region_id
ORDER BY r.region_id, c.country_name ;

-- =====================================================================


/* 004
 * Run a query that displays employee ID, first and last names, and the 
 * start and end dates of the employee's job history.
*/
SELECT e.employee_id, e.first_name, e.last_name, jh.start_date, jh.end_date 
FROM hr.employees e 
JOIN hr.job_history jh ON e.employee_id = jh.employee_id ;

-- =====================================================================


/* 005
 * Create a query that displays the employee's first and last name with 
 * the title "Employee", their salary, commission percentage, 
 * total commission, and total salary.
*/
SELECT 
  CONCAT(e.first_name,' ', e.last_name) AS "Employee",
  e.salary, 
  COALESCE(e.commission_pct, 0) AS "Commission %",
  e.salary * COALESCE(e.commission_pct, 0) AS "Commission Amount",
  e.salary + (e.salary * COALESCE(e.commission_pct, 0)) AS "Total Salary"
FROM hr.employees e;

-- =====================================================================


/* 006
 * Create a query that lists the job title and salary of employees who
 * are managers, whose ID is 100 or 125, and whose salary is greater 
 * than 6000.
*/
-- One Way
SELECT j.job_title, e.salary 
FROM hr.employees e 
JOIN hr.jobs j ON e.job_id = j.job_id 
WHERE e.employee_id = 100 OR e.employee_id = 125 AND e.salary > 6000;

-- Another Way
SELECT 
  j.job_title, e.salary
FROM hr.employees e
JOIN hr.jobs j ON e.job_id = j.job_id 
WHERE e.employee_id IN (100, 125)
AND e.salary > 6000;

-- =====================================================================


/* 007
 * Develop a query that lists the location code, city, and department
 * name only for those located outside the United States (US).
*/
-- One Way
SELECT l.location_id, l.city, d.department_name 
FROM hr.locations l
JOIN hr.departments d ON l.location_id = d.location_id 
WHERE l.country_id != 3;

-- Another Way
SELECT l.location_id, l.city, d.department_name 
FROM hr.departments d 
JOIN hr.locations l ON d.location_id = l.location_id 
JOIN hr.countries c ON l.country_id = c.country_id 
WHERE c.country_name != 'United States of America' ;

-- =====================================================================


/* 008
 * Perform a query that displays the region code, region name, and the 
 * names of the countries located in "Asia".
*/


-- =====================================================================


/* 009
 * Create a query that lists the region code, region name, location code, 
 * city, and country name for locations with an ID larger than 2400.
*/

-- =====================================================================


/* 010
 * Develop a query that displays the region code with a "Region Alias",
 * the region name with a "Region Name" label, and a concatenated string 
 * formatted as: "Country Code: [ID] Name: [Name]". 
 * Include the location code, street address, and postal code with their 
 * respective labels. Exclude records where the postal code is NULL.
*/

-- =====================================================================


/* 011
 * Develop a query that displays the average salary of employees in 
 * departments 30 and 80.
*/

-- =====================================================================


/* 012
 * Develop a query that displays the region name, country name, state/province, 
 * manager's employee ID, and the full names of managers located in the 
 * United Kingdom (UK) and the United States (US), specifically in the 
 * states of Washington and Oxford.
*/

-- =====================================================================


/* 013
 * Perform a query that displays the first and last names of employees
 * who work in departments located in countries starting with the 
 * letter 'C', including the country name.
*/

-- =====================================================================


/* 014
 * Develop a query that lists the job title, first name, and last name of
 * the employee with the email 'NKOCHHAR', as of September 21, 1989.
*/

-- =====================================================================


/* 015
 * Write a single query that lists employees in departments 10, 20, and 80
 * who were hired more than 180 days ago, earn a commission of at least
 * 20%, and whose first or last name begins with the letter 'J'.
*/

-- =====================================================================


/* 016
 * Perform a query that displays the first name, last name, and department
 * name of employees whose phone number has the area code 515. 
 * Exclude phone numbers that are not exactly 12 characters long.
*/

-- =====================================================================


/* 017
 * Develop a query that displays the employee ID, full name (separated 
 * by a comma), salary, department ID, and department name (as "Description"). 
 * Filter for the IT department only and sort by salary in descending order.
*/

-- =====================================================================


/* 018
 * Perform a query that lists the full name, salary, department name, 
 * address, postal code, and city. Filter for departments 100, 80, and 50 
 * located in "South San Francisco" with a salary between 4000 and 8000.
*/

-- =====================================================================


/* 019
 * Develop a query selecting employee ID (as "Code"), and "Last Name, First Name" 
 * (as "Names"). Concatenate the email with the domain "@eisi.ues.edu.sv" 
 * and capitalize the first letter. Format phone numbers: 
 * - '515.123.4567' becomes '(515)-123-4567'
 * - '011.44.1344.429268' becomes '(011-44-1344-429268)'
 * Sort by employee code.
*/

-- =====================================================================


/* 020
 * Develop a query to select cities and country codes. If the country 
 * is 'UK', label it 'UNKing'; otherwise, label it 'Non-UNKing'. 
 * Only show cities starting with the letter 'S'.
*/

-- =====================================================================


/* 021
 * Develop a query that displays the department ID (as "Department Code") 
 * and the count of employees per department, sorted by department ID.
*/

-- =====================================================================


/* 022
 * Run a query that shows only the first names of employees that are duplicated.
*/

-- =====================================================================


/* 023
 * Develop a query that displays only the first names of employees 
 * that are unique (not repeated).
*/

-- =====================================================================


/* 024
 * Perform a query that shows the number of countries per region. 
 * Display the region code, region name, and the count of countries, 
 * sorted by the highest count.
*/

-- =====================================================================


/* 025
 * Develop a query that lists job IDs and the number of employees 
 * per job, sorted by the count in descending order.
*/

-- =====================================================================


/* 026
 * Develop a query that displays the number of employees per department, 
 * sorted alphabetically by department name.
*/

-- =====================================================================


/* 027
 * Perform a query that shows the total number of departments per region.
*/

-- =====================================================================


/* 028
 * Run a query that shows the total salary paid by each department 
 * (excluding commissions). Display department ID, name, and total salary, 
 * sorted by total salary in descending order.
*/

-- =====================================================================


/* 029
 * Develop a query that displays the hire year, along with the minimum, 
 * maximum, and average salary for all employees grouped by year. 
 * Sort by year (most recent first).
*/

-- =====================================================================


/* 030
 * Develop a query that displays the department ID, job ID, and 
 * employee count for departments 50 and 80, sorted by department and job.
*/

-- =====================================================================


/* 031
 * Develop a query that lists the department ID, job ID, and 
 * employee count for job positions that are held by only one 
 * employee in the entire company.
*/

-- =====================================================================


/* 032
 * Perform a query that lists the number of employees per city who earn 
 * at least $5,000. Omit cities with fewer than 3 such employees.
*/

-- =====================================================================


/* 033
 * Create a query that displays the department ID and the count of 
 * employees for departments with more than 10 employees.
*/

-- =====================================================================


/* 034
 * Develop a query that lists the last name, first name, and salary 
 * of the employee(s) with the highest salary in the entire company.
*/

-- =====================================================================


/* 035
 * Develop a query that displays the department ID and full names of 
 * employees who work in departments that have at least one employee 
 * named 'John'.
*/

-- =====================================================================


/* 036
 * Develop a query that lists the department ID, full name, and salary 
 * of only the highest-paid employees in each department.
*/

-- =====================================================================


/* 037
 * Create a query that displays the department ID, department name, 
 * and the maximum salary for each department.
*/

-- =====================================================================


/* 038
 * Find all records in the employees table that contain a value that 
 * occurs exactly twice in a specific column (e.g., job_id).
*/

-- =====================================================================


/* 039
 * Run a query that lists employees who work in departments with 
 * fewer than 10 employees.
*/

-- =====================================================================


/* 040
 * Develop a query that shows the highest salary in department 30 
 * and lists the employees who earn that salary.
*/

-- =====================================================================


/* 041
 * Create a query that shows the departments where there are 
 * currently no employees assigned.
*/

-- =====================================================================


/* 042
 * Develop a query that shows all employees who do not work in 
 * department 30 and whose salary is higher than that of every 
 * employee in department 30.
*/

-- =====================================================================


/* 043
 * Perform a query that shows managers (manager_id) and the number of 
 * employees reporting to them, sorted by the number of subordinates 
 * in descending order. Exclude managers with 5 or fewer reports.
*/

-- =====================================================================


/* 044
 * Develop a query that displays employee ID, last name, salary, region, 
 * country, state, department ID, and department name where:
 * a) The salary is higher than the department average.
 * b) They are not located in 'Texas'.
 * c) They do not belong to the 'Finance' department.
 * Sort by employee ID.
*/

-- =====================================================================


/* 045
 * [HARD - OPERATIONAL REPORT]
 * Develop a query that lists the department name, the full name of the manager, 
 * and the number of employees in that department, but only for departments 
 * where the average salary is higher than the average salary of the entire 
 * company. Additionally, ensure that the manager has been with the company 
 * for more than 5 years.
*/

-- =====================================================================










