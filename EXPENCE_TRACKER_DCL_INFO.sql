
--
DROP SCHEMA IF EXISTS expence_tracker CASCADE;
--CREATE SCHEMA IF NOT EXISTS expence_tracker AUTHORIZATION expense_tracker_group;
CREATE SCHEMA IF NOT EXISTS expence_tracker

-- create user group
CREATE ROLE expense_tracker_group;
GRANT CONNECT on DATABASE postgres TO expense_tracker_group;
GRANT ALL PRIVILEGES ON SCHEMA expence_tracker TO expense_tracker_group;

ALTER SCHEMA expence_tracker OWNER TO expense_tracker_group;

--create user
CREATE ROLE expense_tracker_user login PASSWORD 'mnbewjk4ernmzx';
REVOKE ALL PRIVILEGES ON SCHEMA public FROM expense_tracker_user;
GRANT expense_tracker_group TO expense_tracker_user
