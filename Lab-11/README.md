# Lab 11: Basic Data Operations

## 1. Objective

The objective of this lab is to understand how to
manipulate data in PostgreSQL using basic SQL
operations.

This lab focuses on inserting, updating, and deleting
records, as well as performing bulk data operations.

## 2. Introduction

Data manipulation is an essential part of working
with relational databases.

PostgreSQL provides SQL commands that allow users
to add new records, modify existing information,
and remove unnecessary data.

The main commands covered in this lab are:

- INSERT INTO
- UPDATE
- DELETE
- SELECT
- COPY

## 3. Creating the Students Table

A students table is created with the following columns:

- student_id: Unique student identifier.
- first_name: Student's first name.
- last_name: Student's last name.
- birth_date: Student's date of birth.

The student_id column uses SERIAL PRIMARY KEY
to automatically generate unique identifiers.

A separate schema named lab11 is used to avoid
conflicts with previous database labs.

## 4. Lab Exercises

### Exercise 1: Insert a Single Record

The INSERT INTO statement is used to add a new
student to the database.

Example:

INSERT INTO lab11.students
(first_name, last_name, birth_date)
VALUES
('Aibek', 'Sharshenov', '2002-05-12');

### Exercise 2: Insert Multiple Records

Multiple records can be inserted using one
INSERT INTO statement.

This method is useful when adding several
students at once.

### Exercise 3: Update a Record

The UPDATE statement modifies existing data.

In this exercise, a student's birth date is updated
using a WHERE condition.

### Exercise 4: Delete a Record

The DELETE statement removes a specific record.

The WHERE clause identifies which student
should be deleted.

### Exercise 5: Delete Using Conditions

Records are deleted based on a date condition.

This demonstrates how multiple records can
be removed when they meet specific criteria.

### Exercise 6: Bulk Insert

Several student records are inserted using
a single SQL statement.

### Exercise 7: Import Data Using COPY

The COPY command allows data to be imported
from CSV files.

This exercise includes an example of importing
student information from a CSV file.

The COPY command is commented out because
it requires a valid file path and an accessible
CSV file.

### Exercise 8: Bulk Update

The UPDATE statement modifies multiple records
that meet a specified condition.

The IN operator is used to select several values.

### Exercise 9: Bulk Delete

The DELETE statement removes multiple records
based on their student IDs.

### Exercise 10: View Final Results

The SELECT statement displays the remaining
student records after the data operations.

## 5. SQL Commands Used

- CREATE SCHEMA
- CREATE TABLE
- SERIAL
- PRIMARY KEY
- INSERT INTO
- VALUES
- UPDATE
- SET
- WHERE
- DELETE
- SELECT
- ORDER BY
- IN
- COPY

## 6. Files

The Lab11 folder contains:

- lab11_basic_data_operations.sql
  SQL code for basic data operations.

- README.md
  Documentation explaining the lab.

## 7. How to Run

1. Open pgAdmin.
2. Connect to the PostgreSQL server.
3. Select your practice database.
4. Open the Query Tool.
5. Copy or open the SQL file.
6. Execute the SQL commands.
7. Review the results using SELECT queries.

Note: Run the script once to avoid inserting
duplicate sample records.

## 8. Learning Outcomes

By completing this lab, I aim to:

- Understand basic data manipulation commands.
- Insert single and multiple records.
- Update existing database records.
- Delete records using conditions.
- Perform bulk data operations.
- Understand CSV imports using COPY.
- Use SELECT to examine database records.

## 9. Conclusion

Lab 11 demonstrates how PostgreSQL can be used
to manage data inside relational database tables.

The exercises cover inserting, updating, and
deleting records, as well as performing bulk
operations.

These concepts are essential for maintaining
accurate and organized information in databases.

## 10. Reference

Database Lab 11: Basic Data Operations.
Course material provided by Professor Esenalieva.
