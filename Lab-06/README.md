# Lab 06 – Tables, Data Types and Constraints

## Objective

The purpose of this lab is to practice creating and modifying tables in PostgreSQL and to understand common data types and constraints.

## Topics Covered

- CREATE TABLE
- Data types
- PRIMARY KEY
- NOT NULL
- UNIQUE
- ALTER TABLE
- Adding and dropping columns
- Changing column data types
- Renaming columns and tables
- DROP TABLE

## Table Creation

```sql
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    faculty VARCHAR(100)
);
