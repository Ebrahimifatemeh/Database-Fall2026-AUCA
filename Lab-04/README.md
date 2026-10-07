# Lab 04 – First SQL Query

## Objective

The purpose of this lab is to practice basic SQL queries in PostgreSQL.

## Topics Covered

- SELECT statements
- Selecting specific columns
- WHERE clause
- ORDER BY
- LIMIT
- SQL comments

## Example Queries

```sql
SELECT * FROM students;

SELECT name, email
FROM students;

SELECT name, email
FROM students
WHERE name = 'Timur';

SELECT name, email
FROM students
ORDER BY name;

SELECT name, email
FROM students
LIMIT 2;
