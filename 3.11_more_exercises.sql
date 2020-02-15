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

#2.You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you could use to obtain this information?
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = "Joe";

#3. Find all actors whose last name contain the letters "gen":
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE "%gen%";

#4. Find all actors whose last names contain the letters "li". This time, order the rows by last name and first name, in that order.
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE "%l%"
ORDER BY last_name, first_name;

#5.Using IN, display the country_id and country columns for the following countries: Afghanistan, Bangladesh, and China:
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');


#6. List the last names of all the actors, as well as how many actors have that last name.
SELECT last_name, COUNT(*)
FROM actor
GROUP BY last_name;

#7. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
SELECT d.last_name 
FROM (
	SELECT  last_name, COUNT(*) > 1 AS is_duplicated
	FROM actor
	GROUP BY last_name
) as d
WHERE is_duplicated = 1;


#8.You cannot locate the schema of the address table. Which query would you use to re-create it?
DESCRIBE address;


#9.Use JOIN to display the first and last names, as well as the address, of each staff member.
SELECT first_name, last_name, address
FROM staff s
JOIN address USING(address_id);


#10.Use JOIN to display the total amount rung up by each staff member in August of 2005.

SELECT first_name, last_name, SUM(amount)
FROM staff s
JOIN payment p USING(staff_id)
WHERE payment_date LIKE "2005-08-%"
GROUP BY staff_id;

#11.List each film and the number of actors who are listed for that film.
SELECT title, CONCAT(first_name, " ", last_name) AS actor_name
FROM actor a
JOIN film_actor USING(actor_id)
JOIN film USING(film_id)
ORDER BY title;


#12.How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT title, COUNT(film_id)
FROM film f
JOIN inventory i USING(film_id)
WHERE title = "Hunchback Impossible"
;


#13.The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
SELECT title, l.name
FROM film f
JOIN language l USING(language_id)
WHERE title LIKE "K%" OR title LIKE "Q%";

#14.Use subqueries to display all actors who appear in the film Alone Trip.
SELECT CONCAT(first_name, " ", last_name) AS actor_name
FROM actor
WHERE actor_id IN 
(
	SELECT actor_id
	FROM film_actor 
	WHERE film_id = 
	(
		SELECT film_id
		FROM film
		WHERE title = "Alone Trip"
	)	
);


#15. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers.
SELECT 
	CONCAT(first_name, " ", last_name) AS customer_name,
	email
FROM customer
JOIN address USING(address_id)
JOIN city USING(city_id)
JOIN country USING(country_id)
WHERE country = "Canada";


#16.Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.
SELECT title
FROM film
WHERE film_id IN 
(
	SELECT film_id
FROM film_category
WHERE category_id = 
	(
		SELECT category_id
		FROM category 
		WHERE name = "Family"
		)
)
;

#17.Write a query to display how much business, in dollars, each store brought in.
SELECT store_id, staff_id, SUM(amount) AS total_payment
FROM payment p
JOIN store s ON s.manager_staff_id = p.staff_id
GROUP BY staff_id;

#18.WRITE a QUERY TO display FOR EACH store its store ID, city, AND country.
SELECT store_id, city, country
FROM store s
JOIN address a USING(address_id)
JOIN city c USING(city_id)
JOIN country co USING(country_id);
