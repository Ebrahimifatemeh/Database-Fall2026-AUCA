DROP SCHEMA IF EXISTS lab17 CASCADE;
CREATE SCHEMA lab17;
SET search_path TO lab17, public;

CREATE TABLE customers (
  customer_id integer PRIMARY KEY,
  customer_name text NOT NULL,
  email text UNIQUE NOT NULL,
  city text
);
CREATE TABLE staging_customers (LIKE customers INCLUDING ALL);
CREATE TABLE sales (
  sale_id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  customer_id integer REFERENCES customers(customer_id),
  amount numeric(10,2) NOT NULL CHECK (amount >= 0),
  sale_date date NOT NULL
);

INSERT INTO customers VALUES
 (1,'Alice Johnson','alice@example.com','Pittsburgh'),
 (2,'Bob Smith','bob@example.com','New York'),
 (3,'Diana Wilson','diana@example.com','Chicago');
INSERT INTO sales(customer_id,amount,sale_date) VALUES
 (1,150.00,'2026-10-01'),(2,220.50,'2026-10-02'),(1,75.25,'2026-10-03');

-- 1. Export data as CSV to the query output (no server file permissions required).
COPY (SELECT customer_id,customer_name,email,city
      FROM customers ORDER BY customer_id)
TO STDOUT WITH (FORMAT CSV, HEADER TRUE);

-- 2. Import inline CSV from STDIN is demonstrated in lab17_psql_commands.txt
-- (psql-specific). Here we use INSERT for a tool-independent staging demo.
INSERT INTO staging_customers VALUES
 (4,'Emma Green','emma@example.com','Boston'),
 (5,'Michael Lee','michael@example.com','Seattle');

-- 3. Validate staged rows before merging.
SELECT COUNT(*) AS staging_count FROM staging_customers;
SELECT * FROM staging_customers ORDER BY customer_id;

-- 4. ETL merge from staging to target.
INSERT INTO customers(customer_id,customer_name,email,city)
SELECT customer_id,customer_name,email,city FROM staging_customers
ON CONFLICT (customer_id) DO UPDATE
SET customer_name = EXCLUDED.customer_name,
    email = EXCLUDED.email,
    city = EXCLUDED.city;

-- 5. Check migrated rows and sales summaries.
SELECT COUNT(*) AS total_customers FROM customers;
SELECT * FROM customers ORDER BY customer_id;
SELECT c.customer_name, COALESCE(SUM(s.amount),0) AS total_sales
FROM customers c LEFT JOIN sales s ON s.customer_id = c.customer_id
GROUP BY c.customer_id,c.customer_name ORDER BY c.customer_id;

-- 6. Export only selected data (query results) to STDOUT.
COPY (SELECT customer_id,customer_name,city
      FROM customers WHERE city IS NOT NULL ORDER BY customer_id)
TO STDOUT WITH (FORMAT CSV, HEADER TRUE, DELIMITER ';');

-- 7. Data integrity checks useful before/after migrations.
SELECT COUNT(*) AS rows_in_source FROM staging_customers;
SELECT COUNT(*) AS matching_rows
FROM staging_customers s JOIN customers c USING (customer_id);
-- Backup, restoration, WAL, PITR and replication require external tools/server
-- configuration. See README.md; do not execute destructive recovery commands.
