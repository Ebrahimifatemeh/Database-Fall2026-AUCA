# Lab 10: Viewing Database and Table Structure


## 1. Objective

The objective of this lab is to learn how to inspect and understand the structure of a PostgreSQL database.

This lab focuses on viewing existing tables, examining table structures, identifying columns and data types, and visualizing relationships between tables using Entity-Relationship (ER) diagrams.

## 2. Introduction

Understanding database structure is an important part of working with relational databases.

PostgreSQL provides tools that allow users to examine database objects, including tables, columns, data types, primary keys, and foreign keys.

In this lab, I explore how to inspect database structures using PostgreSQL commands and pgAdmin.

## 3. Lab Exercises

### Exercise 1: Viewing All Tables

The `\dt` command displays the tables in the current PostgreSQL database.

Command:

    \dt

This command helps identify which tables exist in the database.

It displays information such as:

- Schema name
- Table name
- Table type
- Table owner

### Exercise 2: Viewing Table Structure

The `\d` command displays detailed information about a specific table.

Command:

    \d students

This command can display:

- Column names
- Data types
- NULL constraints
- Default values
- Primary keys
- Foreign keys
- Indexes

It is useful for understanding how a table is organized.

### Exercise 3: Viewing Database Structure Using pgAdmin

pgAdmin provides a graphical interface for exploring PostgreSQL databases.

Steps:

1. Open pgAdmin.
2. Connect to the PostgreSQL server.
3. Select the database.
4. Expand the Schemas section.
5. Open the public schema.
6. Expand Tables.
7. Select a table to inspect its columns and constraints.

This method allows users to explore database structures without writing SQL commands.

### Exercise 4: Viewing Entity-Relationship Diagrams

An Entity-Relationship (ER) diagram provides a graphical representation of database tables and their relationships.

ER diagrams help visualize:

- Tables
- Columns
- Primary keys
- Foreign keys
- Relationships between tables

To view an ER diagram in pgAdmin:

1. Open pgAdmin.
2. Connect to the database.
3. Navigate to the database and its tables.
4. Open the ERD tool.
5. Select or add the relevant tables.
6. Examine the relationships between them.

The ERD tool helps users understand how different tables are connected.

## 4. SQL Queries for Viewing Database Structure

In addition to psql commands, PostgreSQL provides SQL queries for examining database metadata.

### Query 1: List All Tables

```sql
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_type = 'BASE TABLE'
ORDER BY table_name;
Query 2: View Table Columns and Data Types
SELECT
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'students'
ORDER BY ordinal_position;
Query 3: View Primary Key Constraints
SELECT
    tc.table_name,
    kcu.column_name,
    tc.constraint_name
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
   AND tc.table_schema = kcu.table_schema
   AND tc.table_name = kcu.table_name
WHERE tc.constraint_type = 'PRIMARY KEY'
  AND tc.table_schema = 'public'
ORDER BY tc.table_name, kcu.ordinal_position;
Query 4: View Foreign Key Relationships
SELECT
    tc.table_name AS source_table,
    kcu.column_name AS source_column,
    ccu.table_name AS referenced_table,
    ccu.column_name AS referenced_column
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
   AND tc.table_schema = kcu.table_schema
   AND tc.table_name = kcu.table_name
JOIN information_schema.constraint_column_usage AS ccu
    ON tc.constraint_name = ccu.constraint_name
   AND tc.table_schema = ccu.table_schema
WHERE tc.constraint_type = 'FOREIGN KEY'
  AND tc.table_schema = 'public'
ORDER BY tc.table_name;
5. Commands and Tools Used

The main commands and tools covered in this lab include:

\dt — Lists database tables.
\d table_name — Displays table structure.
information_schema.tables — Provides table information.
information_schema.columns — Provides column information.
information_schema.table_constraints — Provides constraint information.
pgAdmin — Graphical database management tool.
ERD Tool — Visualizes database relationships.

Note: The \dt and \d commands are psql commands and cannot be executed directly in pgAdmin's Query Tool.

6. Files

The Lab10 folder contains:

lab10_table_structure.sql — SQL queries for examining database tables, columns, and relationships.
README.md — Documentation explaining the objectives, commands, and concepts covered in the lab.
7. How to Run
Using psql
Open the PostgreSQL psql terminal.
Connect to the practice database.
Enter \dt to display available tables.
Enter \d students to examine the students table.
Using pgAdmin
Open pgAdmin.
Connect to the PostgreSQL server.
Select the practice database.
Open the Query Tool.
Execute the SQL queries.
Review the results.

The students table must exist in the selected database for the table-specific queries to return results.

8. Learning Outcomes

By completing this lab, I aim to:

Understand how to inspect PostgreSQL databases.
Identify existing tables.
Examine table columns and data types.
Understand primary key and foreign key constraints.
Use PostgreSQL metadata queries.
Explore database structures using pgAdmin.
Understand how ER diagrams represent table relationships.
9. Conclusion

Lab 10 introduces methods for viewing and understanding database structures in PostgreSQL.

The examples demonstrate how psql commands can be used to inspect tables and how pgAdmin provides graphical tools for exploring database objects.

ER diagrams are useful for visualizing relationships between tables and understanding the overall organization of a relational database.

These skills are important for database development, maintenance, and troubleshooting.
