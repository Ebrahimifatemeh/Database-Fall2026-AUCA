-- Lab 06: Tables, Data Types and Constraints

-- Create students table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    faculty VARCHAR(100)
);

-- Add a new column
ALTER TABLE students
ADD COLUMN date_of_birth DATE;

-- Drop a column
ALTER TABLE students
DROP COLUMN faculty;

-- Change a column's data type
ALTER TABLE students
ALTER COLUMN first_name TYPE TEXT;

-- Rename a column
ALTER TABLE students
RENAME COLUMN email TO email_address;

-- Rename the table
ALTER TABLE students
RENAME TO university_students;

-- Drop the table
DROP TABLE IF EXISTS university_students;
