-- 1. VIEW ALL TABLES IN THE DATABASE

-- The following command works in psql:
-- \dt

-- Equivalent SQL query for pgAdmin:

SELECT
    table_schema,
    table_name,
    table_type
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_type = 'BASE TABLE'
ORDER BY table_name;


-- ============================================
-- 2. VIEW THE STRUCTURE OF A SPECIFIC TABLE
-- ============================================

-- The following command works in psql:
-- \d students

-- Equivalent SQL query for pgAdmin:

SELECT
    column_name,
    data_type,
    character_maximum_length,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'students'
ORDER BY ordinal_position;


-- ============================================
-- 3. VIEW ALL COLUMNS IN ALL TABLES
-- ============================================

SELECT
    table_name,
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_schema = 'public'
ORDER BY table_name, ordinal_position;


-- ============================================
-- 4. VIEW PRIMARY KEY CONSTRAINTS
-- ============================================

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


-- ============================================
-- 5. VIEW FOREIGN KEY RELATIONSHIPS
-- ============================================

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


-- ============================================
-- 6. VIEW ALL TABLE CONSTRAINTS
-- ============================================

SELECT
    table_name,
    constraint_name,
    constraint_type
FROM information_schema.table_constraints
WHERE table_schema = 'public'
ORDER BY table_name, constraint_type;


-- ============================================
-- 7. VIEW DATABASE INDEXES
-- ============================================

SELECT
    schemaname,
    tablename,
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename, indexname;


-- ============================================
-- 8. VIEW DATABASE INFORMATION
-- ============================================

SELECT current_database() AS database_name;

SELECT current_user AS database_user;

SELECT version() AS postgresql_version;


-- ============================================
-- 9. COUNT TABLES IN THE DATABASE
-- ============================================

SELECT
    COUNT(*) AS total_tables
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_type = 'BASE TABLE';


-- ============================================
-- 10. VIEW TABLE SIZES
-- ============================================

SELECT
    schemaname,
    tablename,
    pg_size_pretty(
        pg_total_relation_size(
            format('%I.%I', schemaname, tablename)::regclass
        )
    ) AS total_size
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY tablename;


-- ============================================
-- 11. VIEW ER DIAGRAM
-- ============================================

-- ER diagrams are created using pgAdmin.
--
-- Steps:
-- 1. Open pgAdmin.
-- 2. Connect to PostgreSQL.
-- 3. Select the database.
-- 4. Open the ERD Tool.
-- 5. Add the required tables.
-- 6. Examine primary and foreign key relationships.
--
-- ER diagrams cannot be displayed directly
-- using a standard SQL SELECT query.
