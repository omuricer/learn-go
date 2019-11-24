SET CHARACTER_SET_CLIENT = utf8mb4;
SET CHARACTER_SET_CONNECTION = utf8mb4;

CREATE USER 'letter' IDENTIFIED BY 'letter';
GRANT ALL PRIVILEGES ON letter.* TO 'letter';
ALTER USER 'letter'@'%' IDENTIFIED WITH mysql_native_password BY 'letter';
