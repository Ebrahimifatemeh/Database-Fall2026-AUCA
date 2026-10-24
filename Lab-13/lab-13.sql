-- Lab 13: Aggregate Functions (PostgreSQL)
-- Run in a practice database. All objects are isolated in a lab-specific schema.
CREATE SCHEMA IF NOT EXISTS lab13;
SET search_path TO lab13;

DROP TABLE IF EXISTS product_reviews, sales, employee_skills, products, employees CASCADE;

CREATE TABLE employees (
 employee_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 first_name TEXT NOT NULL,
 last_name TEXT NOT NULL,
 department TEXT NOT NULL,
 age INTEGER NOT NULL,
 salary NUMERIC(12,2) NOT NULL,
 email TEXT,
 bonus NUMERIC(10,2),
 experience_years INTEGER NOT NULL,
 hire_date DATE NOT NULL
);
INSERT INTO employees (first_name,last_name,department,age,salary,email,bonus,experience_years,hire_date) VALUES
('Amina','Ali','Engineering',27,78000,'amina@example.com',2500,4,'2024-03-01'),
('Omar','Khan','Engineering',35,92000,'omar@example.com',NULL,9,'2021-06-15'),
('Lina','Said','Engineering',41,108000,NULL,4000,15,'2018-09-10'),
('Sara','Noor','Sales',25,52000,'sara@example.com',1000,2,'2025-01-20'),
('David','Lee','Sales',32,64000,'david@example.com',NULL,7,'2022-11-08'),
('Maya','Chen','Sales',38,71000,'maya@example.com',1500,11,'2020-02-12'),
('Nora','Aziz','HR',29,59000,NULL,NULL,5,'2023-07-17'),
('Alex','Brown','HR',46,83000,'alex@example.com',2000,20,'2017-04-04');

CREATE TABLE products (
 product_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 product_name TEXT NOT NULL,
 category TEXT NOT NULL,
 price NUMERIC(10,2) NOT NULL
);
INSERT INTO products (product_name,category,price) VALUES
('Laptop','Electronics',900),('Mouse','Electronics',25),('Desk','Furniture',240),('Chair','Furniture',150),('Notebook','Stationery',6);

CREATE TABLE sales (
 sale_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 sale_date DATE NOT NULL,
 amount NUMERIC(10,2) NOT NULL
);
INSERT INTO sales (sale_date,amount) VALUES
('2025-01-15',150),('2025-03-10',225),('2025-06-02',300),('2025-10-18',450),('2026-02-11',175),('2026-08-09',525);

CREATE TABLE employee_skills (
 employee_id INTEGER NOT NULL REFERENCES employees(employee_id),
 skill_name TEXT NOT NULL
);
INSERT INTO employee_skills VALUES (1,'PostgreSQL'),(1,'Python'),(2,'Java'),(2,'SQL'),(4,'Negotiation'),(4,'CRM');

CREATE TABLE product_reviews (
 review_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 product_id INTEGER NOT NULL REFERENCES products(product_id),
 rating NUMERIC(2,1) NOT NULL CHECK (rating BETWEEN 1 AND 5)
);
INSERT INTO product_reviews (product_id,rating) VALUES
(1,4.5),(1,4.8),(1,4.7),(2,3.9),(2,4.1),(3,4.9),(3,4.6);

-- 1. COUNT: all rows, non-NULL values, distinct groups
SELECT COUNT(*) AS total_employees, COUNT(email) AS employees_with_email,
       COUNT(DISTINCT department) AS unique_departments FROM employees;

-- 2. SUM: total salary expenditure
SELECT SUM(salary) AS total_salaries FROM employees;

-- 3. AVG: average salary by department
SELECT department, ROUND(AVG(salary),2) AS average_salary
FROM employees GROUP BY department ORDER BY department;

-- 4. MIN and MAX: salary range
SELECT MIN(salary) AS lowest_salary, MAX(salary) AS highest_salary FROM employees;

-- 5. STRING_AGG: ordered employee names by department
SELECT department, STRING_AGG(first_name || ' ' || last_name, ', ' ORDER BY last_name) AS employee_names
FROM employees GROUP BY department ORDER BY department;

-- 6. STRING_AGG: skills by employee
SELECT employee_id, STRING_AGG(skill_name, ', ' ORDER BY skill_name) AS skills
FROM employee_skills GROUP BY employee_id ORDER BY employee_id;

-- 7. ARRAY_AGG: ordered salaries by department
SELECT department, ARRAY_AGG(salary ORDER BY salary) AS salary_array
FROM employees GROUP BY department ORDER BY department;

-- 8. Statistical aggregates: standard deviation, variance, correlation
SELECT department, ROUND(STDDEV(salary),2) AS salary_std_dev,
       ROUND(VARIANCE(salary),2) AS salary_variance
FROM employees GROUP BY department ORDER BY department;
SELECT CORR(experience_years, salary) AS experience_salary_correlation FROM employees;

-- 9. GROUP BY: product category summary
SELECT category, COUNT(*) AS number_of_products, SUM(price) AS total_value,
       ROUND(AVG(price),2) AS average_price
FROM products GROUP BY category ORDER BY category;

-- 10. GROUP BY multiple expressions: sales by year and quarter
SELECT EXTRACT(YEAR FROM sale_date)::INTEGER AS year,
       EXTRACT(QUARTER FROM sale_date)::INTEGER AS quarter,
       COUNT(*) AS total_sales, SUM(amount) AS total_revenue
FROM sales GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(QUARTER FROM sale_date)
ORDER BY year, quarter;

-- 11. GROUP BY a CASE expression: age categories
SELECT CASE WHEN age < 30 THEN 'Under 30'
            WHEN age BETWEEN 30 AND 50 THEN '30-50'
            ELSE 'Over 50' END AS age_group,
       COUNT(*) AS employee_count, ROUND(AVG(salary),2) AS avg_salary
FROM employees
GROUP BY CASE WHEN age < 30 THEN 'Under 30'
              WHEN age BETWEEN 30 AND 50 THEN '30-50'
              ELSE 'Over 50' END
ORDER BY age_group;

-- 12. HAVING: filter grouped results
SELECT department, COUNT(*) AS employee_count
FROM employees GROUP BY department HAVING COUNT(*) >= 3 ORDER BY department;
SELECT product_id, ROUND(AVG(rating),2) AS avg_rating, COUNT(*) AS review_count
FROM product_reviews GROUP BY product_id
HAVING AVG(rating) > 4.0 AND COUNT(*) >= 2 ORDER BY product_id;

-- 13. Aggregates vs. window functions
SELECT department, ROUND(AVG(salary),2) AS dept_avg_salary
FROM employees GROUP BY department ORDER BY department;
SELECT employee_id, first_name, department, salary,
       ROUND(AVG(salary) OVER (PARTITION BY department),2) AS dept_avg_salary
FROM employees ORDER BY department, employee_id;

-- 14. NULL handling
SELECT COUNT(*) AS total_rows, COUNT(email) AS non_null_emails,
       COUNT(*) - COUNT(email) AS null_emails,
       SUM(bonus) AS total_bonus, ROUND(AVG(bonus),2) AS avg_bonus,
       COUNT(bonus) AS employees_with_bonus
FROM employees;

-- 15. Combined aggregation and conditional aggregation
SELECT department, COUNT(*) AS employee_count,
       MIN(salary) AS min_salary, MAX(salary) AS max_salary,
       ROUND(AVG(salary),2) AS avg_salary,
       COUNT(CASE WHEN salary > 70000 THEN 1 END) AS high_earners,
       COUNT(CASE WHEN hire_date > DATE '2023-01-01' THEN 1 END) AS recent_hires
FROM employees GROUP BY department ORDER BY avg_salary DESC;

-- 16. Percentage of all employees in each department
SELECT department, COUNT(*) AS dept_count,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM employees),2) AS percentage
FROM employees GROUP BY department ORDER BY percentage DESC;
