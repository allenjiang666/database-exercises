USE join_example_db;
#JOIN
SELECT users.name as user_name, roles.name as role_name
FROM users
JOIN roles ON users.role_id = roles.id;

#LEFT JOIN
SELECT users.name AS user_name, roles.name AS role_name
FROM users
LEFT JOIN roles ON users.role_id = roles.id;

#RIGHT JOIN
SELECT users.name AS user_name, roles.name AS role_name
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

USE employees;
#Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
SELECT 
		d.dept_name AS "DEPARTMENT NAME",
    CONCAT(e.first_name, " ", e.last_name) 
    AS "Department Manger"
FROM employees AS e
JOIN dept_manager AS dm
ON dm.emp_no = e.emp_no # Key has same left right order as the table.
JOIN departments AS d 
ON d.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01';#current employee

#Find the name of all departments currently managed by women.
SELECT 
	d.dept_name AS "Department Name",
	CONCAT(e.first_name, " ", e.last_name ) AS "Manager Name"
FROM employees AS e
JOIN dept_manager AS dm
ON dm.emp_no = e.emp_no
JOIN departments AS d
ON d.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01' AND e.gender = 'F';

#Find the current titles of employees currently working in the Customer Service department.
SELECT 
	t.title AS "Title",
	d.dept_name,
COUNT(*)
FROM titles AS t
JOIN employees_with_departments AS ewd
ON ewd.emp_no = t.emp_no
JOIN departments AS d
ON d.dept_name = ewd.dept_name
WHERE t.to_date = '9999-01-01' AND d.dept_no = 'd009' # Alternative way d.dept_name = "Customer Service"
GROUP BY Title;

#Find the current salary of all current managers.
SELECT 
	d.dept_name AS "Department Name",
	CONCAT(e.first_name, " ", e.last_name) AS 'Name',
	s.salary AS "Salary"
FROM employees AS e
JOIN salaries AS s
On s.emp_no = e.emp_no
JOIN dept_manager AS dm
ON dm.emp_no = e.emp_no
JOIN departments AS d
On d.dept_no = dm.dept_no
WHERE s.to_date = '9999-01-01' AND dm.to_date = '9999-01-01';

#Find the number of employees in each department.
SELECT 
	de.dept_no,
	d.dept_name,
	COUNT(d.dept_name)
FROM departments AS d
JOIN dept_emp AS de
ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01'
GROUP BY d.dept_name
ORDER BY de.dept_no;# Group By is after Where.


# Which department has the highest average salary?
SELECT d.dept_name,
	AVG(salary) AS "Average_salary",# Average can be used in different group
FROM departments AS d
JOIN dept_emp AS de
ON d.dept_no = de.dept_no
JOIN salaries AS s
ON s.emp_no = de.emp_no
WHERE s.to_date = '9999-01-01' 
GROUP BY d.dept_name;

#Who is the highest paid employee in the Marketing department?
SELECT 	
	#ewd.emp_no,
	ewd.first_name, 
	ewd.last_name,
	s.salary
FROM employees_with_departments AS ewd
JOIN salaries AS s
On s.emp_no = ewd.emp_no
WHERE dept_name = 'Marketing' AND to_date = "9999-01-01"
ORDER BY salary DESC
LIMIT 1;

#Which current department manager has the highest salary?
SELECT 
		d.dept_name AS "DEPARTMENT NAME",
    CONCAT(e.first_name, " ", e.last_name) 
    AS "Department Manger",
    s.salary
FROM employees AS e
JOIN dept_manager AS dm
ON dm.emp_no = e.emp_no # Key has same left right order as the table.
JOIN departments AS d 
ON d.dept_no = dm.dept_no
JOIN salaries AS s
ON s.emp_no = e.emp_no
WHERE dm.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
ORDER BY s.salary DESC
LIMIT 1;