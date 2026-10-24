# Lab 13 — Aggregate Functions (PostgreSQL)

## Objective
Practice summarizing and analyzing data using PostgreSQL aggregate functions, grouped queries, and related techniques.

This lab is based on the course material "13) Aggregate Functions."

## Topics Covered

1. COUNT(*), COUNT(column), and COUNT(DISTINCT column)
2. SUM(), AVG(), MIN(), and MAX()
3. STRING_AGG() and ARRAY_AGG()
4. STDDEV(), VARIANCE(), and CORR()
5. GROUP BY with multiple columns and CASE expressions
6. HAVING versus WHERE
7. Aggregate functions versus window functions
8. Handling NULL values
9. Combined and conditional aggregations
10. Percentage calculations

## Files

- `lab13.sql` — Contains sample tables, sample data, and 16 groups of SQL queries demonstrating aggregate functions.

## How to Run

1. Open PostgreSQL using pgAdmin or psql.
2. Connect to a practice database.
3. Open the `lab13.sql` file.
4. Execute the SQL statements.
5. Review the results of each query.

### Using the Command Line

```bash
psql -d your_practice_database -f lab13.sql
