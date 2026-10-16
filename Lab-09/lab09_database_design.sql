CREATE SCHEMA IF NOT EXISTS lab09;
SET search_path TO lab09;

-- 1NF: each phone number is a separate row (atomic values).
CREATE TABLE IF NOT EXISTS nf1_students (
    student_id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS nf1_student_phones (
    student_id INTEGER NOT NULL REFERENCES nf1_students(student_id),
    phone_number VARCHAR(15) NOT NULL,
    phone_type VARCHAR(20),
    PRIMARY KEY (student_id, phone_number)
);

-- 2NF: course name depends on course_id, not on an enrollment's composite key.
CREATE TABLE IF NOT EXISTS nf2_courses (
    course_id INTEGER PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INTEGER
);
CREATE TABLE IF NOT EXISTS nf2_enrollments (
    student_id INTEGER NOT NULL REFERENCES nf1_students(student_id),
    course_id INTEGER NOT NULL REFERENCES nf2_courses(course_id),
    grade VARCHAR(2),
    PRIMARY KEY (student_id, course_id)
);

-- 3NF: department name is stored once, in the department table.
CREATE TABLE IF NOT EXISTS nf3_departments (
    department_id INTEGER PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    department_head VARCHAR(100)
);
CREATE TABLE IF NOT EXISTS nf3_students (
    student_id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department_id INTEGER REFERENCES nf3_departments(department_id)
);

-- Library management system: conceptual entities Author, Book, Member, Loan.
-- A book may have many authors, and an author may write many books.
CREATE TABLE IF NOT EXISTS authors (
    author_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE
);
CREATE TABLE IF NOT EXISTS books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    isbn VARCHAR(13) UNIQUE,
    publication_year INTEGER,
    available_copies INTEGER DEFAULT 1 CHECK (available_copies >= 0)
);
CREATE TABLE IF NOT EXISTS book_authors (
    book_id INTEGER NOT NULL REFERENCES books(book_id),
    author_id INTEGER NOT NULL REFERENCES authors(author_id),
    PRIMARY KEY (book_id, author_id)
);
CREATE TABLE IF NOT EXISTS members (
    member_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    membership_date DATE DEFAULT CURRENT_DATE
);
CREATE TABLE IF NOT EXISTS loans (
    loan_id SERIAL PRIMARY KEY,
    member_id INTEGER NOT NULL REFERENCES members(member_id),
    book_id INTEGER NOT NULL REFERENCES books(book_id),
    loan_date DATE DEFAULT CURRENT_DATE,
    due_date DATE NOT NULL,
    return_date DATE,
    late_fee DECIMAL(10,2) DEFAULT 0.00 CHECK (late_fee >= 0)
);

-- Sample data; ON CONFLICT avoids duplicate entries when rerun.
INSERT INTO nf1_students(student_id, name) VALUES (1, 'Alice Johnson'), (2, 'Bob Smith')
ON CONFLICT (student_id) DO NOTHING;
INSERT INTO nf1_student_phones(student_id, phone_number, phone_type)
VALUES (1, '555-0101', 'mobile'), (1, '555-0102', 'home')
ON CONFLICT (student_id, phone_number) DO NOTHING;
INSERT INTO nf2_courses(course_id, course_name, credits)
VALUES (101, 'Database Systems', 6), (102, 'Programming', 6)
ON CONFLICT (course_id) DO NOTHING;
INSERT INTO nf2_enrollments(student_id, course_id, grade)
VALUES (1, 101, 'A'), (2, 101, 'B+')
ON CONFLICT (student_id, course_id) DO NOTHING;
INSERT INTO nf3_departments(department_id, department_name, department_head)
VALUES (10, 'Computer Science', 'Dr. Lee')
ON CONFLICT (department_id) DO NOTHING;
INSERT INTO nf3_students(student_id, name, department_id)
VALUES (1, 'Alice Johnson', 10)
ON CONFLICT (student_id) DO NOTHING;

INSERT INTO authors(first_name, last_name) 
SELECT 'Jane', 'Austen' WHERE NOT EXISTS (SELECT 1 FROM authors WHERE first_name='Jane' AND last_name='Austen');
INSERT INTO books(title, isbn, publication_year, available_copies)
VALUES ('Pride and Prejudice', '9780141439518', 1813, 2)
ON CONFLICT (isbn) DO NOTHING;
INSERT INTO members(first_name, last_name, email, phone)
VALUES ('Sam', 'Taylor', 'sam.taylor@example.com', '555-0199')
ON CONFLICT (email) DO NOTHING;
INSERT INTO book_authors(book_id, author_id)
SELECT b.book_id, a.author_id FROM books b CROSS JOIN authors a
WHERE b.isbn='9780141439518' AND a.first_name='Jane' AND a.last_name='Austen'
ON CONFLICT (book_id, author_id) DO NOTHING;
INSERT INTO loans(member_id, book_id, due_date)
SELECT m.member_id, b.book_id, CURRENT_DATE + 14
FROM members m CROSS JOIN books b
WHERE m.email='sam.taylor@example.com' AND b.isbn='9780141439518'
AND NOT EXISTS (SELECT 1 FROM loans l WHERE l.member_id=m.member_id AND l.book_id=b.book_id);

-- Query 1: 1NF phone records
SELECT s.name, p.phone_number, p.phone_type
FROM nf1_students s JOIN nf1_student_phones p ON s.student_id = p.student_id;

-- Query 2: 2NF enrollment details
SELECT s.name, c.course_name, e.grade
FROM nf2_enrollments e
JOIN nf1_students s ON e.student_id=s.student_id
JOIN nf2_courses c ON e.course_id=c.course_id;

-- Query 3: 3NF department information
SELECT s.name, d.department_name, d.department_head
FROM nf3_students s JOIN nf3_departments d ON s.department_id=d.department_id;

-- Query 4: book authors (many-to-many)
SELECT b.title, a.first_name || ' ' || a.last_name AS author
FROM books b JOIN book_authors ba ON b.book_id=ba.book_id
JOIN authors a ON ba.author_id=a.author_id;

-- Query 5: borrowing history
SELECT m.first_name || ' ' || m.last_name AS member,
       b.title, l.loan_date, l.due_date, l.return_date, l.late_fee
FROM loans l JOIN members m ON l.member_id=m.member_id
JOIN books b ON l.book_id=b.book_id;
