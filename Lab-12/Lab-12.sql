DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(80) NOT NULL,
    department VARCHAR(50) NOT NULL,
    department_id INTEGER NOT NULL,
    salary NUMERIC(10,2) NOT NULL
);

CREATE TABLE sales (
    id SERIAL PRIMARY KEY,
    employee_id INTEGER NOT NULL REFERENCES employees(id),
    amount NUMERIC(10,2) NOT NULL
);

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    customer_name VARCHAR(80) NOT NULL
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(80) NOT NULL,
    price NUMERIC(10,2) NOT NULL
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(120) NOT NULL
);

INSERT INTO employees (name, department, department_id, salary) VALUES
('Alice', 'Engineering', 3, 110000),
('Brandon', 'Sales', 5, 68000),
('Amira', 'Engineering', 3, 82000),
('Carlos', 'HR', 7, 55000),
('Bella', 'Sales', 5, 76000),
('David', 'Engineering', 3, 95000);

INSERT INTO sales (employee_id, amount) VALUES
(2, 1500), (2, 800), (5, 2200), (1, 300);

INSERT INTO customers (customer_name) VALUES
('Brad'), ('Brandon'), ('Cynthia'), ('Briana');

INSERT INTO products (product_name, price) VALUES
('Strawberry', 12), ('Blueberry', 25), ('Keyboard', 45), ('Monitor', 160);

INSERT INTO users (email) VALUES
('Alice@Gmail.com'), ('brandon@gmail.com'), ('amira@example.org');

-- 1. SELECT: all columns and selected columns
SELECT * FROM employees;
SELECT name, department FROM employees;

-- 2. SELECT with calculated column and alias
SELECT name, salary, salary * 0.10 AS potential_bonus
FROM employees;

-- 3. WHERE: filtering and logical operators
SELECT name, salary FROM employees WHERE department = 'Sales';
SELECT name FROM employees
WHERE salary > 75000 AND department = 'Engineering';
SELECT product_name, price FROM products WHERE price BETWEEN 20 AND 50;

-- 4. LIKE and ILIKE: pattern matching
SELECT customer_name FROM customers WHERE customer_name LIKE 'Bra%';
SELECT product_name FROM products WHERE product_name LIKE '%berry';
SELECT email FROM users WHERE email ILIKE '%@gmail.com';

-- 5. Regular expressions (~ and ~*)
SELECT name FROM employees WHERE name ~ '^[AB]';
SELECT email FROM users
WHERE email ~* '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$';

-- 6. IN: membership in a list and subquery
SELECT name, department FROM employees WHERE department_id IN (3, 5, 7);
SELECT name FROM employees
WHERE id IN (SELECT employee_id FROM sales WHERE amount > 1000);

-- 7. EXISTS: correlated subquery
SELECT name FROM employees e
WHERE EXISTS (
    SELECT 1 FROM sales s
    WHERE s.employee_id = e.id AND s.amount > 1000
);

-- 8. CASE: conditional output
SELECT name, salary,
    CASE
        WHEN salary > 100000 THEN 'Senior'
        WHEN salary BETWEEN 60000 AND 100000 THEN 'Mid-Level'
        ELSE 'Junior'
    END AS employee_level
FROM employees;

-- 9. CTE: employees earning more than their department average
WITH department_averages AS (
    SELECT department, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department
)
SELECT e.name, e.salary, e.department, da.avg_salary
FROM employees e
JOIN department_averages da ON e.department = da.department
WHERE e.salary > da.avg_salary;
