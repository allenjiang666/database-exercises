#How much do the current managers of each department get paid, relative to the average salary for the department? Is there any department where the department manager gets paid less than the average salary?
SHOW DATABASES;
USE employees;

SELECT d.dept_name, 
	s.salary AS " manager_salary",
	da.avg_salary,
	(s.salary- da.avg_salary) > 0 AS "is_manager_makes_more_than_average"

FROM dept_manager dm 
JOIN salaries s USING(emp_no)
JOIN departments d USING(dept_no)
JOIN(
	SELECT dept_no, AVG(salary) AS "avg_salary"
	FROM dept_emp de 
	JOIN salaries s USING(emp_no)
	WHERE de.to_date > NOW() AND s.to_date > NOW()
	GROUP BY dept_no) AS da 
	ON dm.dept_no = da.dept_no
WHERE dm.to_date > NOW() AND s.to_date > NOW();

#Average salary of each department
SELECT dept_no, AVG(salary)
FROM dept_emp de 
JOIN salaries s USING(emp_no)
WHERE de.to_date > NOW() AND s.to_date > NOW()
GROUP BY dept_no;

#1.What languages are spoken in Santa Monica? 

SELECT Language, Percentage
FROM city 
JOIN countrylanguage USING(CountryCode)
WHERE name = 'Santa Monica'
ORDER BY Percentage, Language DESC
;

#2.How many different countries are in each region?
SELECT Region, COUNT(*) AS num_countries
FROM country
GROUP BY Region 
ORDER BY num_countries ASC ;

#3.What is the population for each region?
SELECT Region, SUM(Population)
FROM country
GROUP BY Region; 

#4. What is the average life expectancy globally?
SELECT AVG(LifeExpectancy)
FROM country;

#5. What is the average life expectancy for each region, each continent? Sort the results from shortest to longest
SELECT Continent, AVG(LifeExpectancy)
FROM country
GROUP BY Continent 
ORDER BY AVG(LifeExpectancy) ASC;

SELECT Region, AVG(LifeExpectancy)
FROM country
GROUP BY Region 
ORDER BY AVG(LifeExpectancy) ASC;

#Bonus
# 1. Find all the countries whose local name is different from the official name
SELECT Name, LocalName
FROM country
WHERE Name != LocalName;


