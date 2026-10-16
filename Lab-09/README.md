## 1. Objective

The objective of this lab is to understand the fundamental principles of relational database design using PostgreSQL.

This lab focuses on Entity-Relationship (ER) modeling, database normalization, identifying entities and attributes, and designing relational database structures.

It also demonstrates how to implement a Library Management System using primary keys, foreign keys, and relationships between tables.

## 2. Entity-Relationship (ER) Modeling

Entity-Relationship modeling is a technique used to represent the logical structure of a database.

The main components of an ER model are:

- **Entity:** A real-world object represented as a database table.
- **Attribute:** A property or characteristic of an entity.
- **Relationship:** A connection between two or more entities.

### Types of Attributes

- **Simple Attribute:** Cannot be divided into smaller components.
- **Composite Attribute:** Can be divided into multiple components.
- **Derived Attribute:** Calculated from other attributes.
- **Key Attribute:** Uniquely identifies an entity.

### Example: University Database

The main entities are:

- Students
- Courses
- Professors

Relationships:

- Students enroll in courses (Many-to-Many).
- Professors teach courses (One-to-Many).

## 3. Database Normalization

Normalization is the process of organizing database tables to reduce data redundancy and improve data integrity.

### First Normal Form (1NF)

A table follows 1NF when:

- Each column contains atomic values.
- There are no repeating groups.
- Each row is uniquely identifiable.

Example:

Instead of storing multiple phone numbers in one column, phone numbers are stored in a separate table.

### Second Normal Form (2NF)

A table follows 2NF when:

- It satisfies 1NF.
- Every non-key attribute depends on the entire primary key.

Example:

Course information is separated from enrollment records to eliminate partial dependencies.

### Third Normal Form (3NF)

A table follows 3NF when:

- It satisfies 2NF.
- Non-key attributes do not depend on other non-key attributes.

Example:

Department information is stored in a separate table rather than repeated in student records.

## 4. Database Design Process

The database design process consists of four main stages.

### Step 1: Requirements Analysis

- Identify the purpose of the database.
- Determine what information needs to be stored.
- Identify users and their requirements.

### Step 2: Conceptual Design

- Identify entities and attributes.
- Define relationships.
- Develop an ER model.

### Step 3: Logical Design

- Convert entities into tables.
- Define primary and foreign keys.
- Apply normalization.
- Establish database constraints.

### Step 4: Physical Design

- Select appropriate PostgreSQL data types.
- Implement tables and relationships.
- Consider indexes and performance.
- Plan for backup and recovery.

## 5. Library Management System

A Library Management System is used as the main database design example.

### Requirements

The system should:

- Store information about books.
- Store author information.
- Register library members.
- Track borrowed books.
- Record loan dates and due dates.
- Maintain information about returned books and late fees.

### Main Entities

**Authors**
- author_id
- first_name
- last_name
- birth_date

**Books**
- book_id
- title
- isbn
- publication_year
- available_copies

**Book_Authors**
- book_id
- author_id

**Members**
- member_id
- first_name
- last_name
- email
- phone
- membership_date

**Loans**
- loan_id
- member_id
- book_id
- loan_date
- due_date
- return_date
- late_fee

### Relationships

- One author can write multiple books.
- One book can have multiple authors.
- One member can borrow multiple books.
- One book can appear in multiple loan records.

The `book_authors` table represents the many-to-many relationship between books and authors.

The `loans` table connects library members with borrowed books.

## 6. SQL Concepts Covered

The following SQL commands and concepts are demonstrated:

- CREATE TABLE
- PRIMARY KEY
- FOREIGN KEY
- REFERENCES
- SERIAL
- VARCHAR
- INTEGER
- DATE
- DECIMAL
- DEFAULT
- NOT NULL
- UNIQUE
- INSERT INTO
- SELECT
- JOIN

## 7. Files

The Lab09 folder contains:

- `lab09_database_design.sql` — SQL code demonstrating database design, normalization, and the Library Management System.
- `README.md` — Documentation explaining the objectives and concepts covered in the lab.

## 8. How to Run

1. Open pgAdmin.
2. Connect to your PostgreSQL server.
3. Select your practice database.
4. Open the Query Tool.
5. Open the `lab09_database_design.sql` file.
6. Execute the SQL commands.
7. Review the created tables and query results.

It is recommended to use a separate practice database to avoid conflicts with tables from previous labs.

## 9. Learning Outcomes

By completing this lab, I aim to:

- Understand the principles of database design.
- Identify entities, attributes, and relationships.
- Apply normalization rules from 1NF to 3NF.
- Design relational database tables.
- Establish primary key and foreign key relationships.
- Understand how a Library Management System can be implemented in PostgreSQL.

## 10. Conclusion

Lab 09 introduces the fundamental concepts of database design and normalization.

The examples demonstrate how relational databases can be organized to reduce redundancy, maintain data consistency, and establish relationships between different entities.

The Library Management System provides a practical example of how database design principles can be applied to a real-world application.

## 11. Reference

Database Lab 09: Database Design Basics — Course material provided by Professor Esenalieva.
