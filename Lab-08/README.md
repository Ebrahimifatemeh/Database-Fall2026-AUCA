Objective

Practice foreign keys and referential integrity, compare ON DELETE and ON UPDATE actions, and model one-to-one, one-to-many, and many-to-many relationships.

Contents

lab08_foreign_keys.sql — SQL examples, sample data, and queries.

README.md — Description and run instructions.

Topics demonstrated

Inline, table-level, added (ALTER TABLE), and named foreign key constraints.

Referential integrity: a foreign key cannot reference a missing parent row.

ON DELETE CASCADE, SET NULL, SET DEFAULT, and RESTRICT.

ON UPDATE CASCADE.

One-to-one: users and user profiles (UNIQUE foreign key).

One-to-many: blog posts and comments; departments and employees.

Many-to-many: students, courses, and a junction table (student_enrollments).

JOIN queries to retrieve related data.

How to run

Open pgAdmin and connect to a practice database.

Open Query Tool.

Paste or open lab08_foreign_keys.sql and execute it once.

Review the SELECT results.

Optional: run each commented-out invalid INSERT or DELETE separately to observe the expected constraint error. Do not run them as part of the full script.

All tables have the lab08_ prefix to avoid collisions with tables from earlier labs. The script is not rerunnable without cleanup because the tables will already exist after the first execution. Some examples use assumed automatically generated IDs, so run the script in a fresh practice database.

Key concepts

A foreign key links a child table to a parent table and helps enforce referential integrity. A one-to-one relationship can be modeled with a unique foreign key; a one-to-many relationship allows multiple child records per parent; a many-to-many relationship requires a junction table.
