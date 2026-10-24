# Lab 15 — Advanced Querying (PostgreSQL)

## Objective

The objective of this lab is to practice advanced SQL querying
techniques using PostgreSQL.

This lab focuses on writing complex queries, analyzing data,
working with hierarchical relationships, and improving query
performance.

## Topics Covered

1. Subqueries
2. Common Table Expressions (CTEs)
3. Recursive Queries
4. UNION and UNION ALL
5. INTERSECT and EXCEPT
6. Window Functions
7. ROW_NUMBER(), RANK(), and DENSE_RANK()
8. LAG() and LEAD()
9. Pivot Operations
10. Unpivot Operations
11. FILTER Clause
12. Custom Sorting with CASE
13. Query Optimization
14. EXPLAIN and EXPLAIN ANALYZE
15. Indexes and LIMIT

## Files

- `lab15.sql` — Contains sample tables, data, and SQL queries
  demonstrating advanced querying techniques.

## Database Structure

The lab uses five tables:

- employees
- orders
- warehouse_1
- warehouse_2
- sales

These tables contain sample data for practicing advanced SQL
operations.

## SQL Concepts

### 1. Subqueries

A subquery is a query nested inside another SQL statement.

Subqueries can be used to filter records based on the results
of another query.

### 2. Common Table Expressions (CTEs)

CTEs use the WITH clause to create temporary named result sets.

They improve the readability and organization of complex queries.

### 3. Recursive Queries

Recursive CTEs are useful for working with hierarchical data.

In this lab, a recursive query is used to display the
employee-manager hierarchy.

### 4. Set Operations

UNION combines results and removes duplicates.

UNION ALL combines results while keeping duplicates.

INTERSECT returns records found in both result sets.

EXCEPT returns records from the first query that do not
appear in the second query.

### 5. Window Functions

Window functions perform calculations across related rows
without combining them into a single result.

This lab demonstrates:

- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- LAG()
- LEAD()

### 6. Pivot Operations

Pivoting converts row values into columns.

In PostgreSQL, conditional aggregation using CASE and SUM()
can be used to perform pivot operations.

### 7. Unpivot Operations

Unpivoting converts columns into rows.

This lab demonstrates unpivoting using UNION ALL.

### 8. FILTER Clause

The FILTER clause applies conditions to aggregate calculations.

It allows aggregate functions to operate on selected subsets
of data.

### 9. Custom Sorting

CASE expressions can be used with ORDER BY to create
custom sorting rules.

### 10. Query Optimization

Query optimization improves database query efficiency.

The lab demonstrates:

- Creating indexes
- Using EXPLAIN
- Using EXPLAIN ANALYZE
- Selecting specific columns
- Using LIMIT

## How to Run

1. Open PostgreSQL using pgAdmin or psql.
2. Connect to a practice database.
3. Open the `lab15.sql` file.
4. Execute the SQL statements.
5. Review the results of each query.

### Using psql

    psql -d your_practice_database -f lab15.sql

## Learning Outcomes

Through this lab, I practiced:

- Writing SQL subqueries.
- Using CTEs to organize complex queries.
- Creating recursive queries for hierarchical data.
- Combining query results using set operations.
- Applying window functions for ranking and comparison.
- Transforming data using pivot and unpivot techniques.
- Filtering aggregate results.
- Implementing custom sorting.
- Creating indexes.
- Analyzing query performance using EXPLAIN.
- Improving SQL query readability and efficiency.

## Conclusion

In this lab, I learned how advanced SQL querying techniques
can be used to solve complex database problems.

I practiced subqueries, CTEs, recursive queries, set operations,
window functions, and data transformation techniques.

I also explored query optimization methods, including indexes,
EXPLAIN, and EXPLAIN ANALYZE.
