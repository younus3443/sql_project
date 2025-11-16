CREATE USER ipl_user WITH PASSWORD 'ipl_password';
CREATE DATABASE ipl_db OWNER ipl_user;
GRANT ALL PRIVILEGES ON DATABASE ipl_db TO ipl_user;
