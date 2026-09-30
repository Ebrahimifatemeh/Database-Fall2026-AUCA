-- Lab 03: Basic psql Commands

-- Create students table
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT
);

-- Insert sample data
INSERT INTO students (name, age)
VALUES ('Alice', 21), ('Bob', 23);

-- Display all records
SELECT * FROM students;

-- Delete the table
DROP TABLE students;
