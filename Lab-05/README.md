# Lab 05 – Databases

## Objective


The objective of this lab is to practice creating and managing databases in PostgreSQL. The lab also demonstrates how to create tables, insert records, retrieve data, and switch between databases using the PostgreSQL command-line interface (psql).

Tasks Completed
1. Database Creation

Created a database named fatemeh_university using the CREATE DATABASE command.

2. Database Connection

Connected to the database using:

\c fatemeh_university
3. Table Creation

Created two tables:

Departments Table

department_id – Primary key
department_name – Department name

Students Table

student_id – Primary key
first_name – Student's first name
last_name – Student's last name
email – Unique email address
department_id – Foreign key referencing the departments table
4. Data Insertion

Inserted one department:

Software Engineering

Inserted two sample student records:

Fatemeh Ebrahimi
Amina Ahmadi
5. Data Retrieval

Used the following SQL query to retrieve student records:

SELECT * FROM students;
6. Switching Databases

Switched back to the default PostgreSQL database using:

\c postgres
Expected Results

The students table should display the following records when the SQL commands are executed successfully in a fresh database:

student_id	first_name	last_name	email	department_id
1	Fatemeh	Ebrahimi	fatemeh@example.com	1
2	Amina	Ahmadi	amina@example.com	1
Conclusion

In this lab, I practiced basic database management operations using PostgreSQL. I learned how to create a database, establish relationships between tables using primary and foreign keys, insert student records, and retrieve information using SQL queries. I also practiced switching between databases through the PostgreSQL terminal.
