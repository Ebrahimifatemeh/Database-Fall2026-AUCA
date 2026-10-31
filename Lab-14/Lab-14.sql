Server [localhost]:
Database [postgres]:
Port [5432]:
Username [postgres]:
Password for user postgres:

psql (18.6)
WARNING: Console code page (437) differs from Windows code page (1252)
         8-bit characters might not work correctly. See psql reference
         page "Notes for Windows users" for details.
Type "help" for help.

postgres=# \i "C:\Users\user\Downloads\Fatemeh_Lab14\Fatemeh_Lab14_Joining_Tables.sql"
"C:/Users/user/Downloads/Fatemeh_Lab14/Fatemeh_Lab14_Joining_Tables.sql: No such file or directory
postgres=# \c lab14
You are now connected to database "lab14" as user "postgres".
lab14=# \i 'C:/Users/user/Downloads/Fatemeh_Lab14/Fatemeh_Lab14_Joining_Tables.sql'
Pager usage is off.
LAB 14 - JOINING TABLES | Fatemeh Ebrahimi
BEGIN
psql:C:/Users/user/Downloads/Fatemeh_Lab14/Fatemeh_Lab14_Joining_Tables.sql:8: D-D?DoDDD?D?D~D:  Ñ,D°D±D»D,Ñ+D° "enrollments" D½Dµ Ñ?ÑƒÑ%DµÑ?Ñ,D²ÑƒDµÑ,, D¿Ñ?D_D¿ÑƒÑ?DºD°DµÑ,Ñ?Ñ?
psql:C:/Users/user/Downloads/Fatemeh_Lab14/Fatemeh_Lab14_Joining_Tables.sql:8: D-D?DoDDD?D?D~D:  Ñ,D°D±D»D,Ñ+D° "courses" D½Dµ Ñ?ÑƒÑ%DµÑ?Ñ,D²ÑƒDµÑ,, D¿Ñ?D_D¿ÑƒÑ?DºD°DµÑ,Ñ?Ñ?
psql:C:/Users/user/Downloads/Fatemeh_Lab14/Fatemeh_Lab14_Joining_Tables.sql:8: D-D?DoDDD?D?D~D:  Ñ,D°D±D»D,Ñ+D° "students" D½Dµ Ñ?ÑƒÑ%DµÑ?Ñ,D²ÑƒDµÑ,, D¿Ñ?D_D¿ÑƒÑ?DºD°DµÑ,Ñ?Ñ?
psql:C:/Users/user/Downloads/Fatemeh_Lab14/Fatemeh_Lab14_Joining_Tables.sql:8: D-D?DoDDD?D?D~D:  Ñ,D°D±D»D,Ñ+D° "books" D½Dµ Ñ?ÑƒÑ%DµÑ?Ñ,D²ÑƒDµÑ,, D¿Ñ?D_D¿ÑƒÑ?DºD°DµÑ,Ñ?Ñ?
psql:C:/Users/user/Downloads/Fatemeh_Lab14/Fatemeh_Lab14_Joining_Tables.sql:8: D-D?DoDDD?D?D~D:  Ñ,D°D±D»D,Ñ+D° "authors" D½Dµ Ñ?ÑƒÑ%DµÑ?Ñ,D²ÑƒDµÑ,, D¿Ñ?D_D¿ÑƒÑ?DºD°DµÑ,Ñ?Ñ?
psql:C:/Users/user/Downloads/Fatemeh_Lab14/Fatemeh_Lab14_Joining_Tables.sql:8: D-D?DoDDD?D?D~D:  Ñ,D°D±D»D,Ñ+D° "user_profiles" D½Dµ Ñ?ÑƒÑ%DµÑ?Ñ,D²ÑƒDµÑ,, D¿Ñ?D_D¿ÑƒÑ?DºD°DµÑ,Ñ?Ñ?
psql:C:/Users/user/Downloads/Fatemeh_Lab14/Fatemeh_Lab14_Joining_Tables.sql:8: D-D?DoDDD?D?D~D:  Ñ,D°D±D»D,Ñ+D° "users" D½Dµ Ñ?ÑƒÑ%DµÑ?Ñ,D²ÑƒDµÑ,, D¿Ñ?D_D¿ÑƒÑ?DºD°DµÑ,Ñ?Ñ?
psql:C:/Users/user/Downloads/Fatemeh_Lab14/Fatemeh_Lab14_Joining_Tables.sql:8: D-D?DoDDD?D?D~D:  Ñ,D°D±D»D,Ñ+D° "employees" D½Dµ Ñ?ÑƒÑ%DµÑ?Ñ,D²ÑƒDµÑ,, D¿Ñ?D_D¿ÑƒÑ?DºD°DµÑ,Ñ?Ñ?
psql:C:/Users/user/Downloads/Fatemeh_Lab14/Fatemeh_Lab14_Joining_Tables.sql:8: D-D?DoDDD?D?D~D:  Ñ,D°D±D»D,Ñ+D° "order_items" D½Dµ Ñ?ÑƒÑ%DµÑ?Ñ,D²ÑƒDµÑ,, D¿Ñ?D_D¿ÑƒÑ?DºD°DµÑ,Ñ?Ñ?
psql:C:/Users/user/Downloads/Fatemeh_Lab14/Fatemeh_Lab14_Joining_Tables.sql:8: D-D?DoDDD?D?D~D:  Ñ,D°D±D»D,Ñ+D° "products" D½Dµ Ñ?ÑƒÑ%DµÑ?Ñ,D²ÑƒDµÑ,, D¿Ñ?D_D¿ÑƒÑ?DºD°DµÑ,Ñ?Ñ?
psql:C:/Users/user/Downloads/Fatemeh_Lab14/Fatemeh_Lab14_Joining_Tables.sql:8: D-D?DoDDD?D?D~D:  Ñ,D°D±D»D,Ñ+D° "orders" D½Dµ Ñ?ÑƒÑ%DµÑ?Ñ,D²ÑƒDµÑ,, D¿Ñ?D_D¿ÑƒÑ?DºD°DµÑ,Ñ?Ñ?
psql:C:/Users/user/Downloads/Fatemeh_Lab14/Fatemeh_Lab14_Joining_Tables.sql:8: D-D?DoDDD?D?D~D:  Ñ,D°D±D»D,Ñ+D° "customers" D½Dµ Ñ?ÑƒÑ%DµÑ?Ñ,D²ÑƒDµÑ,, D¿Ñ?D_D¿ÑƒÑ?DºD°DµÑ,Ñ?Ñ?
DROP TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
INSERT 0 4
INSERT 0 5
INSERT 0 3
INSERT 0 7
INSERT 0 4
INSERT 0 3
INSERT 0 2
INSERT 0 2
INSERT 0 3
INSERT 0 3
INSERT 0 3
INSERT 0 4
CREATE INDEX
CREATE INDEX
CREATE INDEX
COMMIT
01 INNER JOIN - customers with orders
     name      |       email       | order_date | total_amount
---------------+-------------------+------------+--------------
 Alice Johnson | alice@example.com | 2024-02-15 |       150.00
 Alice Johnson | alice@example.com | 2024-04-20 |        85.00
 Bob Smith     | bob@example.com   | 2023-12-10 |       200.00
 Clara Davis   | clara@example.com | 2024-05-05 |       350.00
(4 rows)

02 LEFT JOIN - include customers with no orders
     name      |       email       | order_date | total_amount
---------------+-------------------+------------+--------------
 Alice Johnson | alice@example.com | 2024-02-15 |       150.00
 Alice Johnson | alice@example.com | 2024-04-20 |        85.00
 Bob Smith     | bob@example.com   | 2023-12-10 |       200.00
 Clara Davis   | clara@example.com | 2024-05-05 |       350.00
 David Lee     | david@example.com |            |
(5 rows)

03 RIGHT JOIN - include orders with missing customer reference
     name      |       email       | order_date | total_amount
---------------+-------------------+------------+--------------
 Alice Johnson | alice@example.com | 2024-02-15 |       150.00
 Alice Johnson | alice@example.com | 2024-04-20 |        85.00
 Bob Smith     | bob@example.com   | 2023-12-10 |       200.00
 Clara Davis   | clara@example.com | 2024-05-05 |       350.00
               |                   | 2024-06-01 |        45.00
(5 rows)

04 FULL OUTER JOIN - all customers and orders
     name      |       email       | order_date | total_amount
---------------+-------------------+------------+--------------
 Alice Johnson | alice@example.com | 2024-02-15 |       150.00
 Alice Johnson | alice@example.com | 2024-04-20 |        85.00
 Bob Smith     | bob@example.com   | 2023-12-10 |       200.00
 Clara Davis   | clara@example.com | 2024-05-05 |       350.00
 David Lee     | david@example.com |            |
               |                   | 2024-06-01 |        45.00
(6 rows)

05 CROSS JOIN - every customer/product combination
     name      | product_name
---------------+--------------
 Alice Johnson | Keyboard
 Alice Johnson | Monitor
 Alice Johnson | Mouse
 Bob Smith     | Keyboard
 Bob Smith     | Monitor
 Bob Smith     | Mouse
 Clara Davis   | Keyboard
 Clara Davis   | Monitor
 Clara Davis   | Mouse
 David Lee     | Keyboard
 David Lee     | Monitor
 David Lee     | Mouse
(12 rows)

06 MULTI-TABLE JOIN - customer, order, item, product
     name      | order_date | quantity | product_name | price
---------------+------------+----------+--------------+--------
 Alice Johnson | 2024-02-15 |        2 | Keyboard     |  50.00
 Alice Johnson | 2024-02-15 |        2 | Mouse        |  25.00
 Alice Johnson | 2024-04-20 |        1 | Mouse        |  25.00
 Bob Smith     | 2023-12-10 |        1 | Monitor      | 200.00
 Clara Davis   | 2024-05-05 |        1 | Monitor      | 200.00
 Clara Davis   | 2024-05-05 |        3 | Keyboard     |  50.00
(6 rows)

07 SELF JOIN - employees and managers
    employee    |    manager
----------------+----------------
 Maria Manager  |
 John Developer | Maria Manager
 Sara Analyst   | Maria Manager
 Tim Intern     | John Developer
(4 rows)

08 JOIN WITH CONDITIONS - recent orders above 100
     name      | order_date | total_amount
---------------+------------+--------------
 Alice Johnson | 2024-02-15 |       150.00
 Clara Davis   | 2024-05-05 |       350.00
(2 rows)

09 ONE-TO-ONE - user profiles
 username | first_name | last_name |  phone
----------+------------+-----------+----------
 alicej   | Alice      | Johnson   | 555-0101
 bobs     | Bob        | Smith     | 555-0102
 guest    |            |           |
(3 rows)

10 ONE-TO-MANY - authors and books
 author_name |    title     | publication_year
-------------+--------------+------------------
 Author One  | First Book   |             2021
 Author One  | Second Book  |             2024
 Author Two  | Another Book |             2022
(3 rows)

11 MANY-TO-MANY - students, enrollments, courses
 student_name |   course_name   | enrollment_date | grade
--------------+-----------------+-----------------+-------
 Fatemeh      | Algorithms      | 2024-09-01      | B
 Fatemeh      | Databases       | 2024-09-01      | A
 Sam          | Web Development | 2024-09-03      | A
(3 rows)

12 ALIASES - readable join
     name      | order_date
---------------+------------
 Alice Johnson | 2024-02-15
 Alice Johnson | 2024-04-20
 Bob Smith     | 2023-12-10
 Clara Davis   | 2024-05-05
(4 rows)

13 CORRECT JOIN CONDITION - avoid accidental Cartesian product
     name      | order_date
---------------+------------
 Alice Johnson | 2024-02-15
 Alice Johnson | 2024-04-20
 Bob Smith     | 2023-12-10
 Clara Davis   | 2024-05-05
(4 rows)

14 NULL HANDLING - customers without orders
   name
-----------
 David Lee
(1 row)

15 LEFT-ONLY / RIGHT-ONLY / FULL EXCLUDING MATCHES
   name
-----------
 David Lee
(1 row)

 order_id | total_amount
----------+--------------
        5 |        45.00
(1 row)

   name    | order_id
-----------+----------
 David Lee |
           |        5
(2 rows)

LAB 14 COMPLETED - all statements above should run without errors.
lab14=#
