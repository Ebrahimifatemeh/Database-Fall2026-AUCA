Lab 16 — Transactions and ACID Properties (PostgreSQL)

Objective

Practice safe database transactions, BEGIN, COMMIT, ROLLBACK, savepoints, integrity constraints, and transaction isolation.

Course topics

ACID: Atomicity, Consistency, Isolation, and Durability

Explicit transactions and rollback

Savepoints and partial rollback

CHECK and foreign-key constraints

Isolation levels: READ COMMITTED, REPEATABLE READ, SERIALIZABLE

Row locking and transaction best practices

PostgreSQL note: PostgreSQL accepts READ UNCOMMITTED but treats it as READ COMMITTED; dirty reads do not occur. Under PostgreSQL's REPEATABLE READ, phantom reads are also prevented. SERIALIZABLE transactions may need to be retried after serialization failures.

Files

lab16.sql: standalone SQL lab with sample accounts, transfers, products, and exercises.

How to run

Connect to a practice database in pgAdmin or psql.

Execute lab16.sql as a script.

Review the balances before and after COMMIT and ROLLBACK.

Check the products remaining after the savepoint rollback.

psql -v ON_ERROR_STOP=1 -d your_practice_database -f lab16.sql

Warning: The script runs DROP SCHEMA IF EXISTS lab16 CASCADE and recreates the practice schema. It does not modify earlier lab schemas.

Expected observations

The first transfer moves 100 from Alice to Bob.

The rolled-back 50 transfer does not change committed balances.

The savepoint discards Mouse, while Laptop and Keyboard remain.

The checked transfer moves 75 from Alice to Carol.

Total money across accounts stays 1750.00.

Learning outcomes

I practiced organizing related updates into transactions, reversing changes safely, using savepoints, enforcing constraints, and exploring isolation levels. I also learned why row locking and short transactions matter for reliable applications.
