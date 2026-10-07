-- Lab 04: First SQL Query

-- Display all students
SELECT * FROM students;

-- Display selected columns
SELECT name, email
FROM students;

-- Filter students using WHERE
SELECT name, email
FROM students
WHERE name = 'Timur';

-- Sort students by name
SELECT name, email
FROM students
ORDER BY name;

-- Limit the number of results
SELECT name, email
FROM students
LIMIT 2;

/*
This is an example
of a multi-line SQL comment.
*/
