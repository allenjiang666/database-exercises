USE employees;

#Find all employees with first names 'Irena', 'Vidya', or 'Maya'
SELECT * 
FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya');

#Find all employees whose last name starts with 'E'
SELECT * 
FROM employees
Where last_name LIKE 'e%'; # LIKE is not case sensitive

#Find all employees hired in the 90s
SELECT * 
FROM employees
WHERE hire_date LIKE '%199%';

#Alternative way.
SELECT *
FROM employees
WHERE YEAR(hire_date) Between 1990 AND 1999;

#Find all employees born on Christmas
SELECT *
FROM employees
WHERE birth_date LIKE '%12-25';

#alternative
SELECT *
FROM employees
WHERE MONTH(birth_date) = 12 AND DAY(birth_date) = 25;

#Find all employees with a 'q' in their last name
SELECT *
FROM employees
WHERE last_name LIKE '%q%';

#Update your query for 'Irena', 'Vidya', or 'Maya' to use OR instead of IN
SELECT * 
FROM employees 
WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';


#Add a condition to the previous query to find everybody with those names who is also Male
SELECT * 
FROM employees 
WHERE ( first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya') AND (gender = 'M');

#Find all employees whose last name starts or ends with 'E'
SELECT *
FROM employees
WHERE last_name LIKE 'e%' OR last_name LIKE '%e';

#Duplicate the previous query and update it to find all employees whose last name starts and ends with 'E'
SELECT *
FROM employees
WHERE last_name LIKE 'e%' AND last_name LIKE '%e';

#Find all employees hired in the 90s and born on Christmas
SELECT * 
FROM employees
WHERE hire_date LIKE '%199%' AND birth_date LIKE '%12-25';

#Find all employees with a 'q' in their last name but not 'qu'
SELECT *
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE "%qu%";





