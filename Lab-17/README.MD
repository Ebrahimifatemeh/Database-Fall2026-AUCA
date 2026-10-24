Lab 17 — Data Import, Export and Backup (PostgreSQL)

Objective

Practice CSV import/export concepts, staging-table migration, validation, and safe database backup and restore workflows.

Topics from the course handout

COPY TO / COPY FROM and CSV formatting

Client-side \copy versus server-side COPY

pg_dump and pg_restore

Full logical backups and backup validation

WAL archiving, base backups, incremental-backup concepts, and point-in-time recovery (PITR)

Data migration strategies: dump/restore, logical replication, physical replication, and ETL

Files

lab17.sql — self-contained SQL examples, sample data, staging/merge, CSV export to STDOUT, and validation.

lab17_psql_commands.txt — optional interactive psql commands for writing/reading local CSV files.

Run the SQL lab

Connect to a practice database in pgAdmin or psql and execute lab17.sql.

psql -v ON_ERROR_STOP=1 -d your_practice_database -f lab17.sql

Warning: lab17.sql deletes and recreates the lab17 schema. The CSV exports to STDOUT display CSV output without needing server filesystem privileges.

Export and import a CSV on your computer

In an interactive psql session, use the commands in lab17_psql_commands.txt. For example:

\copy (SELECT * FROM lab17.customers ORDER BY customer_id) TO 'customers.csv' WITH (FORMAT csv, HEADER true)
\copy lab17.staging_customers TO 'staging.csv' WITH (FORMAT csv, HEADER true)

\copy is a psql command, not SQL; it will not work as SQL in pgAdmin's Query Tool. Server-side COPY ... TO '/path' uses the database server's filesystem and requires additional privileges.

Backup and restore (run in your terminal, not the SQL editor)

Replace the database name and username with your own values. Keep backups in a safe location.

Custom-format backup:

pg_dump -U your_user -d your_practice_database -Fc -f lab17_backup.dump

Check that PostgreSQL can read the backup archive:

pg_restore --list lab17_backup.dump

Restore into a separate, empty practice database:

createdb -U your_user lab17_restore_test
pg_restore -U your_user -d lab17_restore_test --no-owner --no-privileges lab17_backup.dump

Plain SQL alternative:

pg_dump -U your_user -d your_practice_database -f lab17_backup.sql
psql -U your_user -d lab17_restore_test -f lab17_backup.sql

Do not restore both formats into the same database without first resetting it. pg_restore is for archive formats; use psql for plain SQL dumps. Restoring a whole-database dump can recreate objects outside lab17 if your practice database contains other schemas.

Advanced backup topics (theory / administrator-controlled)

Full logical backup: pg_dump for one database; pg_dumpall for a cluster's logical contents.

WAL and physical base backups: pg_basebackup and WAL archiving support physical recovery and PITR. These require replication permissions and server configuration.

PITR: Restore a physical base backup and replay WAL to a target time. Do not delete or replace a PostgreSQL data directory for this class exercise.

Migration: dump/restore is straightforward; logical replication can reduce downtime; physical replication maintains a standby; ETL uses staging tables and validation.

Incremental backup: Not the same as a pg_dump backup; WAL archiving supports continuous recovery, and version-specific physical incremental-backup features may be available.

Validation checklist

CSV headers and column order match the destination table.

Imported values satisfy primary-key, unique, and foreign-key constraints.

Row counts match expected results.

Backup archives can be listed and, ideally, restored to a separate test database.

Credentials and actual backup files are not committed to GitHub.

Learning outcomes

I practiced exporting SQL query results, preparing staging data, validating and merging imported rows, and understanding PostgreSQL backup and recovery tools. I also learned why a tested restore is essential to a reliable backup strategy.
