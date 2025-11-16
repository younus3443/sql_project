-- 02_cleanup.sql
-- Run this as postgres superuser

-- 1. Disconnect active users
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'ipl_db';

-- 2. Drop database
DROP DATABASE IF EXISTS ipl_db;

-- 3. Drop user
DROP USER IF EXISTS ipl_user;
