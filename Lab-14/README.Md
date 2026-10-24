# Lab 14 — Joining Tables (PostgreSQL)

## Objective

The objective of this lab is to understand how to combine data from multiple tables using SQL JOIN operations in PostgreSQL.

This lab focuses on retrieving related information from different database tables, understanding table relationships, and writing queries using different JOIN techniques.

## Topics Covered

1. INNER JOIN
2. LEFT JOIN (LEFT OUTER JOIN)
3. RIGHT JOIN (RIGHT OUTER JOIN)
4. FULL OUTER JOIN
5. CROSS JOIN
6. Multiple Table Joins
7. Self Joins
8. JOIN with Conditions
9. One-to-One Relationships
10. One-to-Many Relationships
11. Many-to-Many Relationships
12. Indexes and JOIN Performance
13. Common JOIN Mistakes

## Files

- `lab14.sql` — Contains SQL statements for creating sample tables, inserting data, and practicing different JOIN operations.

## SQL Concepts

### 1. INNER JOIN

An INNER JOIN returns only records that have matching values in both tables.

Example:

    SELECT c.name, o.order_date, o.total_amount
    FROM customers c
    INNER JOIN orders o
    ON c.customer_id = o.customer_id;

### 2. LEFT JOIN

A LEFT JOIN returns all records from the left table and matching records from the right table.

If there is no matching record, NULL values are returned for the right table.

Example:

    SELECT c.name, o.order_date
    FROM customers c
    LEFT JOIN orders o
    ON c.customer_id = o.customer_id;

### 3. RIGHT JOIN

A RIGHT JOIN returns all records from the right table and matching records from the left table.

Example:

    SELECT c.name, o.order_date
    FROM customers c
    RIGHT JOIN orders o
    ON c.customer_id = o.customer_id;

### 4. FULL OUTER JOIN

A FULL OUTER JOIN returns all records from both tables, including unmatched records.

Example:

    SELECT c.name, o.order_date
    FROM customers c
    FULL OUTER JOIN orders o
    ON c.customer_id = o.customer_id;

### 5. CROSS JOIN

A CROSS JOIN combines every row from the first table with every row from the second table.

Example:

    SELECT c.name, p.product_name
    FROM customers c
    CROSS JOIN products p;

### 6. Multiple Table Joins

Multiple JOIN operations can be used to retrieve related information from several tables.

Example:

    SELECT
        c.name,
        o.order_date,
        p.product_name,
        oi.quantity
    FROM customers c
    INNER JOIN orders o
        ON c.customer_id = o.customer_id
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id;

### 7. Self Join

A self join is used when a table needs to be joined with itself.

Example:

    SELECT
        e1.name AS employee,
        e2.name AS manager
    FROM employees e1
    LEFT JOIN employees e2
        ON e1.manager_id = e2.employee_id;

### 8. JOIN with Conditions

JOIN operations can be combined with WHERE conditions to filter results.

Example:

    SELECT
        c.name,
        o.order_date,
        o.total_amount
    FROM customers c
    INNER JOIN orders o
        ON c.customer_id = o.customer_id
    WHERE o.total_amount > 100;

## Database Relationships

### One-to-One Relationship

Each record in one table is associated with one record in another table.

Example: Users and user profiles.

### One-to-Many Relationship

One record in a table can be associated with multiple records in another table.

Example: One customer can place multiple orders.

### Many-to-Many Relationship

Multiple records in one table can be associated with multiple records in another table.

A junction table is used to manage this relationship.

Example: Students and courses connected through an enrollments table.

## Performance Considerations

To improve JOIN query performance:

- Use indexes on foreign key columns.
- Choose the appropriate JOIN type.
- Use table aliases to improve readability.
- Avoid unnecessary CROSS JOIN operations.
- Specify correct JOIN conditions.
- Check for duplicate or unexpected results.

## Common Mistakes

### Missing JOIN Conditions

Forgetting a JOIN condition can create a Cartesian product.

### Incorrect NULL Handling

Use IS NULL or IS NOT NULL when checking unmatched records.

### Incorrect Many-to-Many Joins

Use the junction table when joining tables with many-to-many relationships.

## How to Run

1. Open PostgreSQL using pgAdmin or psql.
2. Connect to a practice database.
3. Open the `lab14.sql` file.
4. Execute the SQL statements.
5. Review the query results.

### Using psql

    psql -d your_practice_database -f lab14.sql

## Learning Outcomes

Through this lab, I practiced:

- Understanding different SQL JOIN operations.
- Combining information from multiple tables.
- Retrieving matching and unmatched records.
- Using primary keys and foreign keys in JOIN conditions.
- Working with one-to-one, one-to-many, and many-to-many relationships.
- Writing queries with multiple JOIN operations.
- Using self joins to retrieve hierarchical information.
- Filtering joined data using WHERE conditions.
- Understanding how indexes can improve query performance.
- Identifying and avoiding common JOIN mistakes.

## Conclusion

In this lab, I learned how SQL JOIN operations are used to combine related information from multiple database tables.

I practiced different JOIN types, including INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL OUTER JOIN, and CROSS JOIN.

I also explored more advanced techniques, such as multiple-table joins, self joins, and joining tables with different relationship types.

This lab improved my understanding of relational databases and helped me develop practical PostgreSQL querying skills.
