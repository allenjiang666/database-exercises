#Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

SELECT emp_no, dept_no, from_date, to_date, to_date > NOW() AS is_current_employee
FROM employees
JOIN dept_emp USING(emp_no);

#2. Write a query that returns all employee names, and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT CONCAT(first_name, ' ', last_name) AS name,
	CASE 
		WHEN (LEFT(last_name,1) BETWEEN 'A' AND 'H') THEN "A-H"
		WHEN (LEFT(last_name,1) BETWEEN 'I' AND 'Q') THEN "I-Q"
		WHEN (LEFT(last_name,1) BETWEEN 'R' AND 'Z') THEN "R-Z"
		ELSE 0
		END AS alpha_group
FROM employees;

# Can not use this way.
SELECT CONCAT(first_name, ' ', last_name) AS name,
	CASE LEFT(last_name,1) 
		WHEN 'a' THEN "A-H" # It assume LEFT(last_name,1) = 'a'
		WHEN 'b' THEN "I-Q"
		WHEN 'c' THEN "R-Z"
		ELSE 0
		END AS alpha_group
FROM employees;

#3. How many employees were born in each decade?

SELECT MAX(birth_date), MIN(birth_date)
FROM employees;

SELECT decades_born, COUNT(decades_born)
FROM (
	SELECT emp_no, 
	CASE 
		WHEN birth_date BETWEEN "1950-01-01" AND "1959-12-31" 		THEN "50s"
		WHEN birth_date BETWEEN "1960-01-01" AND "1969-12-31" 		THEN "60s"
		ELSE "others"
		END AS "decades_born"
FROM employees) AS db
GROUP BY decades_born
;
#BONUS 
#What is the average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
SELECT dept_group, AVG(salary) AS avg_salary
FROM (SELECT salary,
        CASE 
            WHEN dept_name IN ('research', 'development') THEN 'R&D'
            WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing' 
            WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR' 
            WHEN dept_name in ('Production', 'Quality Management') THEN 'Prod & QM'
            ELSE dept_name
            END AS dept_group
			FROM departments d
			JOIN dept_emp de ON de.dept_no = d.dept_no
			JOIN salaries s  ON s.emp_no = de.emp_no
) AS dg
GROUP BY dept_group;