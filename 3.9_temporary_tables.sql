#Create a file named 3.9_temporary_tables.sql to do your work for this exercise.

#1. Using the example from the lesson, re-create the employees_with_departments table.



CREATE TEMPORARY TABLE employees_with_departments AS
	SELECT emp_no, first_name, last_name, dept_no, dept_name
	FROM employees.employees
	JOIN employees.dept_emp USING(emp_no)
	JOIN employees.departments USING(dept_no)
	LIMIT 100;

SELECT * FROM employees_with_departments;

#Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
ALTER TABLE employees_with_departments ADD full_name VARCHAR(100);

#Update the table so that full name column contains the correct data
UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);

#Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

#Create a temporary table based on the payment table from the sakila database.
#Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.

CREATE TEMPORARY TABLE payment_from_sakila AS
	SELECT amount*100 AS 'amount'
	FROM sakila.`payment`;

SELECT * FROM payment_from_sakila;

# Change the column data type 
ALTER TABLE payment_from_sakila  MODIFY COLUMN amount INT;

DROP TABLE payment_from_sakila;


#Find out how the average pay in each department compares to the overall average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department to work for? The worst?

#Find out how the average pay in each department compares to the overall average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department to work for? The worst?

SELECT * FROM salary;

#Find out how the average pay in each department compares to the overall average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department to work for? The worst?
DROP TABLE salary;
SELECT * FROM salary;

CREATE TEMPORARY TABLE salary AS
	CREATE TEMPORARY TABLE salary AS
 	SELECT d.dept_name, AVG(salary) AS "avg_salary"
 	FROM employees.salaries s
 	JOIN employees.dept_emp de ON s.emp_no = de.emp_no
 	JOIN employees.departments d ON d.dept_no = de.dept_no
 	WHERE s.to_date > NOW() AND de.to_date > NOW()
 	GROUP BY d.dept_no
 	;


SELECT dept_name, 
	(avg_salary - (
	SELECT 
	AVG(salary) 
	FROM employees.salaries
	WHERE to_date > NOW()
	)) 
	/ 
	(SELECT 
	STD(salary) AS "std"
	FROM employees.salaries
	WHERE to_date > NOW()
	) AS "salary_z_score"
FROM salary;






#USe Temporary table when you need to update some data into data by yourself. use subqurey when you dont update any new information in the data.