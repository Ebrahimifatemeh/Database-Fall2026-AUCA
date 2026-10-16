CREATE SCHEMA IF NOT EXISTS lab11;

-- ============================================
-- 1. CREATE STUDENTS TABLE
-- ============================================

CREATE TABLE IF NOT EXISTS lab11.students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE
);

-- ============================================
-- 2. INSERT A SINGLE RECORD
-- ============================================

INSERT INTO lab11.students
    (first_name, last_name, birth_date)
VALUES
    ('Aibek', 'Sharshenov', '2002-05-12');

SELECT * FROM lab11.students;

-- ============================================
-- 3. INSERT MULTIPLE RECORDS
-- ============================================

INSERT INTO lab11.students
    (first_name, last_name, birth_date)
VALUES
    ('Ainura', 'Toktomamatova', '2001-09-23'),
    ('Bakyt', 'Mamatov', '2003-01-15'),
    ('Gulzat', 'Sultanova', '2002-07-30');

SELECT * FROM lab11.students;

-- ============================================
-- 4. UPDATE A SINGLE RECORD
-- ============================================

UPDATE lab11.students
SET birth_date = '2002-05-15'
WHERE first_name = 'Aibek'
  AND last_name = 'Sharshenov';

SELECT * FROM lab11.students;

-- ============================================
-- 5. DELETE A SPECIFIC RECORD
-- ============================================

DELETE FROM lab11.students
WHERE first_name = 'Gulzat'
  AND last_name = 'Sultanova';

SELECT * FROM lab11.students;

-- ============================================
-- 6. DELETE USING A DATE CONDITION
-- ============================================

DELETE FROM lab11.students
WHERE birth_date < '2002-01-01';

SELECT * FROM lab11.students;

-- ============================================
-- 7. BULK INSERT
-- ============================================

INSERT INTO lab11.students
    (first_name, last_name, birth_date)
VALUES
    ('Nursultan', 'Isakov', '2002-04-10'),
    ('Meerim', 'Bekova', '2003-06-12'),
    ('Tilek', 'Usubaliev', '2001-11-05'),
    ('Adilet', 'Uulu', '2002-08-20');

SELECT * FROM lab11.students;

-- ============================================
-- 8. IMPORT DATA USING COPY
-- ============================================

-- COPY imports data from a CSV file.
-- The file must be accessible to the
-- PostgreSQL server.

-- Example from the course material:
--
-- COPY lab11.students
--     (first_name, last_name, birth_date)
-- FROM '/path/to/students.csv'
-- DELIMITER ','
-- CSV HEADER;
--
-- This command is commented out because
-- the actual CSV file path depends on
-- the user's computer and PostgreSQL setup.

-- ============================================
-- 9. BULK UPDATE
-- ============================================

UPDATE lab11.students
SET last_name = 'Bekov'
WHERE last_name IN ('Uulu', 'Isakov');

SELECT * FROM lab11.students;

-- ============================================
-- 10. BULK DELETE
-- ============================================

-- Delete several records using student IDs.

DELETE FROM lab11.students
WHERE student_id IN (2, 3, 5);

SELECT * FROM lab11.students;

-- ============================================
-- 11. VIEW FINAL DATA
-- ============================================

SELECT
    student_id,
    first_name,
    last_name,
    birth_date
FROM lab11.students
ORDER BY student_id;
