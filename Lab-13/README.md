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
Important Concepts
COUNT()

Counts records in a table.

COUNT(*) counts all rows.
COUNT(column) counts non-NULL values.
COUNT(DISTINCT column) counts unique non-NULL values.
SUM()

Calculates the total of numeric values.

AVG()

Calculates the average of numeric values.

MIN() and MAX()

Find the smallest and largest values.

GROUP BY

Groups rows that share common values, allowing aggregate calculations for each group.

HAVING

Filters grouped results after aggregation.

Unlike HAVING, WHERE filters individual rows before grouping.

STRING_AGG()

Combines multiple text values into a single string.

ARRAY_AGG()

Collects multiple values into an array.

Statistical Functions

STDDEV(), VARIANCE(), and CORR() help analyze statistical relationships in data.

Window Functions

Window functions calculate values across related rows without collapsing individual records.

Important Notes
The SQL script uses a separate lab13 schema.
Re-running the script recreates five sample tables.
The script should be executed in a practice database.
The product review example uses a minimum of two reviews to demonstrate HAVING with the sample dataset.
Learning Outcomes

Through this lab, I practiced:

Using aggregate functions to summarize data.
Counting and analyzing records.
Calculating totals, averages, minimums, and maximums.
Grouping records using GROUP BY.
Filtering grouped results using HAVING.
Working with NULL values.
Applying statistical aggregate functions.
Comparing aggregate functions with window functions.
Performing conditional aggregation and percentage calculations.
Conclusion

This lab helped me understand how aggregate functions are used in PostgreSQL to analyze and summarize data. I learned how to combine aggregate functions with GROUP BY and HAVING to generate meaningful results from database tables.
