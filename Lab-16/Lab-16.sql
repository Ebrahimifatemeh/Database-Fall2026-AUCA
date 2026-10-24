DROP SCHEMA IF EXISTS lab16 CASCADE;
CREATE SCHEMA lab16;
SET search_path TO lab16, public;

CREATE TABLE accounts (
  account_id integer PRIMARY KEY,
  owner_name text NOT NULL,
  balance numeric(12,2) NOT NULL CHECK (balance >= 0)
);
CREATE TABLE transfer_log (
  transfer_id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  sender_id integer NOT NULL REFERENCES accounts(account_id),
  receiver_id integer NOT NULL REFERENCES accounts(account_id),
  amount numeric(12,2) NOT NULL CHECK (amount > 0),
  created_at timestamptz NOT NULL DEFAULT now()
);
CREATE TABLE products (
  product_id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name text NOT NULL,
  price numeric(10,2) NOT NULL CHECK (price >= 0)
);
INSERT INTO accounts VALUES (1,'Alice',1000.00),(2,'Bob',500.00),(3,'Carol',250.00);
SELECT * FROM accounts ORDER BY account_id;

-- 1. BEGIN / COMMIT: transfer $100 atomically.
BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE account_id = 1 AND balance >= 100;
UPDATE accounts SET balance = balance + 100 WHERE account_id = 2;
INSERT INTO transfer_log(sender_id,receiver_id,amount) VALUES (1,2,100);
COMMIT;
SELECT * FROM accounts ORDER BY account_id;
SELECT * FROM transfer_log;

-- 2. ROLLBACK: undo a provisional transfer.
BEGIN;
UPDATE accounts SET balance = balance - 50 WHERE account_id = 2;
UPDATE accounts SET balance = balance + 50 WHERE account_id = 3;
SELECT * FROM accounts ORDER BY account_id; -- provisional balances
ROLLBACK;
SELECT * FROM accounts ORDER BY account_id; -- unchanged after rollback

-- 3. SAVEPOINT: keep a valid insert, discard a later insert.
BEGIN;
INSERT INTO products(name,price) VALUES ('Laptop',999.99);
SAVEPOINT before_optional_product;
INSERT INTO products(name,price) VALUES ('Mouse',25.99);
ROLLBACK TO SAVEPOINT before_optional_product;
INSERT INTO products(name,price) VALUES ('Keyboard',79.99);
RELEASE SAVEPOINT before_optional_product;
COMMIT;
SELECT * FROM products ORDER BY product_id;

-- 4. Consistency: CHECK constraints and foreign keys enforce valid data.
-- The following statements would fail; leave commented to keep the lab runnable.
-- INSERT INTO accounts VALUES (4,'Invalid',-10);
-- INSERT INTO transfer_log(sender_id,receiver_id,amount) VALUES (999,1,20);

-- 5. Transaction-safe transfer with balance checks and row locking.
-- A PL/pgSQL DO block runs atomically as one statement.
DO $$
DECLARE
  amount_to_send numeric(12,2) := 75;
  sender_balance numeric(12,2);
BEGIN
  -- Lock both accounts in a stable order to reduce deadlock risk.
  PERFORM 1 FROM accounts WHERE account_id IN (1,3) ORDER BY account_id FOR UPDATE;
  SELECT balance INTO sender_balance FROM accounts WHERE account_id = 1;
  IF sender_balance IS NULL OR sender_balance < amount_to_send THEN
    RAISE EXCEPTION 'Insufficient funds or missing sender';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM accounts WHERE account_id = 3) THEN
    RAISE EXCEPTION 'Receiver does not exist';
  END IF;
  UPDATE accounts SET balance = balance - amount_to_send WHERE account_id = 1;
  UPDATE accounts SET balance = balance + amount_to_send WHERE account_id = 3;
  INSERT INTO transfer_log(sender_id,receiver_id,amount)
  VALUES (1,3,amount_to_send);
END $$;
SELECT * FROM accounts ORDER BY account_id;

-- 6. Isolation levels: separate transactions, run one at a time.
-- PostgreSQL maps READ UNCOMMITTED to READ COMMITTED; it does not allow dirty reads.
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED READ ONLY;
SELECT * FROM accounts ORDER BY account_id;
COMMIT;

BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ READ ONLY;
SELECT * FROM accounts ORDER BY account_id;
COMMIT;

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE READ ONLY;
SELECT SUM(balance) AS total_balance FROM accounts;
COMMIT;

-- 7. Durability: committed data remains visible to later transactions.
SELECT COUNT(*) AS committed_transfers FROM transfer_log;
SELECT SUM(balance) AS total_money FROM accounts; -- 1750.00 throughout transfers

-- 8. Inspect session isolation level and current locks.
SHOW transaction_isolation;
SELECT locktype, mode, granted FROM pg_locks WHERE pid = pg_backend_pid() LIMIT 10;
-- To observe concurrent behavior, use two independent psql sessions.
