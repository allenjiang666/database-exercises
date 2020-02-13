#Find all the employees with the same hire date as employee 101010 using a sub-query.
SELECT CONCAT(first_name, " ", last_name) AS `Name`
FROM `employees`
WHERE hire_date IN 
	(SELECT hire_date 
	FROM employees 
	WHERE emp_no = 101010);

#Find all the titles held by all employees with the first name Aamod
SELECT title # SELECT DISTINCT title
FROM titles 
WHERE emp_no IN 
	(SELECT emp_no
	FROM employees 
	WHERE first_name = "Aamod")
GROUP BY title;

#How many people in the employees table are no longer working for the company?
SELECT COUNT(emp_no) AS `Number of employee no longer working`
FROM employees 
WHERE emp_no NOT IN # NOT !!!!
	(SELECT emp_no
	FROM dept_emp
	WHERE to_date > CURDATE());
	
#to_date > CURDATE() is wrong
	
#Alternative way 
SELECT (
	SELECT COUNT(*)
	FROM employees 
) - (
	SELECT COUNT(*)
	FROM salaries
	WHERE to_date > CURDATE()
);
#Find all the current department managers that are female.
SELECT first_name, last_name
FROM employees 
WHERE emp_no IN 
	(SELECT dm.emp_no
	FROM dept_manager AS dm
	JOIN employees AS e ON dm.emp_no = e.emp_no 
	WHERE dm.to_date > CURDATE()) 
	AND gender = "F";

#Find all the employees that currently have a higher than average salary.

#154543 rows in total. Here is what the first 5 rows will look like:

+------------+-----------+--------+
| first_name | last_name | salary |
+------------+-----------+--------+
| Georgi     | Facello   | 88958  |
| Bezalel    | Simmel    | 72527  |
| Chirstian  | Koblick   | 74057  |
| Kyoichi    | Maliniak  | 94692  |
| Tzvetan    | Zielinski | 88070  |
+------------+-----------+--------+
SELECT first_name, last_name
FROM employees
WHERE emp_no In 
	(SELECT emp_no
	FROM salaries 
	WHERE salary > 
		(SELECT AVG(salary)
		FROM salaries
		#WHERE to_date > CURDATE()
		) AND to_date >CURDATE()
		);

SELECT first_name, last_name, salary
FROM employees AS e
JOIN salaries AS s ON e.emp_no = s.emp_no
WHERE salary > (
		SELECT AVG(salary)
		FROM salaries
		#WHERE to_date > CURDATE()
		) 
		AND s.to_date >CURDATE();

#How many current salaries are within 1 standard deviation of the highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
SELECT *
	FROM salaries
	WHERE salary >
	(SELECT 
		MAX(salary) - STD(salary) 
	FROM salaries
	WHERE to_date > CURDATE())
	 AND to_date > CURDATE();
	 
SELECT MAX(salary), STD(salary)
FROM salaries;

#Bonus Find all the department names that currently have female managers.
SELECT d.dept_name
FROM dept_manager  dm
JOIN departments  d ON d.dept_no = dm.dept_no
WHERE emp_no IN(
	SELECT emp_no
	FROM employees
	WHERE gender = "F"
) AND to_date > CURDATE()
;

#Find the first and last name of the employee with the highest salary

SELECT first_name, last_name
FROM salaries s
JOIN employees e ON e.emp_no = s.emp_no
WHERE salary IN
	(
		SELECT MAX(salary)
		FROM salaries
			)
;


#Find the department name that the employee with the highest salary works in.
SELECT d.dept_name
FROM salaries s
JOIN employees e ON e.emp_no = s.emp_no
JOIN dept_emp de ON de.emp_no = s.emp_no
JOIN departments d ON d.dept_no = de.dept_no
WHERE salary IN
	(
		SELECT MAX(salary)
		FROM salaries
			)
		;