USE `account_db`;
SET CHARACTER_SET_CLIENT = utf8mb4;
SET CHARACTER_SET_CONNECTION = utf8mb4;

--
-- Table structure for table `account_divs`
--
DROP TABLE IF EXISTS `account_divs`;
CREATE TABLE `account_divs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `div` varchar(2) NOT NULL COMMENT 'アカウント区分',
  `start` datetime NOT NULL COMMENT '適用開始日',
  `end` datetime NOT NULL DEFAULT '9999-12-31 23:59:59' COMMENT '適用終了日',
  `created_by` varchar(40) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` varchar(40) DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `account_div` (`div`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='アカウント区分';


--
-- Table structure for table `account_locks`
--
DROP TABLE IF EXISTS `account_locks`;
CREATE TABLE `account_locks` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `accounts_id` int(11) NOT NULL,
  `failed_count` int(11) NOT NULL,
  `is_locked` char(1) NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL DEFAULT '9999-12-31 23:59:59',
  `created_by` varchar(40) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` varchar(40) DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `account_id` (`accounts_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


--
-- Table structure for table `accounts`
--
DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail` varchar(256) NOT NULL COMMENT 'メールアドレス（ID）',
  `password` varchar(64) NOT NULL COMMENT 'パスワードハッシュ',
  `div` varchar(2) DEFAULT NULL COMMENT 'アカウント区分',
  `cancelled` datetime NOT NULL DEFAULT  '9999-12-31 23:59:59' COMMENT '退会日時',
  `facebook_id` varchar(50) COMMENT 'Facebook ID',
  `line_id` varchar(50) COMMENT 'LINE ID',
  `wechat_id` varchar(50) COMMENT '微信 ID',
  `created_by` varchar(40) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(40) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='アカウント';


--
-- Table structure for table `billings`
--
DROP TABLE IF EXISTS `billings`;
CREATE TABLE `billings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `accounts_id` int(11) NOT NULL COMMENT 'アカウントID',
  `contracts_id` bigint(20) NOT NULL COMMENT '契約ID',
  `name` varchar(100) NOT NULL COMMENT '請求名',
  `amount` int(11) NOT NULL COMMENT '請求金額',
  `payment_method_code` varchar(2) NOT NULL COMMENT '支払方法コード',
  `payment_method_id` int(11) NOT NULL COMMENT '支払方法ID',
  `entry_month` varchar(6) DEFAULT NULL COMMENT '請求月',
  `status` char(1) NOT NULL COMMENT '請求ステータス',
  `created_by` varchar(40) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(40) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `paymethod_cd` (`payment_method_code`,`entry_month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='請求';


--
-- Table structure for table `contracts`
--
DROP TABLE IF EXISTS `contracts`;
CREATE TABLE `contracts` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `accounts_id` int(11) NOT NULL COMMENT 'アカウントID',
  `plans_code` varchar(2) NOT NULL COMMENT 'プランコード',
  `start` datetime NOT NULL COMMENT '利用開始日',
  `end` datetime NOT NULL DEFAULT '9999-12-31 23:59:59' COMMENT '利用終了日',
  `created_by` varchar(40) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(40) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cancelled_date` (`end`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='契約';


--
-- Table structure for table `credit_cards`
--
DROP TABLE IF EXISTS `credit_cards`;
CREATE TABLE `credit_cards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gmo_member_entry_id` bigint(20) COMMENT 'GMO会員番号',
  `card_seq` int(11) NOT NULL DEFAULT '0' COMMENT 'GMOカード連番',
  `card_no` varchar(20) NOT NULL COMMENT 'マスク済みカード番号',
  `last_check_date` date COMMENT '有効性チェック日時',
  `upd_ng_flag` char(1) NOT NULL DEFAULT '0' COMMENT '洗替NGでフラグ',
  `created_by` varchar(40) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` varchar(40) DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `member_entry_id` (`gmo_member_entry_id`,`card_seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='クレジットカード';


--
-- Table structure for table `m_members`
--
DROP TABLE IF EXISTS `m_members`;
CREATE TABLE `m_members` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_entry_id` bigint(20) NOT NULL,
  `member_name` varchar(255) DEFAULT NULL,
  `delete_flag` char(1) NOT NULL DEFAULT '0',
  `created_by` varchar(40) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` varchar(40) DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


--
-- Table structure for table `m_ng_words`
--
DROP TABLE IF EXISTS `m_ng_words`;
CREATE TABLE `m_ng_words` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ng_word` varchar(255) NOT NULL,
  `delete_flag` char(1) NOT NULL DEFAULT '0',
  `created_by` varchar(40) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` varchar(40) DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ng_word` (`ng_word`,`delete_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


--
-- Table structure for table `oauth_access_tokens`
--
DROP TABLE IF EXISTS `oauth_access_tokens`;
CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `client_id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


--
-- Table structure for table `oauth_auth_codes`
--
DROP TABLE IF EXISTS `oauth_auth_codes`;
CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(10) unsigned NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


--
-- Table structure for table `oauth_clients`
--
DROP TABLE IF EXISTS `oauth_clients`;
CREATE TABLE `oauth_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


--
-- Table structure for table `oauth_personal_access_clients`
--
DROP TABLE IF EXISTS `oauth_personal_access_clients`;
CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_personal_access_clients_client_id_index` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


--
-- Table structure for table `oauth_refresh_tokens`
--
DROP TABLE IF EXISTS `oauth_refresh_tokens`;
CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


--
-- Table structure for table `password_resets`
--
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


--
-- Table structure for table `payment_methods`
--
DROP TABLE IF EXISTS `payment_methods`;
CREATE TABLE `payment_methods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(2) NOT NULL COMMENT '支払方法コード',
  `name` varchar(100) NOT NULL COMMENT '支払方法名',
  `running_available_flag` char(1) NOT NULL,
  `start` datetime NOT NULL COMMENT '適用開始日',
  `end` datetime NOT NULL DEFAULT '9999-12-31 23:59:59' COMMENT '適用終了日',
  `created_by` varchar(40) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` varchar(40) DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='支払方法';


--
-- Table structure for table `plans`
--
DROP TABLE IF EXISTS `plans`;
CREATE TABLE `plans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `locale` varchar(2) NOT NULL COMMENT 'プランコード',
  `code` varchar(2) NOT NULL COMMENT 'プランコード',
  `name` varchar(100) NOT NULL COMMENT 'プラン名',
  `price_exc_tax` int(11) NOT NULL COMMENT '利用料（税抜）',
  `price_inc_tax` int(11) DEFAULT NULL COMMENT '利用料（税込）',
  `supply_days` int(11) DEFAULT NULL COMMENT '利用日数',
  `is_paid` char(1) NOT NULL COMMENT '有料フラグ',
  `is_subscription` char(1) NOT NULL COMMENT 'サブスクリプションフラグ',
  `start` datetime NOT NULL COMMENT '適用開始日',
  `end` datetime NOT NULL DEFAULT '9999-12-31 23:59:59' COMMENT '適用終了日',
  `created_by` varchar(40) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` varchar(40) DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `contract_cd` (`code`),
  KEY `contract_cd_2` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='プラン';


--
-- Table structure for table `preferences`
--
DROP TABLE IF EXISTS `preferences`;
CREATE TABLE `preferences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(20) NOT NULL,
  `value` json NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `created_by` varchar(40) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` varchar(40) DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='設定';


--
-- Table structure for table `sessions`
--
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL,
  UNIQUE KEY `sessions_id_unique` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
;


--
-- Table structure for table `t_card_deletes`
--
DROP TABLE IF EXISTS `t_card_deletes`;
CREATE TABLE `t_card_deletes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_entry_id` bigint(20) NOT NULL,
  `seq_mode_flag` char(1) DEFAULT NULL,
  `card_seq` char(4) NOT NULL,
  `error_code` text,
  `error_detail_code` text,
  `created_by` varchar(40) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` varchar(40) DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


--
-- Table structure for table `t_card_entries`
--
DROP TABLE IF EXISTS `t_card_entries`;
CREATE TABLE `t_card_entries` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_entry_id` bigint(20) NOT NULL,
  `card_seq` int(11) NOT NULL,
  `running_flag` char(1) NOT NULL,
  `card_comp_name` varchar(100) DEFAULT NULL,
  `card_no` text NOT NULL,
  `hash_card_no` varchar(64) NOT NULL,
  `card_password` varchar(20) DEFAULT NULL,
  `expire_month` char(4) NOT NULL,
  `holder_name` varchar(50) DEFAULT NULL,
  `forward_comp_code` varchar(7) DEFAULT NULL,
  `error_code` text,
  `error_detail_code` text,
  `created_by` varchar(40) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` varchar(40) DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


--
-- Table structure for table `t_card_run_entries`
--
DROP TABLE IF EXISTS `t_card_run_entries`;
CREATE TABLE `t_card_run_entries` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `billing_id` bigint(20) NOT NULL,
  `entry_month` varchar(6) NOT NULL,
  `member_entry_id` bigint(20) NOT NULL,
  `card_seq` int(11) NOT NULL,
  `card_no` text NOT NULL,
  `hash_card_no` varchar(64) NOT NULL,
  `use_date` char(8) NOT NULL,
  `order_id` varchar(27) NOT NULL,
  `item_code` varchar(7) DEFAULT NULL,
  `price` int(11) NOT NULL,
  `flex1` varchar(100) DEFAULT NULL,
  `flex2` varchar(100) DEFAULT NULL,
  `flex3` varchar(100) DEFAULT NULL,
  `auth_seq` char(5) NOT NULL,
  `card_run_entry_id` bigint(20) DEFAULT NULL,
  `process_seq` varchar(7) DEFAULT NULL,
  `process_result` char(1) DEFAULT NULL,
  `forward_comp_code` varchar(7) DEFAULT NULL,
  `auth_result` varchar(9) DEFAULT NULL,
  `delete_flag` char(1) NOT NULL DEFAULT '0',
  `created_by` varchar(40) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` varchar(40) DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hash_card_no` (`hash_card_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


--
-- Table structure for table `gmo_members_entries`
--
DROP TABLE IF EXISTS `gmo_members_entries`;
CREATE TABLE `gmo_members_entries` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_name` varchar(100) DEFAULT NULL,
  `error_code` text,
  `error_detail_code` text,
  `created_by` varchar(40) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` varchar(40) DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


--
-- Table structure for table `t_tradedcard_entries`
--
DROP TABLE IF EXISTS `t_tradedcard_entries`;
CREATE TABLE `t_tradedcard_entries` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(27) NOT NULL,
  `member_entry_id` bigint(20) NOT NULL,
  `seq_mode_flag` char(1) DEFAULT NULL,
  `running_flag` char(1) NOT NULL,
  `holder_name` text,
  `hash_holder_name` varchar(64) DEFAULT NULL,
  `card_seq` char(4) DEFAULT NULL,
  `card_no` text,
  `hash_card_no` varchar(64) DEFAULT NULL,
  `forward_comp_code` varchar(7) DEFAULT NULL,
  `error_code` text,
  `error_detail_code` text,
  `created_by` varchar(40) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` varchar(40) DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


--
-- Table structure for table `gmo_transaction_entries`
--
DROP TABLE IF EXISTS `gmo_transaction_entries`;
CREATE TABLE `gmo_transaction_entries` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(27) NOT NULL,
  `job_cd` varchar(7) NOT NULL,
  `item_code` varchar(7) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `tax` int(11) DEFAULT NULL,
  `td_flag` char(1) DEFAULT NULL,
  `td_tenant_name` varchar(25) DEFAULT NULL,
  `access_id` varchar(32) DEFAULT NULL,
  `access_pass` varchar(32) DEFAULT NULL,
  `error_code` text,
  `error_detail_code` text,
  `created_by` varchar(40) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` varchar(40) DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


--
-- Table structure for table `gmo_transaction_exes`
--
DROP TABLE IF EXISTS `gmo_transaction_exes`;
CREATE TABLE `gmo_transaction_exes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `access_id` varchar(32) NOT NULL,
  `access_pass` varchar(32) NOT NULL,
  `order_id` varchar(27) NOT NULL,
  `job_cd` char(1) DEFAULT NULL,
  `item_cd` int(11) DEFAULT NULL,
  `card_no` text,
  `hash_card_no` varchar(64) DEFAULT NULL,
  `expire_month` char(4) DEFAULT NULL,
  `security_cd` varchar(4) DEFAULT NULL,
  `token` varchar(256) DEFAULT NULL,
  `pin` varchar(25) DEFAULT NULL,
  `site_free_column1` varchar(100) DEFAULT NULL,
  `site_free_column2` varchar(100) DEFAULT NULL,
  `site_free_column3` varchar(100) DEFAULT NULL,
  `flex_return_flag` char(1) DEFAULT NULL,
  `acs_flag` char(1) DEFAULT NULL,
  `forward_comp_code` varchar(7) DEFAULT NULL,
  `approve_number` varchar(7) DEFAULT NULL,
  `tran_id` varchar(28) DEFAULT NULL,
  `tran_date` varchar(14) DEFAULT NULL,
  `check_string` varchar(32) DEFAULT NULL,
  `error_code` text,
  `error_detail_code` text,
  `created_by` varchar(40) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` varchar(40) DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


--
-- Table structure for table `t_upcard_entries`
--
DROP TABLE IF EXISTS `t_upcard_entries`;
CREATE TABLE `t_upcard_entries` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `entry_month` varchar(6) NOT NULL,
  `member_entry_id` bigint(20) NOT NULL,
  `card_seq` int(11) NOT NULL,
  `updcard_entry_id` bigint(20) DEFAULT NULL,
  `last_card_no` text,
  `last_expire_month` char(4) DEFAULT NULL,
  `last_comp_name` varchar(100) DEFAULT NULL,
  `last_comp_code` varchar(7) DEFAULT NULL,
  `upd_result` char(1) DEFAULT NULL,
  `new_card_no` text,
  `new_expire_month` char(4) DEFAULT NULL,
  `new_comp_code` varchar(7) DEFAULT NULL,
  `upd_date` datetime DEFAULT NULL,
  `process_seq` varchar(7) DEFAULT NULL,
  `delete_flag` char(1) NOT NULL DEFAULT '0',
  `created_by` varchar(40) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` varchar(40) DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `member_entry_id` (`member_entry_id`,`card_seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


--
-- Table structure for table `t_upcard_exes`
--
DROP TABLE IF EXISTS `t_upcard_exes`;
CREATE TABLE `t_upcard_exes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(256) NOT NULL,
  `entry_month` varchar(6) NOT NULL,
  `command_div` char(1) NOT NULL,
  `last_comp_name` varchar(100) NOT NULL,
  `last_card_no` varchar(64) NOT NULL,
  `new_comp_name` varchar(100) DEFAULT NULL,
  `new_card_no` varchar(64) DEFAULT NULL,
  `new_expire_month` char(4) DEFAULT NULL,
  `process_result` char(1) DEFAULT NULL,
  `process_count` int(11) DEFAULT NULL,
  `process_date` datetime DEFAULT NULL,
  `delete_flag` char(1) NOT NULL DEFAULT '0',
  `created_by` varchar(40) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` varchar(40) DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


--
-- Table structure for table `users`
--
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


--
-- Table structure for table `w_card_run_entries`
--
DROP TABLE IF EXISTS `w_card_run_entries`;
CREATE TABLE `w_card_run_entries` (
  `shop_id` varchar(13) NOT NULL,
  `member_entry_id` bigint(20) NOT NULL,
  `card_seq` int(11) NOT NULL,
  `deal_code` char(1) NOT NULL,
  `use_date` char(8) NOT NULL,
  `order_id` varchar(27) NOT NULL,
  `item_code` varchar(7) NOT NULL,
  `price` int(11) NOT NULL,
  `other_price` int(11) NOT NULL,
  `method_of_payment` char(1) NOT NULL,
  `flex1` varchar(100) NOT NULL,
  `flex2` varchar(100) NOT NULL,
  `flex3` varchar(100) NOT NULL,
  `auth_seq` char(5) NOT NULL,
  `card_run_entry_id` bigint(20) NOT NULL,
  `process_seq` varchar(7) NOT NULL,
  `process_result` char(1) NOT NULL,
  `forward_comp_code` varchar(7) NOT NULL,
  `auth_result` varchar(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


--
-- Table structure for table `ssids`
--
DROP TABLE IF EXISTS `ssids`;
CREATE TABLE `ssids` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ssid` varchar(31) NOT NULL COMMENT 'SSID',
  `password` varchar(63) NOT NULL COMMENT 'パスワード',
  `status` varchar(1) NOT NULL COMMENT 'ステータス',
  `start` datetime NOT NULL COMMENT '利用開始日',
  `end` datetime NOT NULL COMMENT '利用終了日',
  `activated_at` datetime COMMENT 'SSID登録',
  `inactivated_at` datetime COMMENT 'SSID削除',
  `created_by` varchar(40) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` varchar(40) DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='SSID';
create index index_ssids_status on ssids(status);


--
-- Table structure for table `macaddresses`
--
DROP TABLE IF EXISTS `macaddresses`;
CREATE TABLE `macaddresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `macaddress` bigint(8) NOT NULL COMMENT 'MACアドレス（バイナリ形式のためhex(macaddress)で取得）',
  `status` varchar(1) NOT NULL COMMENT 'ステータス（0:未有効化、1:有効、2:無効）',
  `start` datetime NOT NULL COMMENT '利用開始日',
  `end` datetime NOT NULL COMMENT '利用終了日',
  `activated_at` datetime COMMENT '有効化日時',
  `inactivated_at` datetime COMMENT '無効化日時',
  `created_by` varchar(40) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` varchar(40) DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='MACアドレス';
create index index_macaddresses_status on macaddresses(status);

--
-- Table structure for table `account_macaddresses`
--
DROP TABLE IF EXISTS `account_macaddresses`;
CREATE TABLE `account_macaddresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accounts_id` int(11) NOT NULL COMMENT 'アカウントID',
  `macadresses_id` int(11) NOT NULL COMMENT 'MACアドレスID',
  `created_by` varchar(40) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` varchar(40) DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='アカウント・MACアドレス関連';
create index index_account_macaddresses_accounts_id on account_macaddresses(accounts_id);
