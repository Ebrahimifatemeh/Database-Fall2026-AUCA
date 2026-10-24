-- PART 1: CREATE SCHEMA

DROP SCHEMA IF EXISTS lab15 CASCADE;
CREATE SCHEMA lab15;
SET search_path TO lab15;

-- =====================================================
-- PART 2: CREATE TABLES
-- =====================================================

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    manager_id INTEGER REFERENCES employees(employee_id),
    tenure INTEGER
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    region_id INTEGER,
    amount DECIMAL(10,2),
    status VARCHAR(50)
);

CREATE TABLE warehouse_1 (
    product_id INTEGER,
    product_name VARCHAR(100),
    quantity INTEGER
);

CREATE TABLE warehouse_2 (
    product_id INTEGER,
    product_name VARCHAR(100),
    quantity INTEGER
);

CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    year INTEGER,
    sales_amount DECIMAL(10,2)
);

-- =====================================================
-- PART 3: INSERT SAMPLE DATA
-- =====================================================

INSERT INTO employees
(first_name, last_name, department, salary, manager_id, tenure)
VALUES
('Sarah', 'Johnson', 'Management', 95000, NULL, 10);

INSERT INTO employees
(first_name, last_name, department, salary, manager_id, tenure)
VALUES
('John', 'Smith', 'IT', 75000, 1, 6),
('Emma', 'Wilson', 'IT', 82000, 1, 7),
('David', 'Brown', 'HR', 60000, 1, 4),
('Sophia', 'Davis', 'HR', 65000, 1, 5),
('Michael', 'Taylor', 'Sales', 55000, 1, 3),
('Olivia', 'Martin', 'Sales', 58000, 1, 6),
('Daniel', 'White', 'IT', 70000, 2, 2);

INSERT INTO orders (region_id, amount, status)
VALUES
(1, 150000, 'High Priority'),
(1, 250000, 'Medium Priority'),
(2, 300000, 'High Priority'),
(2, 180000, 'Low Priority'),
(3, 120000, 'Medium Priority'),
(3, 200000, 'Low Priority');

INSERT INTO warehouse_1
(product_id, product_name, quantity)
VALUES
(1, 'Laptop', 10),
(2, 'Mouse', 0),
(3, 'Keyboard', 15),
(4, 'Monitor', 0);

INSERT INTO warehouse_2
(product_id, product_name, quantity)
VALUES
(1, 'Laptop', 5),
(2, 'Mouse', 0),
(4, 'Monitor', 0),
(5, 'Printer', 8);

INSERT INTO sales
(product_name, year, sales_amount)
VALUES
('Laptop', 2022, 20000),
('Laptop', 2023, 25000),
('Laptop', 2024, 30000),
('Mouse', 2022, 5000),
('Mouse', 2023, 7000),
('Mouse', 2024, 9000),
('Keyboard', 2022, 8000),
('Keyboard', 2023, 10000),
('Keyboard', 2024, 12000);

-- =====================================================
-- PART 4: SCALAR SUBQUERY
-- =====================================================

-- Find employees earning more than the company average

SELECT
    first_name,
    last_name,
    salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

-- =====================================================
-- PART 5: SUBQUERY WITH IN
-- =====================================================

-- Find employees working in departments
-- that have salaries above 80000

SELECT
    first_name,
    last_name,
    department
FROM employees
WHERE department IN (
    SELECT DISTINCT department
    FROM employees
    WHERE salary > 80000
);

-- =====================================================
-- PART 6: SUBQUERY WITH EXISTS
-- =====================================================

-- Find employees who manage at least one employee

SELECT
    e.employee_id,
    e.first_name,
    e.last_name
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM employees sub
    WHERE sub.manager_id = e.employee_id
);

-- =====================================================
-- PART 7: COMMON TABLE EXPRESSIONS (CTEs)
-- =====================================================

-- Calculate total sales for each region

WITH regional_sales AS (
    SELECT
        region_id,
        SUM(amount) AS total_sales
    FROM orders
    GROUP BY region_id
)
SELECT
    region_id,
    total_sales
FROM regional_sales
WHERE total_sales > 300000;

-- =====================================================
-- PART 8: RECURSIVE CTE
-- =====================================================

-- Display the employee hierarchy

WITH RECURSIVE org_chart AS (

    -- Anchor: Employees without managers
    SELECT
        employee_id,
        first_name,
        last_name,
        manager_id,
        1 AS hierarchy_level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    -- Recursive: Find employees reporting to managers
    SELECT
        e.employee_id,
        e.first_name,
        e.last_name,
        e.manager_id,
        oc.hierarchy_level + 1
    FROM employees e
    INNER JOIN org_chart oc
        ON e.manager_id = oc.employee_id
)
SELECT *
FROM org_chart
ORDER BY hierarchy_level, employee_id;

-- =====================================================
-- PART 9: UNION
-- =====================================================

-- Retrieve unique products from both warehouses

SELECT product_name
FROM warehouse_1

UNION

SELECT product_name
FROM warehouse_2;

-- =====================================================
-- PART 10: UNION ALL
-- =====================================================

-- Retrieve all products including duplicates

SELECT product_name
FROM warehouse_1

UNION ALL

SELECT product_name
FROM warehouse_2;

-- =====================================================
-- PART 11: INTERSECT
-- =====================================================

-- Find products out of stock in both warehouses

SELECT product_id
FROM warehouse_1
WHERE quantity = 0

INTERSECT

SELECT product_id
FROM warehouse_2
WHERE quantity = 0;

-- =====================================================
-- PART 12: EXCEPT
-- =====================================================

-- Find products available only in warehouse 1

SELECT product_name
FROM warehouse_1

EXCEPT

SELECT product_name
FROM warehouse_2;

-- =====================================================
-- PART 13: WINDOW FUNCTIONS
-- =====================================================

-- Rank employees by salary within each department

SELECT
    first_name,
    last_name,
    department,
    salary,
    RANK() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS department_salary_rank
FROM employees;

-- =====================================================
-- PART 14: ROW_NUMBER()
-- =====================================================

-- Assign row numbers within each department

SELECT
    first_name,
    last_name,
    department,
    salary,
    ROW_NUMBER() OVER (
        PARTITION BY department
        ORDER BY salary DESC, employee_id
    ) AS row_number
FROM employees;

-- =====================================================
-- PART 15: DENSE_RANK()
-- =====================================================

-- Rank salaries without gaps

SELECT
    first_name,
    last_name,
    department,
    salary,
    DENSE_RANK() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS dense_salary_rank
FROM employees;

-- =====================================================
-- PART 16: LAG() AND LEAD()
-- =====================================================

-- Compare salaries with previous and next employees

SELECT
    first_name,
    last_name,
    department,
    salary,
    LAG(salary) OVER (
        PARTITION BY department
        ORDER BY salary
    ) AS previous_salary,
    LEAD(salary) OVER (
        PARTITION BY department
        ORDER BY salary
    ) AS next_salary
FROM employees;

-- =====================================================
-- PART 17: PIVOT USING CONDITIONAL AGGREGATION
-- =====================================================

-- Convert yearly sales rows into columns

SELECT
    product_name,
    SUM(
        CASE WHEN year = 2022
        THEN sales_amount ELSE 0 END
    ) AS year_2022,
    SUM(
        CASE WHEN year = 2023
        THEN sales_amount ELSE 0 END
    ) AS year_2023,
    SUM(
        CASE WHEN year = 2024
        THEN sales_amount ELSE 0 END
    ) AS year_2024
FROM sales
GROUP BY product_name
ORDER BY product_name;

-- =====================================================
-- PART 18: UNPIVOT USING UNION ALL
-- =====================================================

-- Convert yearly sales columns back into rows

WITH pivoted_sales AS (
    SELECT
        product_name,
        SUM(CASE WHEN year = 2022
            THEN sales_amount ELSE 0 END) AS year_2022,
        SUM(CASE WHEN year = 2023
            THEN sales_amount ELSE 0 END) AS year_2023,
        SUM(CASE WHEN year = 2024
            THEN sales_amount ELSE 0 END) AS year_2024
    FROM sales
    GROUP BY product_name
)

SELECT
    product_name,
    2022 AS year,
    year_2022 AS sales_amount
FROM pivoted_sales

UNION ALL

SELECT
    product_name,
    2023 AS year,
    year_2023 AS sales_amount
FROM pivoted_sales

UNION ALL

SELECT
    product_name,
    2024 AS year,
    year_2024 AS sales_amount
FROM pivoted_sales

ORDER BY product_name, year;

-- =====================================================
-- PART 19: FILTER CLAUSE
-- =====================================================

-- Calculate department salary totals
-- and average salary of senior employees

SELECT
    employee_id,
    first_name,
    department,
    salary,
    SUM(salary) OVER (
        PARTITION BY department
    ) AS total_department_salary,

    AVG(salary) FILTER (
        WHERE tenure > 5
    ) OVER () AS average_senior_salary

FROM employees;

-- =====================================================
-- PART 20: CUSTOM SORTING WITH CASE
-- =====================================================

-- Sort orders by priority

SELECT
    order_id,
    region_id,
    amount,
    status
FROM orders
ORDER BY
    CASE status
        WHEN 'High Priority' THEN 1
        WHEN 'Medium Priority' THEN 2
        WHEN 'Low Priority' THEN 3
        ELSE 4
    END;

-- =====================================================
-- PART 21: QUERY OPTIMIZATION
-- =====================================================

-- Create indexes

CREATE INDEX idx_employees_department
ON employees(department);

CREATE INDEX idx_employees_manager_id
ON employees(manager_id);

CREATE INDEX idx_orders_region_id
ON orders(region_id);

CREATE INDEX idx_sales_product_year
ON sales(product_name, year);

-- =====================================================
-- PART 22: EXPLAIN
-- =====================================================

-- Display the query execution plan

EXPLAIN
SELECT
    first_name,
    last_name,
    salary
FROM employees
WHERE department = 'IT';

-- =====================================================
-- PART 23: EXPLAIN ANALYZE
-- =====================================================

-- Execute the query and analyze its performance

EXPLAIN ANALYZE
SELECT
    first_name,
    last_name,
    salary
FROM employees
WHERE salary > 60000;

-- =====================================================
-- PART 24: LIMIT
-- =====================================================

-- Retrieve a limited number of records

SELECT
    employee_id,
    first_name,
    last_name,
    department,
    salary
FROM employees
ORDER BY salary DESC
LIMIT 5;
