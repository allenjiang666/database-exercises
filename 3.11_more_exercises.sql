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

#19. LIST the top five genres IN gross revenue IN descending order. (Hint: you may need TO USE the following TABLES: category, film_category, inventory, payment, AND rental.)
SELECT c.name, SUM(amount) AS gross_income
FROM payment p
JOIN rental r USING(rental_id)
JOIN inventory i USING(inventory_id)
JOIN film f USING(film_id) 
JOIN film_category fc USING(film_id)
JOIN category c USING(category_id)
GROUP BY category_id 
ORDER BY gross_income DESC;

USE sakila;
#1. SELECT statements
#a.SELECT ALL COLUMNS FROM the actor table.
SELECT * FROM actor;
#b.SELECT only the last_name COLUMN FROM the actor table.
SELECT last_name FROM actor;
#3.SELECT only the following COLUMNS FROM the film table


#2.DISTINCT operator
#a.SELECT ALL DISTINCT (different) LAST NAMES FROM the actor table.
SELECT DISTINCT last_name FROM actor;
#b.SELECT ALL DISTINCT (different) postal codes FROM the address table.
SELECT DISTINCT postal_code FROM address;
#c.SELECT ALL DISTINCT (different) ratings FROM the film table.
SELECT DISTINCT rating FROM film;

#3. WHERE clause
#a.SELECT the title, description, rating, movie length COLUMNS FROM the films TABLE that LAST 3 hours OR longer.
SELECT title, description, rating, length 
FROM film 
WHERE length >= 180;

#b.SELECT the payment id, amount, AND payment DATE COLUMNS FROM the payments TABLE FOR payments made ON OR AFTER 05/27/2005.
SELECT payment_id, amount, payment_date 
FROM payment 
WHERE payment_date >= 2005-05-27;

#c.SELECT the PRIMARY KEY, amount, AND payment DATE COLUMNS FROM the payment TABLE FOR payments made ON 05/27/2005.
SELECT payment_id, amount, payment_date #Cant select Primary key#
FROM payment
WHERE payment_date >= 2005-05-27;

#d.SELECT ALL COLUMNS FROM the customer TABLE FOR ROWS that have a LAST NAMES beginning WITH S AND a FIRST NAMES ending WITH N.
SELECT * 
FROM customer 
WHERE last_name LIKE "S%" AND first_name LIKE "%N";

#e.SELECT ALL COLUMNS FROM the customer TABLE FOR ROWS WHERE the customer IS inactive OR has a LAST NAME beginning WITH "M".
SELECT * 
FROM customer
WHERE active = 0 OR last_name LIKE "M%";

#f.SELECT ALL COLUMNS FROM the category TABLE FOR ROWS WHERE the PRIMARY KEY IS greater THAN 4 AND the NAME field begins WITH either C, S OR T.
SELECT * 
FROM category 
WHERE  (category_id > 4) AND (name LIKE "C%") OR (name LIKE "S%") OR (name LIKE "%T");

#g.SELECT ALL COLUMNS minus the PASSWORD COLUMN FROM the staff TABLE FOR ROWS that contain a password.
CREATE TEMPORARY TABLE staff_t AS
SELECT * 
FROM sakila.staff
WHERE password IS NOT NULL;
ALTER TABLE staff_t DROP COLUMN password;
SELECT * FROM curie_956.staff_t;

#h.SELECT ALL COLUMNS minus the PASSWORD COLUMN FROM the staff TABLE FOR ROWS that DO NOT contain a password.

CREATE TEMPORARY TABLE staff_p AS
SELECT * 
FROM sakila.staff
WHERE password IS  NULL;
ALTER TABLE staff_p DROP COLUMN password;
SELECT * FROM curie_956.staff_t;

#4.IN operator
#a.Select the phone and district columns from the address table for addresses in California, England, Taipei, or West Java.
SELECT phone, address
FROM address
WHERE district IN ("California", "England", "Taipei", "West Java");

#b. Select the payment id, amount, and payment date columns from the payment table for payments made on 05/25/2005, 05/27/2005, and 05/29/2005. (Use the IN operator and the DATE function, instead of the AND operator as in previous exercises.)
SELECT payment_id, amount, payment_date
FROM payment
WHERE DATE(payment_date) IN ('2005-05-25', '2005-05-27', '2005-05-29');#date value has to be quoted.

#c.Select all columns from the film table for films rated G, PG-13 or NC-17.
SELECT * 
FROM film
WHERE rating IN ("G", "PG-13", "NC-17");

#5.BETWEEN operator
#a.Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.
SELECT *
FROM payment
WHERE payment_date BETWEEN "2005-05-25 00:00:00" AND "2005-05-25 23:59:59";

#b.Select the following columns from the film table for films where the length of the description is between 100 and 120.
SELECT rental_duration * rental_rate AS total_rental_cost, LENGTH(description)
FROM film
WHERE LENGTH(description) BETWEEN 100 AND 120;