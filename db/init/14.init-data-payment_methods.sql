USE `account_db`;
SET CHARACTER_SET_CLIENT = utf8mb4;
SET CHARACTER_SET_CONNECTION = utf8mb4;

insert into payment_methods (code, name, running_available_flag, start, end, created_by , created_at, updated_by, updated_at ) values ('10', 'クレジットカード', '1', '2019-07-01 00:00:00', '2099-12-31 23:59:59','mmy100','2019-07-01 00:00:00','mmy100','2019-07-01 00:00:00');