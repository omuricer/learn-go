SET CHARACTER_SET_CLIENT = utf8mb4;
SET CHARACTER_SET_CONNECTION = utf8mb4;

CREATE USER 'account' IDENTIFIED BY 'account';
GRANT ALL PRIVILEGES ON account_db.* TO 'account';
ALTER USER 'account'@'%' IDENTIFIED WITH mysql_native_password BY 'account';
