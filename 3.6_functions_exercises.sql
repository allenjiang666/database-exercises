USE employees;

#Find all employees with first names 'Irena', 'Vidya', or 'Maya'
SELECT * 
FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya') ;

#Find all employees whose last name starts with 'E'
SELECT *, 
CONCAT(first_name,' ',last_name) AS "full_name"
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
WHERE last_name LIKE 'e%' AND last_name LIKE '%e'; # 'e%e'

#Find all employees hired in the 90s and born on Christmas
SELECT * 
FROM employees
WHERE hire_date LIKE '%199%' AND birth_date LIKE '%12-25';

#Find all employees with a 'q' in their last name but not 'qu'
SELECT *
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE "%qu%";


#update the query to order by first name and then last name. The first result should now be Irena Acton and the last should be Vidya Zweizig.
SELECT * 
FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya') 
ORDER BY first_name, last_name;

#Change the order by clause so that you order by last name before first name. Your first result should still be Irena Acton but now the last result should be Maya Zyda.
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya') 
ORDER BY last_name, first_name;


#Update your queries for employees with 'E' in their last name to sort the results by their employee number. Your results should not change!
SELECT * 
FROM employees
Where last_name LIKE 'e%'
ORDER BY emp_no;

#Now reverse the sort order for both queries.
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya') 
ORDER BY last_name DESC, first_name ASC;

SELECT * 
FROM employees
Where last_name LIKE 'e%'
ORDER BY emp_no DESC;

#Change the query for employees hired in the 90s and born on Christmas such that the first result is the oldest employee who was hired last. It should be Khun Bernini.
SELECT * 
FROM employees
WHERE hire_date LIKE '%199%' AND birth_date LIKE '%-12-25'
ORDER BY birth_date ASC, hire_date DESC;



#Update your queries for employees whose names start and end with 'E'. Use concat() to combine their first and last name together as a single column named full_name.
SELECT *,
CONCAT(first_name,' ',last_name) AS "full_name"
FROM employees
WHERE last_name LIKE 'e%'; 

#Convert the names produced in your last query to all uppercase
SELECT *,
UPPER(CONCAT(first_name,' ',last_name)) AS "full_name"
FROM employees
WHERE last_name LIKE 'e%'; 

#For your query of employees born on Christmas and hired in the 90s, use datediff() to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE())
SELECT *,
DATEDIfF(CURDATE(), hire_date) AS 'days_at_company'
FROM employees
WHERE hire_date LIKE '%199%' AND birth_date LIKE '%-12-25'
ORDER BY days_at_company DESC;

#Find the smallest and largest salary from the salaries table.
SELECT 
MAX(salary),
MIN(salary)
FROM salaries;

#Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born
SELECT
CONCAT(LOWER(LEFT(first_name, 1)),LOWER(LEFT(last_name, 4)), '_', MONTH(birth_date), RIGHT(YEAR(birth_date),2)) AS username,
first_name,
last_name,
birth_date
FROM employees;


