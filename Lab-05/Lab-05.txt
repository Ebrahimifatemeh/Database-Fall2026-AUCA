postgres=# \encoding UTF8
postgres=# CREATE DATABASE fatemeh_university;
CREATE DATABASE

postgres=# \c fatemeh_university
You are now connected to database "fatemeh_university" as user "postgres".

fatemeh_university=# CREATE TABLE departments (
fatemeh_university(# department_id SERIAL PRIMARY KEY,
fatemeh_university(# department_name VARCHAR(100)
fatemeh_university(# );
CREATE TABLE

fatemeh_university=# CREATE TABLE students (
fatemeh_university(# student_id SERIAL PRIMARY KEY,
fatemeh_university(# first_name VARCHAR(50),
fatemeh_university(# last_name VARCHAR(50),
fatemeh_university(# email VARCHAR(100) UNIQUE,
fatemeh_university(# department_id INT REFERENCES departments(department_id)
fatemeh_university(# );
CREATE TABLE

fatemeh_university=# INSERT INTO departments (department_name) VALUES ('Software Engineering');
INSERT 0 1

fatemeh_university=# INSERT INTO students (first_name, last_name, email, department_id)
fatemeh_university-# VALUES ('Fatemeh', 'Ebrahimi', 'fatemeh@example.com', 1), ('Amina', 'Ahmadi', 'amina@example.com', 1);
INSERT 0 2

fatemeh_university=# SELECT * FROM students;

 student_id | first_name | last_name |        email        | department_id
------------+------------+-----------+---------------------+---------------
          1 | Fatemeh    | Ebrahimi  | fatemeh@example.com |             1
          2 | Amina      | Ahmadi    | amina@example.com   |             1
(2 rows)


fatemeh_university=# \c postgres
You are now connected to database "postgres" as user "postgres".

postgres=#
