Lab 12 — Querying Data (PostgreSQL)

Objective

Practice retrieving and filtering data with PostgreSQL queries. This lab follows the course document 12) Querying Data.

Topics covered

SELECT — retrieve all or selected columns.

Calculated columns and AS aliases.

WHERE — filter with comparisons, AND, and BETWEEN.

LIKE and ILIKE — match text patterns.

Regular expressions — use ~ and ~*.

IN — check membership in a list or subquery.

EXISTS — test whether matching records exist.

CASE — return conditional labels.

Common Table Expressions (WITH) — organize multi-step queries.

Files

lab12.sql — runnable setup data and SQL examples for each topic.

How to run

Open PostgreSQL using psql or pgAdmin Query Tool.

Create or select a practice database (for example, database_labs).

Open and execute lab12.sql in that database.

In psql, use \i /full/path/to/lab12.sql.

In pgAdmin, open the file in Query Tool and click Execute.

Inspect the result sets produced by each SELECT query.

Important: The script drops and recreates tables named employees, sales, customers, products, and users. Run it only in a practice database.

Example queries

Find engineering employees with salaries above 75,000:

SELECT name
FROM employees
WHERE salary > 75000 AND department = 'Engineering';

Find employees who have a sale above 1,000:

SELECT name
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM sales s
    WHERE s.employee_id = e.id AND s.amount > 1000
);

Learning outcome

I practiced SQL queries for selecting columns, filtering rows, matching text, checking subqueries, creating conditional results, and using CTEs to compare salaries with department averages.
