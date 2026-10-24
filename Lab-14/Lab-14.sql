-- =====================================================
-- LAB 14: JOINING TABLES
-- Database Management Systems
-- PostgreSQL
-- =====================================================

-- Create a separate schema for Lab 14
DROP SCHEMA IF EXISTS lab14 CASCADE;
CREATE SCHEMA lab14;
SET search_path TO lab14;

-- =====================================================
-- PART 1: CREATE TABLES
-- =====================================================

-- Customers table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100)
);

-- Products table
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2)
);

-- Orders table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    order_date DATE,
    total_amount DECIMAL(10,2)
);

-- Order items table
CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(order_id),
    product_id INTEGER REFERENCES products(product_id),
    quantity INTEGER
);

-- Employees table
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    manager_id INTEGER REFERENCES employees(employee_id)
);

-- User profiles: One-to-one relationship
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(100)
);

CREATE TABLE user_profiles (
    profile_id SERIAL PRIMARY KEY,
    user_id INTEGER UNIQUE REFERENCES users(user_id),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    phone VARCHAR(20)
);

-- Students and courses: Many-to-many relationship
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100)
);

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100)
);

CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id),
    course_id INTEGER REFERENCES courses(course_id),
    enrollment_date DATE,
    grade VARCHAR(5)
);

-- =====================================================
-- PART 2: INSERT SAMPLE DATA
-- =====================================================

INSERT INTO customers (name, email) VALUES
('Alice Johnson', 'alice@example.com'),
('Bob Smith', 'bob@example.com'),
('Charlie Brown', 'charlie@example.com'),
('Diana Wilson', 'diana@example.com');

INSERT INTO products (product_name, price) VALUES
('Laptop', 900.00),
('Mouse', 25.00),
('Keyboard', 75.00),
('Monitor', 250.00);

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2026-01-10', 925.00),
(2, '2026-02-15', 250.00),
(1, '2026-03-20', 75.00);

-- An order without a customer to demonstrate outer joins
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (NULL, '2026-04-05', 100.00);

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 2, 1),
(2, 4, 1),
(3, 3, 1);

INSERT INTO employees (name, manager_id) VALUES
('Sarah Manager', NULL),
('John Developer', 1),
('Emma Designer', 1),
('Michael Analyst', 2);

INSERT INTO users (username) VALUES
('alice123'),
('bob456'),
('charlie789');

INSERT INTO user_profiles
(user_id, first_name, last_name, phone) VALUES
(1, 'Alice', 'Johnson', '123456789'),
(2, 'Bob', 'Smith', '987654321');

INSERT INTO students (student_name) VALUES
('Anna'),
('David'),
('Sophia');

INSERT INTO courses (course_name) VALUES
('Database Systems'),
('Software Engineering'),
('Computer Networks');

INSERT INTO enrollments
(student_id, course_id, enrollment_date, grade) VALUES
(1, 1, '2026-09-01', 'A'),
(1, 2, '2026-09-01', 'B'),
(2, 1, '2026-09-01', 'A'),
(3, 3, '2026-09-01', NULL);

-- =====================================================
-- PART 3: INNER JOIN
-- =====================================================

-- Retrieve customers who have placed orders

SELECT
    c.name,
    c.email,
    o.order_date,
    o.total_amount
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id;

-- =====================================================
-- PART 4: LEFT JOIN
-- =====================================================

-- Retrieve all customers, including those without orders

SELECT
    c.name,
    c.email,
    o.order_date,
    o.total_amount
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id;

-- =====================================================
-- PART 5: RIGHT JOIN
-- =====================================================

-- Retrieve all orders, including orders without customers

SELECT
    c.name,
    c.email,
    o.order_date,
    o.total_amount
FROM customers c
RIGHT JOIN orders o
    ON c.customer_id = o.customer_id;

-- =====================================================
-- PART 6: FULL OUTER JOIN
-- =====================================================

-- Retrieve all customers and all orders

SELECT
    c.name,
    c.email,
    o.order_date,
    o.total_amount
FROM customers c
FULL OUTER JOIN orders o
    ON c.customer_id = o.customer_id;

-- =====================================================
-- PART 7: CROSS JOIN
-- =====================================================

-- Generate every possible customer-product combination

SELECT
    c.name,
    p.product_name
FROM customers c
CROSS JOIN products p;

-- =====================================================
-- PART 8: MULTIPLE TABLE JOINS
-- =====================================================

-- Combine customers, orders, order items, and products

SELECT
    c.name AS customer_name,
    o.order_date,
    p.product_name,
    oi.quantity,
    p.price,
    oi.quantity * p.price AS item_total
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN products p
    ON oi.product_id = p.product_id;

-- =====================================================
-- PART 9: SELF JOIN
-- =====================================================

-- Display employees and their managers

SELECT
    e1.name AS employee,
    e2.name AS manager
FROM employees e1
LEFT JOIN employees e2
    ON e1.manager_id = e2.employee_id;

-- =====================================================
-- PART 10: JOIN WITH CONDITIONS
-- =====================================================

-- Find customer orders with a total amount greater than 100

SELECT
    c.name,
    o.order_date,
    o.total_amount
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.total_amount > 100;

-- =====================================================
-- PART 11: ONE-TO-ONE RELATIONSHIP
-- =====================================================

-- Retrieve users and their profiles

SELECT
    u.username,
    up.first_name,
    up.last_name,
    up.phone
FROM users u
LEFT JOIN user_profiles up
    ON u.user_id = up.user_id;

-- =====================================================
-- PART 12: ONE-TO-MANY RELATIONSHIP
-- =====================================================

-- One customer can have multiple orders

SELECT
    c.name,
    o.order_id,
    o.order_date,
    o.total_amount
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
ORDER BY c.name, o.order_date;

-- =====================================================
-- PART 13: MANY-TO-MANY RELATIONSHIP
-- =====================================================

-- Students and their enrolled courses

SELECT
    s.student_name,
    c.course_name,
    e.enrollment_date,
    e.grade
FROM students s
INNER JOIN enrollments e
    ON s.student_id = e.student_id
INNER JOIN courses c
    ON e.course_id = c.course_id
WHERE e.grade IS NOT NULL
ORDER BY s.student_name, c.course_name;

-- =====================================================
-- PART 14: FIND CUSTOMERS WITHOUT ORDERS
-- =====================================================

SELECT
    c.customer_id,
    c.name
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- =====================================================
-- PART 15: FIND ORDERS WITHOUT CUSTOMERS
-- =====================================================

SELECT
    o.order_id,
    o.order_date,
    o.total_amount
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- =====================================================
-- PART 16: CREATE INDEXES
-- =====================================================

-- Indexes can improve JOIN performance

CREATE INDEX idx_orders_customer_id
ON orders(customer_id);

CREATE INDEX idx_order_items_order_id
ON order_items(order_id);

CREATE INDEX idx_order_items_product_id
ON order_items(product_id);

CREATE INDEX idx_enrollments_student_id
ON enrollments(student_id);

CREATE INDEX idx_enrollments_course_id
ON enrollments(course_id);

-- =====================================================
-- PART 17: COUNT ORDERS PER CUSTOMER
-- =====================================================

SELECT
    c.name,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_orders DESC;

-- =====================================================
-- PART 18: TOTAL SPENDING PER CUSTOMER
-- =====================================================

SELECT
    c.name,
    COALESCE(SUM(o.total_amount), 0) AS total_spending
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spending DESC;
