-- 1. Foreign key defined inline (one department -> many employees)
CREATE TABLE lab08_departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL,
    location VARCHAR(100)
);
CREATE TABLE lab08_employees (
    emp_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    dept_id INTEGER REFERENCES lab08_departments(dept_id)
);

-- 2. Table-level foreign key constraint
CREATE TABLE lab08_employee_projects (
    project_id SERIAL PRIMARY KEY,
    emp_id INTEGER,
    project_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES lab08_employees(emp_id)
);

-- 3. Add named foreign key to an existing table
CREATE TABLE lab08_department_notes (
    note_id SERIAL PRIMARY KEY,
    dept_id INTEGER,
    note_text TEXT
);
ALTER TABLE lab08_department_notes
    ADD CONSTRAINT fk_lab08_notes_department
    FOREIGN KEY (dept_id) REFERENCES lab08_departments(dept_id);

-- 4. Named constraint during table creation
CREATE TABLE lab08_employee_badges (
    badge_id SERIAL PRIMARY KEY,
    emp_id INTEGER UNIQUE,
    badge_code VARCHAR(30) NOT NULL,
    CONSTRAINT fk_lab08_badge_employee FOREIGN KEY (emp_id)
        REFERENCES lab08_employees(emp_id)
);

-- 5. Referential integrity: valid and invalid foreign keys
INSERT INTO lab08_departments (dept_name, location) VALUES
    ('Engineering', 'Building A'),
    ('Marketing', 'Building B'),
    ('HR', 'Building C');
INSERT INTO lab08_employees (first_name, last_name, dept_id) VALUES
    ('John', 'Smith', 1), ('Jane', 'Doe', 1), ('Sarah', 'Davis', 2);
SELECT d.dept_name, e.first_name, e.last_name
FROM lab08_departments d JOIN lab08_employees e ON d.dept_id = e.dept_id
ORDER BY d.dept_name, e.last_name;
-- Expected error: dept_id 99 does not exist:
-- INSERT INTO lab08_employees (first_name, last_name, dept_id) VALUES ('Invalid', 'Employee', 99);
-- Expected error: referenced department still has employees (default NO ACTION):
-- DELETE FROM lab08_departments WHERE dept_id = 1;

-- 6. ON DELETE CASCADE / ON UPDATE CASCADE
CREATE TABLE lab08_cascade_parent (parent_id INTEGER PRIMARY KEY, label TEXT);
CREATE TABLE lab08_cascade_child (
    child_id SERIAL PRIMARY KEY,
    parent_id INTEGER REFERENCES lab08_cascade_parent(parent_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO lab08_cascade_parent VALUES (10, 'First'), (20, 'Second');
INSERT INTO lab08_cascade_child (parent_id) VALUES (10), (10), (20);
UPDATE lab08_cascade_parent SET parent_id = 11 WHERE parent_id = 10;
SELECT * FROM lab08_cascade_child ORDER BY child_id; -- 10 becomes 11
DELETE FROM lab08_cascade_parent WHERE parent_id = 20;
SELECT * FROM lab08_cascade_child ORDER BY child_id; -- child of 20 removed

-- 7. ON DELETE SET NULL
CREATE TABLE lab08_setnull_parent (parent_id INTEGER PRIMARY KEY);
CREATE TABLE lab08_setnull_child (
    child_id SERIAL PRIMARY KEY,
    parent_id INTEGER REFERENCES lab08_setnull_parent(parent_id) ON DELETE SET NULL
);
INSERT INTO lab08_setnull_parent VALUES (1);
INSERT INTO lab08_setnull_child (parent_id) VALUES (1);
DELETE FROM lab08_setnull_parent WHERE parent_id = 1;
SELECT * FROM lab08_setnull_child; -- parent_id becomes NULL

-- 8. ON DELETE SET DEFAULT (default must reference an existing parent)
CREATE TABLE lab08_default_parent (parent_id INTEGER PRIMARY KEY);
CREATE TABLE lab08_default_child (
    child_id SERIAL PRIMARY KEY,
    parent_id INTEGER DEFAULT 0 REFERENCES lab08_default_parent(parent_id) ON DELETE SET DEFAULT
);
INSERT INTO lab08_default_parent VALUES (0), (1);
INSERT INTO lab08_default_child (parent_id) VALUES (1);
DELETE FROM lab08_default_parent WHERE parent_id = 1;
SELECT * FROM lab08_default_child; -- parent_id becomes 0

-- 9. ON DELETE RESTRICT
CREATE TABLE lab08_restrict_parent (parent_id INTEGER PRIMARY KEY);
CREATE TABLE lab08_restrict_child (
    child_id SERIAL PRIMARY KEY,
    parent_id INTEGER REFERENCES lab08_restrict_parent(parent_id) ON DELETE RESTRICT
);
INSERT INTO lab08_restrict_parent VALUES (1);
INSERT INTO lab08_restrict_child (parent_id) VALUES (1);
-- Expected error: child still references parent:
-- DELETE FROM lab08_restrict_parent WHERE parent_id = 1;

-- 10. One-to-one: a user has at most one profile
CREATE TABLE lab08_users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);
CREATE TABLE lab08_user_profiles (
    profile_id SERIAL PRIMARY KEY,
    user_id INTEGER UNIQUE NOT NULL REFERENCES lab08_users(user_id) ON DELETE CASCADE,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    bio TEXT
);
INSERT INTO lab08_users (username, email) VALUES ('johndoe', 'john@example.com');
INSERT INTO lab08_user_profiles (user_id, first_name, last_name, bio)
VALUES (1, 'John', 'Doe', 'Software developer');
SELECT u.username, p.first_name, p.last_name
FROM lab08_users u JOIN lab08_user_profiles p ON u.user_id = p.user_id;
-- Expected error: second profile for user 1 violates UNIQUE:
-- INSERT INTO lab08_user_profiles (user_id, first_name) VALUES (1, 'Jane');

-- 11. One-to-many: a blog post has multiple comments
CREATE TABLE lab08_blog_posts (
    post_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    content TEXT
);
CREATE TABLE lab08_comments (
    comment_id SERIAL PRIMARY KEY,
    post_id INTEGER NOT NULL REFERENCES lab08_blog_posts(post_id) ON DELETE CASCADE,
    commenter_name VARCHAR(100),
    comment_text TEXT NOT NULL
);
INSERT INTO lab08_blog_posts (title, content) VALUES ('Database Basics', 'Foreign key examples');
INSERT INTO lab08_comments (post_id, commenter_name, comment_text) VALUES
    (1, 'Alice', 'Helpful post!'), (1, 'Bob', 'Thank you!');
SELECT p.title, c.commenter_name, c.comment_text
FROM lab08_blog_posts p JOIN lab08_comments c ON p.post_id = c.post_id;

-- 12. Many-to-many: students <-> courses through enrollments
CREATE TABLE lab08_students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE
);
CREATE TABLE lab08_courses (
    course_id SERIAL PRIMARY KEY,
    course_code VARCHAR(10) UNIQUE NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    credits INTEGER NOT NULL
);
CREATE TABLE lab08_student_enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL REFERENCES lab08_students(student_id) ON DELETE CASCADE,
    course_id INTEGER NOT NULL REFERENCES lab08_courses(course_id) ON DELETE CASCADE,
    enrollment_date DATE DEFAULT CURRENT_DATE,
    grade VARCHAR(2),
    UNIQUE (student_id, course_id)
);
INSERT INTO lab08_students (first_name, last_name, email) VALUES
    ('Alice', 'Johnson', 'alice@university.edu'),
    ('Bob', 'Smith', 'bob@university.edu'),
    ('Carol', 'Wilson', 'carol@university.edu');
INSERT INTO lab08_courses (course_code, course_name, credits) VALUES
    ('CS101', 'Introduction to Programming', 3),
    ('CS201', 'Data Structures', 4),
    ('MATH101', 'Calculus I', 4);
INSERT INTO lab08_student_enrollments (student_id, course_id, grade) VALUES
    (1, 1, 'A'), (1, 2, 'B+'), (2, 1, 'A-'),
    (2, 3, 'B'), (3, 2, 'A'), (3, 3, 'A-');

-- All students and their courses
SELECT s.first_name || ' ' || s.last_name AS student_name,
       c.course_code, c.course_name, se.grade, se.enrollment_date
FROM lab08_students s
JOIN lab08_student_enrollments se ON s.student_id = se.student_id
JOIN lab08_courses c ON se.course_id = c.course_id
ORDER BY s.last_name, c.course_code;

-- Students enrolled in CS101
SELECT s.first_name, s.last_name, se.grade
FROM lab08_students s
JOIN lab08_student_enrollments se ON s.student_id = se.student_id
JOIN lab08_courses c ON se.course_id = c.course_id
WHERE c.course_code = 'CS101';

-- Courses taken by Alice
SELECT c.course_code, c.course_name, c.credits, se.grade
FROM lab08_courses c
JOIN lab08_student_enrollments se ON c.course_id = se.course_id
JOIN lab08_students s ON se.student_id = s.student_id
WHERE s.email = 'alice@university.edu';
