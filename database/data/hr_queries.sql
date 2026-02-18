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
SELECT r.region_id, r.region_name, c.country_name 
FROM hr.regions r
JOIN hr.countries c ON r.region_id = c.region_id 
WHERE r.region_name ILIKE 'Asia' ;

-- =====================================================================


/* 009
 * Create a query that lists the region code, region name, location code, 
 * city, and country name for locations with an ID larger than 2400.
*/
-- One Way
SELECT r.region_id, r.region_name, l.location_id, l.city, c.country_name 
FROM hr.regions r
JOIN hr.countries c ON r.region_id = c.region_id 
JOIN hr. locations l ON c.country_id = l.country_id 
WHERE l.location_id > 2400 ;

-- Another Way with CTE
WITH regional_countries AS (
    SELECT r.region_id, r.region_name, c.country_id, c.country_name
    FROM hr.regions r
    JOIN hr.countries c ON r.region_id = c.region_id
)
SELECT rc.region_id, rc.region_name, l.location_id, l.city, rc.country_name
FROM regional_countries rc
JOIN hr.locations l ON rc.country_id = l.country_id
WHERE l.location_id > 2400;

-- Another way with USING
SELECT region_id, region_name, location_id, city, country_name 
FROM hr.regions 
JOIN hr.countries USING (region_id) 
JOIN hr.locations USING (country_id) 
WHERE location_id > 2400;

-- =====================================================================


/* 010
 * Develop a query that displays the region code with a "Region Alias",
 * the region name with a "Region Name" label, and a concatenated string 
 * formatted as: "Country Code: [ID] Name: [Name]". 
 * Include the location code, street address, and postal code with their 
 * respective labels. Exclude records where the postal code is NULL.
*/
SELECT 
  r.region_id AS "Region Alias",
  r.region_name AS "Region Name",
  'Country Code: [' || c.country_id || '] Name: [' || c.country_name || ']' AS "Country Info",
  l.location_id AS "Location Code",
  l.street_address AS "Street Address",
  l.postal_code AS "Postal Code"
FROM hr.regions r
JOIN hr.countries c ON r.region_id = c.region_id 
JOIN hr.locations l ON c.country_id = l.country_id 
WHERE l.postal_code IS NOT NULL; -- Exclude the NULLS

-- Another Way
SELECT 
    r.region_id AS "Region Alias", 
    r.region_name AS "Region Name",
    CONCAT('Country Code: [', c.country_id, '] Name: [', c.country_name, ']') AS "Country Info",
    l.location_id AS "Location Code",
    l.street_address AS "Street Address",
    l.postal_code AS "Postal Code"
FROM hr.regions r
JOIN hr.countries c ON r.region_id = c.region_id
JOIN hr.locations l ON c.country_id = l.country_id
WHERE l.postal_code IS NOT NULL;

-- =====================================================================


/* 011
 * Develop a query that displays the average salary of employees in 
 * departments 30 and 80.
*/
SELECT 
  AVG(e.salary)
 FROM hr.employees e 
 JOIN hr.departments d ON e.department_id = d.department_id 
 WHERE d.department_id IN (30, 80);
 
 -- Improve the same query
SELECT 
  d.department_id, 
  ROUND(AVG(e.salary), 2) AS "Average Salary"
FROM hr.employees e
JOIN hr.departments d ON e.department_id = d.department_id
WHERE d.department_id IN (30, 80)
GROUP BY d.department_id ;

-- =====================================================================


/* 012
 * Develop a query that displays the region name, country name, state/province, 
 * manager's employee ID, and the full names of managers located in the 
 * United Kingdom (UK) and the United States (US), specifically in the 
 * states of Washington and Oxford.
*/
SELECT 
    r.region_name,
    c.country_name,
    l.state_province,
    e.employee_id AS manager_id,
    CONCAT(e.first_name, ' - ', e.last_name) AS "Name"
FROM hr.regions r
JOIN hr.countries c ON r.region_id = c.region_id
JOIN hr.locations l ON c.country_id = l.country_id
JOIN hr.departments d ON l.location_id = d.location_id
JOIN hr.employees e ON d.manager_id = e.employee_id -- United with the boss and dpto
WHERE 
    (c.country_name = 'United Kingdom' OR c.country_name = 'United States of America')
    AND 
    (l.state_province = 'Washington' OR l.state_province = 'Oxford')
ORDER BY c.country_name;

-- The Improve Version
SELECT 
    r.region_name,
    c.country_name,
    l.state_province,
    e.employee_id AS manager_id,
    CONCAT(e.first_name, ' ', e.last_name) AS "Manager Name"
FROM hr.regions r
JOIN hr.countries c ON r.region_id = c.region_id
JOIN hr.locations l ON c.country_id = l.country_id
JOIN hr.departments d ON l.location_id = d.location_id
JOIN hr.employees e ON d.manager_id = e.employee_id 
WHERE c.country_name IN ('United Kingdom', 'United States of America')
  AND l.state_province IN ('Washington', 'Oxford')
ORDER BY c.country_name;

-- =====================================================================


/* 013
 * Perform a query that displays the first and last names of employees
 * who work in departments located in countries starting with the 
 * letter 'C', including the country name.
*/
SELECT 
  e.first_name,
  e.last_name,
  c.country_name 
FROM hr.employees e 
JOIN hr.departments d ON e.department_id = d.department_id 
JOIN hr.locations l ON d.location_id = l.location_id 
JOIN hr.countries c ON l.country_id = c.country_id 
WHERE c.country_name ILIKE 'C%' ;

-- =====================================================================


/* 014
 * Develop a query that lists the job title, first name, and last name of
 * the employee with the email 'NKOCHHAR', as of September 21, 2015.
*/
SELECT j.job_title, e.first_name, e.last_name 
FROM hr.employees e 
JOIN hr.jobs j ON e.job_id = j.job_id 
WHERE e.email ILIKE('%NKOCHHAR%') AND e.hire_date = '2015-09-21' ;

-- Another Way
SELECT job_title, first_name, last_name 
FROM hr.employees 
JOIN hr.jobs USING (job_id) 
WHERE email ILIKE '%NKOCHHAR%' AND hire_date = '2015-09-21';

-- Now Usin CTE
WITH buscado AS (
    SELECT first_name, last_name, job_id 
    FROM hr.employees 
    WHERE email ILIKE '%NKOCHHAR%' AND hire_date = '2015-09-21'
)
SELECT j.job_title, b.first_name, b.last_name 
FROM hr.jobs j
JOIN buscado b ON j.job_id = b.job_id;

-- With SubQuery
SELECT 
    (SELECT job_title FROM hr.jobs j WHERE j.job_id = e.job_id) AS "Job",
    e.first_name, 
    e.last_name 
FROM hr.employees e 
WHERE e.email ILIKE '%NKOCHHAR%' AND e.hire_date = '2015-09-21';

-- =====================================================================


/* 015
 * Write a single query that lists employees in departments 10, 20, and 80
 * who were hired more than 180 days ago, earn a commission of at least
 * 20%, and whose first or last name begins with the letter 'J'.
*/
SELECT 
    d.department_id, 
    e.first_name, 
    e.last_name, 
    e.salary, 
    e.commission_pct, 
    e.hire_date
FROM hr.employees e 
JOIN hr.departments d ON e.department_id = d.department_id 
WHERE e.department_id IN (10,20,80)
  AND e.commission_pct >= 0.20 
  AND (e.first_name ILIKE 'J%' OR e.last_name ILIKE 'J%')
  AND (CURRENT_DATE - e.hire_date) > 180;

-- =====================================================================


/* 016
 * Perform a query that displays the first name, last name, and department
 * name of employees whose phone number has the area code 515. 
 * Exclude phone numbers that are not exactly 12 characters long.
*/
SELECT 
  e.first_name,
  e.last_name,
  d.department_name,
  e.phone_number 
FROM hr.employees e 
JOIN hr.departments d ON e.department_id = d.department_id 
WHERE e.phone_number LIKE ('515%') AND LENGTH(e.phone_number) = 12;

-- Another way more precise
SELECT 
  e.first_name,
  e.last_name,
  d.department_name,
  e.phone_number 
FROM hr.employees e 
JOIN hr.departments d ON e.department_id = d.department_id 
WHERE e.phone_number LIKE '515_________' ;

-- =====================================================================


/* 017
 * Develop a query that displays the employee ID, full name (separated 
 * by a comma), salary, department ID, and department name (as "Description"). 
 * Filter for the IT department only and sort by salary in descending order.
*/
SELECT 
  e.employee_id,
  CONCAT(e.first_name, ', ', e.last_name ) AS Name, 
  e.salary, 
  CONCAT(d.department_id, ' - ', d.department_name) AS Description 
FROM hr.employees e
JOIN hr.departments d ON e.department_id = d.department_id 
WHERE d.department_name ILIKE 'IT' 
ORDER BY e.salary DESC ; 

-- =====================================================================


/* 018
 * Perform a query that lists the full name, salary, department name, 
 * address, postal code, and city. Filter for departments 100, 80, and 50 
 * located in "South San Francisco" with a salary between 4000 and 8000.
*/
SELECT 
  CONCAT(e.first_name, ' ', e.last_name) AS Name,
  e.salary,
  d.department_name,
  l.street_address,
  l.postal_code,
  l.city 
FROM hr.employees e 
JOIN hr.departments d ON e.department_id = d.department_id 
JOIN hr.locations l ON d.location_id = l.location_id 
WHERE d.department_id IN (50, 80, 100)
AND l.city ILIKE 'South San Francisco'
AND e.salary between 4000 AND 8000 ;

-- =====================================================================


/* 019
 * Develop a query selecting employee ID (as "Code"), and "Last Name, First Name" 
 * (as "Names"). Concatenate the email with the domain "@eisi.ues.edu.sv" 
 * and capitalize the first letter. Format phone numbers: 
 * - '515.123.4567' becomes '(515)-123-4567'
 * - '011.44.1344.429268' becomes '(011-44-1344-429268)'
 * Sort by employee code.
*/
SELECT 
  e.employee_id AS Code,
  CONCAT(e.last_name, ', ', e.first_name) AS "Names",
  INITCAP(CONCAT(e.email, '@eisi.ues.edu.sv')) AS "Email",
  CASE 
    WHEN LENGTH(e.phone_number) <= 12 THEN
      '(' || SUBSTR(e.phone_number, 1, 3) || ')-' || REPLACE(SUBSTR(e.phone_number, 5), '.', '-')
    ELSE
      '(' || REPLACE(e.phone_number, '.', '-') || ')'
  END AS "Phone"
FROM hr.employees e 
ORDER BY e.employee_id ASC ;

-- Modern Way
SELECT 
  employee_id AS "Code",
  last_name || ', ' || first_name AS "Names",
  INITCAP(email || '@eisi.ues.edu.sv') AS "Email",
  CASE 
    WHEN phone_number LIKE '515.%' THEN 
      REGEXP_REPLACE(phone_number, '(\d{3})\.(\d{3})\.(\d{4})', '(\1)-\2-\3')
    ELSE 
      '(' || REPLACE(phone_number, '.', '-') || ')'
  END AS "Phone"
FROM hr.employees
ORDER BY employee_id;

-- =====================================================================


/* 020
 * Develop a query to select cities and country codes. If the country 
 * is 'UK', label it 'UNKing'; otherwise, label it 'Non-UNKing'. 
 * Only show cities starting with the letter 'S'.
*/
SELECT 
  l.city,
  c.country_id, 
  CASE 
    WHEN c.country_name = 'United Kingdom' THEN 'UNKing'
    ELSE 'Non-UNKing'
  END AS "Status"
FROM hr.locations l
JOIN hr.countries c ON l.country_id = c.country_id 
WHERE l.city LIKE 'S%';

-- =====================================================================


/* 021
 * Develop a query that displays the department ID (as "Department Code") 
 * and the count of employees per department, sorted by department ID.
*/
SELECT 
  e.department_id AS "Department Code",
  COUNT(*) AS "Total of Employees"
FROM hr.employees e
GROUP BY e.department_id 
ORDER BY e.department_id ASC ;

-- Another Way
SELECT 
  d.department_name AS "Department",
  COUNT(e.employee_id) AS "Total"
FROM hr.employees e
JOIN hr.departments d ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY d.department_name;

-- =====================================================================


/* 022
 * Run a query that shows only the first names of employees that are duplicated.
*/
SELECT 
  e.first_name AS "Name",
  COUNT(*) AS "Duplicates" 
FROM hr.employees e
GROUP BY e.first_name 
HAVING COUNT(*) > 1 ;

-- =====================================================================


/* 023
 * Develop a query that displays only the first names of employees 
 * that are unique (not repeated).
*/
SELECT 
  e.first_name, 
  COUNT(*) AS "Total"
FROM hr.employees e 
GROUP BY e.first_name 
HAVING COUNT(*) > 1 ;

-- Improve version
SELECT 
  e.first_name
FROM hr.employees e 
GROUP BY e.first_name 
HAVING COUNT(*) = 1 ;

-- =====================================================================


/* 024
 * Perform a query that shows the number of countries per region. 
 * Display the region code, region name, and the count of countries, 
 * sorted by the highest count.
*/
SELECT 
    r.region_id AS "Region Code",
    r.region_name AS "Region Name",
    COUNT(c.country_id) AS "Number of Countries"
FROM hr.regions r
LEFT JOIN hr.countries c ON r.region_id = c.region_id 
GROUP BY r.region_id, r.region_name
ORDER BY COUNT(c.country_id) DESC;

-- With CTE
WITH CountryCount AS (
    SELECT region_id, COUNT(*) as total
    FROM hr.countries
    GROUP BY region_id
)
SELECT 
    r.region_id,
    r.region_name,
    COALESCE(cc.total, 0) AS "Number of Countries"
FROM hr.regions r
LEFT JOIN CountryCount cc ON r.region_id = cc.region_id
ORDER BY total DESC NULLS LAST;

-- Improve the query
SELECT 
    r.region_id,
    r.region_name,
    COUNT(c.region_id) 
FROM hr.regions r
LEFT JOIN hr.countries c ON r.region_id = c.region_id 
GROUP BY r.region_id, r.region_name
ORDER BY 3 DESC;

-- =====================================================================


/* 025
 * Develop a query that lists job IDs and the number of employees 
 * per job, sorted by the count in descending order.
*/
SELECT 
  e.job_id, 
  COUNT(e.job_id) AS "Number of Employees"
FROM hr.employees e 
GROUP BY e.job_id 
ORDER BY COUNT(e.job_id) DESC ;

-- =====================================================================


/* 026
 * Develop a query that displays the number of employees per department, 
 * sorted alphabetically by department name.
*/
SELECT 
  d.department_name,
  COUNT(e.department_id) AS "Total Employees"
FROM hr.employees e 
JOIN hr.departments d ON e.department_id = d.department_id 
GROUP BY d.department_id,  d.department_name 
ORDER BY d.department_name ASC; 

-- =====================================================================


/* 027
 * Perform a query that shows the total number of departments per region.
*/
SELECT 
  r.region_name,
  COUNT(d.department_id) AS "Total Departments"
FROM hr.regions r
LEFT JOIN hr.countries c ON r.region_id = c.region_id 
LEFT JOIN hr.locations l ON c.country_id = l.country_id 
LEFT JOIN hr.departments d ON l.location_id = d.location_id 
GROUP BY r.region_id, r.region_name 
ORDER BY "Total Departments" DESC ;

-- =====================================================================


/* 028
 * Run a query that shows the total salary paid by each department 
 * (excluding commissions). Display department ID, name, and total salary, 
 * sorted by total salary in descending order.
*/
SELECT 
  d.department_id,
  d.department_name,
  SUM(e.salary) AS "Total Salary" 
FROM hr.employees e
JOIN hr.departments d ON e.department_id = d.department_id 
GROUP BY d.department_id, d.department_name 
ORDER BY "Total Salary" DESC ;

-- Improve the query.
SELECT 
  d.department_id,
  d.department_name,
  -- TO_CHAR to format  money: L999,999,999
  TO_CHAR(SUM(e.salary), 'L999G999G999') AS "Total Salary" 
FROM hr.employees e
JOIN hr.departments d ON e.department_id = d.department_id 
GROUP BY d.department_id, d.department_name 
ORDER BY SUM(e.salary) DESC;

-- =====================================================================


/* 029
 * Develop a query that displays the hire year, along with the minimum, 
 * maximum, and average salary for all employees grouped by year. 
 * Sort by year (most recent first).
*/
SELECT 
  EXTRACT(YEAR FROM e.hire_date) AS "Hire Year",
  MIN(e.salary) AS "Min Salary",
  MAX(e.salary) AS "Max Salary",
  ROUND(AVG(e.salary), 2) AS "Average Salary"
FROM hr.employees e
GROUP BY EXTRACT(YEAR FROM e.hire_date) 
ORDER BY 1 DESC; -- reference first column

-- Improve the query
SELECT 
  TO_CHAR(e.hire_date, 'YYYY') AS "Hire Year", -- 'YYYY' extract year 
  MIN(e.salary) AS "Min Salary",
  MAX(e.salary) AS "Max Salary",
  ROUND(AVG(e.salary), 2) AS "Average Salary"
FROM hr.employees e
GROUP BY TO_CHAR(e.hire_date, 'YYYY') 
ORDER BY 1 DESC;

-- =====================================================================


/* 030
 * Develop a query that displays the department ID, job ID, and 
 * employee count for departments 50 and 80, sorted by department and job.
*/
SELECT 
  e.department_id,
  e.job_id,
  COUNT(*) AS "Employees per Department"
FROM hr.employees e 
WHERE e.department_id IN (50, 80)
GROUP BY e.department_id, e.job_id 
ORDER BY e.department_id ASC, e.job_id ASC;

-- =====================================================================


/* 031
 * Develop a query that lists the department ID, job ID, and 
 * employee count for job positions that are held by only one 
 * employee in the entire company.
*/

/* 031
 * Develop a query that lists the department ID, job ID, and 
 * employee count for job positions that are held by only one 
 * employee in the entire company.
 * * Technical Logic: A subquery is used to identify job_ids with a 
 * global count of 1 (entire company). The main query then filters 
 * by these IDs to show their respective departments. 
 * Using GROUP BY/HAVING in the main query alone would only find 
 * uniqueness within each department, not the whole company.
*/

SELECT 
  e.department_id AS "Department ID",
  e.job_id AS "Job Position",
  COUNT(*) AS "Employee Count"
FROM hr.employees e
WHERE e.job_id IN (
    -- This subquery identifies job positions held by only one person company-wide
    SELECT job_id
    FROM hr.employees
    GROUP BY job_id
    HAVING COUNT(*) = 1
)
GROUP BY e.department_id, e.job_id;

-- =====================================================================


/* 032
 * Perform a query that lists the number of employees per city who earn 
 * at least $5,000. Omit cities with fewer than 3 such employees.
*/
SELECT 
  l.city,
  COUNT(*) AS "Employees per City"
FROM hr.employees e
JOIN hr.departments d ON e.department_id = d.department_id 
JOIN hr.locations l ON d.location_id = l.location_id 
WHERE e.salary >= 5000  
GROUP BY l.city
HAVING COUNT(*) >= 3    
ORDER BY 2 DESC; -- Order by column 2

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










