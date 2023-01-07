-- Adminer 4.8.1 MySQL 5.7.39 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

CREATE DATABASE `juno` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin */;
USE `juno`;

DROP TABLE IF EXISTS `access_token`;
CREATE TABLE `access_token` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `name` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  `app_id` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  `secret` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_id` (`app_id`),
  UNIQUE KEY `idx_unique_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `app`;
CREATE TABLE `app` (
  `aid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `gid` bigint(20) NOT NULL COMMENT 'gitlab id',
  `name` varchar(191) COLLATE utf8mb4_bin NOT NULL COMMENT '项目中文名',
  `app_name` varchar(191) COLLATE utf8mb4_bin NOT NULL COMMENT '项目英文唯一标识名',
  `create_time` bigint(20) NOT NULL COMMENT '创建时间',
  `update_time` bigint(20) NOT NULL COMMENT '更新时间',
  `level` bigint(20) NOT NULL COMMENT '层级',
  `lang` longtext COLLATE utf8mb4_bin NOT NULL COMMENT '语言',
  `biz_domain` longtext COLLATE utf8mb4_bin NOT NULL COMMENT '业务类型',
  `created_by` bigint(20) NOT NULL COMMENT '创建者',
  `updated_by` bigint(20) NOT NULL COMMENT '更新者',
  `http_port` longtext COLLATE utf8mb4_bin NOT NULL COMMENT 'HTTP端口号',
  `rpc_port` longtext COLLATE utf8mb4_bin NOT NULL COMMENT 'RPC端口号',
  `govern_port` longtext COLLATE utf8mb4_bin NOT NULL COMMENT '治理端口号',
  `hook_id` bigint(20) NOT NULL COMMENT '钩子',
  `users` json NOT NULL COMMENT '业务负责人',
  `web_url` longtext COLLATE utf8mb4_bin NOT NULL,
  `proto_dir` longtext COLLATE utf8mb4_bin NOT NULL,
  `git_url` longtext COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`aid`),
  KEY `idx_app_name` (`name`),
  KEY `idx_app_app_name` (`app_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `app` (`aid`, `gid`, `name`, `app_name`, `create_time`, `update_time`, `level`, `lang`, `biz_domain`, `created_by`, `updated_by`, `http_port`, `rpc_port`, `govern_port`, `hook_id`, `users`, `web_url`, `proto_dir`, `git_url`) VALUES
(1,	1,	'jupiter-demo',	'jupiter-demo',	1673064118,	1673064118,	1,	'go',	'直播系统',	0,	0,	'8011',	'8012',	'9999',	0,	'[\"askuy\", \"lvchao\", \"duminxiang\"]',	'https://github.com/douyu/jupiter-demo',	'',	'git@github.com/douyu/jupiter-demo.git'),
(2,	2,	'juno-admin',	'juno-admin',	1673064118,	1673064118,	1,	'go',	'直播系统',	0,	0,	'50000',	'0',	'50004',	0,	'[\"askuy\", \"mex\"]',	'https://github.com/douyu/juno',	'',	'git@github.com/douyu/juno.git');

DROP TABLE IF EXISTS `app_change_map`;
CREATE TABLE `app_change_map` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(191) COLLATE utf8mb4_bin NOT NULL,
  `md5` varchar(191) COLLATE utf8mb4_bin NOT NULL,
  `updated_at` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_app_change_map_app_name` (`app_name`),
  KEY `idx_app_change_map_md5` (`md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `app_change_map` (`id`, `app_name`, `md5`, `updated_at`) VALUES
(3,	'jupiter-demo',	'23de0483bcc83e69d2f83a9583572b8c',	1673064118),
(4,	'juno-admin',	'af66bc40d197e6b69c37a956d312dd5e',	1673064118);

DROP TABLE IF EXISTS `app_event`;
CREATE TABLE `app_event` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(191) COLLATE utf8mb4_bin NOT NULL,
  `aid` bigint(20) NOT NULL,
  `zone_code` varchar(191) COLLATE utf8mb4_bin NOT NULL,
  `env` varchar(191) COLLATE utf8mb4_bin NOT NULL,
  `host_name` longtext COLLATE utf8mb4_bin NOT NULL,
  `operator_type` varchar(191) COLLATE utf8mb4_bin NOT NULL DEFAULT 'user',
  `user_name` longtext COLLATE utf8mb4_bin NOT NULL,
  `uid` bigint(20) NOT NULL,
  `operation` varchar(191) COLLATE utf8mb4_bin NOT NULL,
  `create_time` bigint(20) DEFAULT NULL,
  `source` varchar(191) COLLATE utf8mb4_bin NOT NULL,
  `metadata` text COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_source` (`source`),
  KEY `idx_app_name` (`app_name`),
  KEY `idx_aid` (`aid`),
  KEY `idx_zone_code` (`zone_code`),
  KEY `idx_env` (`env`),
  KEY `idx_operation` (`operation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `app_event` (`id`, `app_name`, `aid`, `zone_code`, `env`, `host_name`, `operator_type`, `user_name`, `uid`, `operation`, `create_time`, `source`, `metadata`) VALUES
(1,	'',	0,	'cn-wuhan-guanggu-f1',	'dev',	'wuhan-host-1-1',	'user',	'',	0,	'cmdb_node_create',	1673061235,	'cmdb',	'{\"id\":1,\"host_name\":\"wuhan-host-1-1\",\"ip\":\"192.168.1.1\",\"create_time\":1673061235,\"update_time\":1673061235,\"env\":\"dev\",\"region_code\":\"cn-wuhan\",\"region_name\":\"武汉\",\"zone_code\":\"cn-wuhan-guanggu-f1\",\"zone_name\":\"武汉光谷F1区\",\"agent_heartbeat_time\":0,\"proxy_heartbeat_time\":0,\"node_type\":1,\"agent_type\":0,\"agent_version\":\"\",\"proxy_type\":0,\"proxy_version\":\"\"}'),
(2,	'',	0,	'cn-wuhan-guanggu-f1',	'dev',	'wuhan-host-1-1',	'user',	'',	0,	'cmdb_app_node_create',	1673061235,	'cmdb',	'{\"id\":1,\"app_name\":\"\",\"aid\":0,\"host_name\":\"wuhan-host-1-1\",\"ip\":\"192.168.1.1\",\"device_id\":0,\"env\":\"dev\",\"region_code\":\"cn-wuhan\",\"region_name\":\"武汉\",\"zone_code\":\"cn-wuhan-guanggu-f1\",\"zone_name\":\"武汉光谷F1区\",\"create_time\":1673061235,\"update_time\":1673061235}'),
(3,	'',	0,	'',	'',	'',	'user',	'',	0,	'cmdb_app_node_delete',	1673061235,	'cmdb',	'{\"id\":0,\"app_name\":\"\",\"aid\":0,\"host_name\":\"\",\"ip\":\"\",\"device_id\":0,\"env\":\"\",\"region_code\":\"\",\"region_name\":\"\",\"zone_code\":\"\",\"zone_name\":\"\",\"create_time\":0,\"update_time\":0}'),
(4,	'',	0,	'',	'',	'',	'user',	'',	0,	'cmdb_user_create',	1673061235,	'cmdb',	'{\"uid\":1,\"id\":0,\"username\":\"admin\",\"nickname\":\"admin\",\"secret\":\"\",\"email\":\"\",\"avatar\":\"\",\"webUrl\":\"\",\"state\":\"\",\"hash\":\"\",\"createTime\":1673061235,\"updateTime\":1673061235,\"oauth\":\"\",\"oauthId\":\"\",\"password\":\"$2a$10$r9DQ07wk24/Pzkf99OR2huTT/4SbJp.pckSvQMl7bC7OXgOn1NZRi\",\"currentAuthority\":\"\",\"access\":\"admin\"}'),
(5,	'',	0,	'cn-wuhan-guanggu-f1',	'dev',	'wuhan-host-1-1',	'user',	'',	0,	'cmdb_app_node_create',	1673063158,	'cmdb',	'{\"id\":2,\"app_name\":\"\",\"aid\":0,\"host_name\":\"wuhan-host-1-1\",\"ip\":\"192.168.1.1\",\"device_id\":0,\"env\":\"dev\",\"region_code\":\"cn-wuhan\",\"region_name\":\"武汉\",\"zone_code\":\"cn-wuhan-guanggu-f1\",\"zone_name\":\"武汉光谷F1区\",\"create_time\":1673063158,\"update_time\":1673063158}'),
(6,	'',	0,	'',	'',	'',	'user',	'',	0,	'cmdb_app_node_delete',	1673063158,	'cmdb',	'{\"id\":0,\"app_name\":\"\",\"aid\":0,\"host_name\":\"\",\"ip\":\"\",\"device_id\":0,\"env\":\"\",\"region_code\":\"\",\"region_name\":\"\",\"zone_code\":\"\",\"zone_name\":\"\",\"create_time\":0,\"update_time\":0}'),
(7,	'',	0,	'cn-wuhan-guanggu-f1',	'dev',	'wuhan-host-1-1',	'user',	'',	0,	'cmdb_app_node_create',	1673063919,	'cmdb',	'{\"id\":3,\"app_name\":\"\",\"aid\":0,\"host_name\":\"wuhan-host-1-1\",\"ip\":\"192.168.1.1\",\"device_id\":0,\"env\":\"dev\",\"region_code\":\"cn-wuhan\",\"region_name\":\"武汉\",\"zone_code\":\"cn-wuhan-guanggu-f1\",\"zone_name\":\"武汉光谷F1区\",\"create_time\":1673063919,\"update_time\":1673063919}'),
(8,	'',	0,	'',	'',	'',	'user',	'',	0,	'cmdb_app_node_delete',	1673063919,	'cmdb',	'{\"id\":0,\"app_name\":\"\",\"aid\":0,\"host_name\":\"\",\"ip\":\"\",\"device_id\":0,\"env\":\"\",\"region_code\":\"\",\"region_name\":\"\",\"zone_code\":\"\",\"zone_name\":\"\",\"create_time\":0,\"update_time\":0}'),
(9,	'',	0,	'cn-wuhan-guanggu-f1',	'dev',	'wuhan-host-1-1',	'user',	'',	0,	'cmdb_app_node_create',	1673063958,	'cmdb',	'{\"id\":4,\"app_name\":\"\",\"aid\":0,\"host_name\":\"wuhan-host-1-1\",\"ip\":\"192.168.1.1\",\"device_id\":0,\"env\":\"dev\",\"region_code\":\"cn-wuhan\",\"region_name\":\"武汉\",\"zone_code\":\"cn-wuhan-guanggu-f1\",\"zone_name\":\"武汉光谷F1区\",\"create_time\":1673063958,\"update_time\":1673063958}'),
(10,	'',	0,	'',	'',	'',	'user',	'',	0,	'cmdb_app_node_delete',	1673063958,	'cmdb',	'{\"id\":0,\"app_name\":\"\",\"aid\":0,\"host_name\":\"\",\"ip\":\"\",\"device_id\":0,\"env\":\"\",\"region_code\":\"\",\"region_name\":\"\",\"zone_code\":\"\",\"zone_name\":\"\",\"create_time\":0,\"update_time\":0}'),
(11,	'',	0,	'cn-wuhan-guanggu-f1',	'dev',	'wuhan-host-1-1',	'user',	'',	0,	'cmdb_app_node_create',	1673064118,	'cmdb',	'{\"id\":5,\"app_name\":\"\",\"aid\":0,\"host_name\":\"wuhan-host-1-1\",\"ip\":\"192.168.1.1\",\"device_id\":0,\"env\":\"dev\",\"region_code\":\"cn-wuhan\",\"region_name\":\"武汉\",\"zone_code\":\"cn-wuhan-guanggu-f1\",\"zone_name\":\"武汉光谷F1区\",\"create_time\":1673064118,\"update_time\":1673064118}');

DROP TABLE IF EXISTS `app_log`;
CREATE TABLE `app_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '''应用id''',
  `aid` bigint(20) NOT NULL COMMENT '''应用id''',
  `gid` bigint(20) NOT NULL COMMENT '''gitlab id''',
  `name` varchar(191) COLLATE utf8mb4_bin NOT NULL COMMENT '''项目中文名''',
  `app_name` varchar(191) COLLATE utf8mb4_bin NOT NULL COMMENT '''项目英文唯一标识名''',
  `create_time` bigint(20) NOT NULL COMMENT '''创建时间''',
  `update_time` bigint(20) NOT NULL COMMENT '''更新时间''',
  `level` bigint(20) NOT NULL COMMENT '''层级''',
  `lang` longtext COLLATE utf8mb4_bin NOT NULL COMMENT '''语言''',
  `biz_domain` longtext COLLATE utf8mb4_bin NOT NULL,
  `created_by` bigint(20) NOT NULL COMMENT '''创建者''',
  `updated_by` bigint(20) NOT NULL COMMENT '''更新者''',
  `http_port` longtext COLLATE utf8mb4_bin NOT NULL,
  `rpc_port` longtext COLLATE utf8mb4_bin NOT NULL,
  `health_port` longtext COLLATE utf8mb4_bin NOT NULL,
  `hook_id` bigint(20) NOT NULL COMMENT '''钩子''',
  `users` json NOT NULL,
  `web_url` longtext COLLATE utf8mb4_bin NOT NULL,
  `action` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '''动作''',
  `created_at` datetime(3) DEFAULT NULL COMMENT '''记录创建时间''',
  PRIMARY KEY (`id`),
  KEY `idx_app_log_app_name` (`app_name`),
  KEY `idx_app_log_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `app_node`;
CREATE TABLE `app_node` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app_name` longtext COLLATE utf8mb4_bin NOT NULL,
  `aid` bigint(20) NOT NULL,
  `host_name` longtext COLLATE utf8mb4_bin NOT NULL,
  `ip` varchar(191) COLLATE utf8mb4_bin NOT NULL,
  `device_id` bigint(20) NOT NULL,
  `env` longtext COLLATE utf8mb4_bin NOT NULL,
  `region_code` longtext COLLATE utf8mb4_bin NOT NULL,
  `region_name` longtext COLLATE utf8mb4_bin NOT NULL,
  `zone_code` longtext COLLATE utf8mb4_bin NOT NULL,
  `zone_name` longtext COLLATE utf8mb4_bin NOT NULL,
  `create_time` bigint(20) NOT NULL,
  `update_time` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_app_node_ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `app_node` (`id`, `app_name`, `aid`, `host_name`, `ip`, `device_id`, `env`, `region_code`, `region_name`, `zone_code`, `zone_name`, `create_time`, `update_time`) VALUES
(5,	'',	0,	'wuhan-host-1-1',	'192.168.1.1',	0,	'dev',	'cn-wuhan',	'武汉',	'cn-wuhan-guanggu-f1',	'武汉光谷F1区',	1673064118,	1673064118);

DROP TABLE IF EXISTS `app_node_map`;
CREATE TABLE `app_node_map` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `aid` bigint(20) DEFAULT NULL,
  `app_name` longtext COLLATE utf8mb4_bin,
  `md5` longtext COLLATE utf8mb4_bin,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `app_node_map` (`id`, `aid`, `app_name`, `md5`) VALUES
(11,	0,	'',	'29b799d89c788f64efc491e01a81aed2');

DROP TABLE IF EXISTS `app_package`;
CREATE TABLE `app_package` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `aid` bigint(20) NOT NULL,
  `name` longtext COLLATE utf8mb4_bin NOT NULL,
  `branch` longtext COLLATE utf8mb4_bin NOT NULL,
  `version` longtext COLLATE utf8mb4_bin NOT NULL,
  `revision` longtext COLLATE utf8mb4_bin NOT NULL,
  `packages` text COLLATE utf8mb4_bin NOT NULL,
  `update_time` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `app_statics`;
CREATE TABLE `app_statics` (
  `aid` bigint(20) NOT NULL,
  `app_name` longtext COLLATE utf8mb4_bin NOT NULL,
  `git_push` bigint(20) NOT NULL,
  `git_tag_push` bigint(20) NOT NULL,
  `git_issue` bigint(20) NOT NULL,
  `git_merge_request` bigint(20) NOT NULL,
  `git_wiki_page` bigint(20) NOT NULL,
  `git_pipeline` bigint(20) NOT NULL,
  `git_job` bigint(20) NOT NULL,
  `cmc_create` bigint(20) NOT NULL,
  `cmc_update` bigint(20) NOT NULL,
  `cmc_delete` bigint(20) NOT NULL,
  `app_create` bigint(20) NOT NULL,
  `app_update` bigint(20) NOT NULL,
  `app_delete` bigint(20) NOT NULL,
  `node_create` bigint(20) NOT NULL,
  `node_update` bigint(20) NOT NULL,
  `node_delete` bigint(20) NOT NULL,
  `pprof_create` bigint(20) NOT NULL,
  `devops_update` bigint(20) NOT NULL,
  `devops_register` bigint(20) NOT NULL,
  `devops_unregister` bigint(20) NOT NULL,
  `devops_start` bigint(20) NOT NULL,
  `devops_restart` bigint(20) NOT NULL,
  `devops_stop` bigint(20) NOT NULL,
  `devops_deploy` bigint(20) NOT NULL,
  `devops_rollback` bigint(20) NOT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `app_topology`;
CREATE TABLE `app_topology` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `aid` bigint(20) NOT NULL,
  `app_name` longtext COLLATE utf8mb4_bin NOT NULL,
  `region_code` longtext COLLATE utf8mb4_bin NOT NULL,
  `zone_code` longtext COLLATE utf8mb4_bin NOT NULL,
  `env` longtext COLLATE utf8mb4_bin NOT NULL,
  `file_name` longtext COLLATE utf8mb4_bin NOT NULL,
  `addr` longtext COLLATE utf8mb4_bin NOT NULL,
  `ip` longtext COLLATE utf8mb4_bin NOT NULL,
  `port` longtext COLLATE utf8mb4_bin NOT NULL,
  `name` longtext COLLATE utf8mb4_bin NOT NULL,
  `type` longtext COLLATE utf8mb4_bin NOT NULL,
  `info` longtext COLLATE utf8mb4_bin NOT NULL,
  `update_time` bigint(20) NOT NULL,
  `updated_by` bigint(20) NOT NULL,
  `extra` text COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `app_user_relation`;
CREATE TABLE `app_user_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app_name` longtext COLLATE utf8mb4_bin NOT NULL,
  `user_name` longtext COLLATE utf8mb4_bin NOT NULL,
  `updated_at` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `app_user_relation` (`id`, `app_name`, `user_name`, `updated_at`) VALUES
(6,	'jupiter-demo',	'askuy',	1673064118),
(7,	'jupiter-demo',	'lvchao',	1673064118),
(8,	'jupiter-demo',	'duminxiang',	1673064118),
(9,	'juno-admin',	'askuy',	1673064118),
(10,	'juno-admin',	'mex',	1673064118);

DROP TABLE IF EXISTS `app_view_history`;
CREATE TABLE `app_view_history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `uid` bigint(20) unsigned DEFAULT NULL,
  `aid` bigint(20) unsigned DEFAULT NULL,
  `app_name` longtext COLLATE utf8mb4_bin,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `app_view_history` (`id`, `created_at`, `updated_at`, `deleted_at`, `uid`, `aid`, `app_name`) VALUES
(1,	'2023-01-07 12:02:46.385',	'2023-01-07 12:02:46.385',	NULL,	1,	2,	'juno-admin'),
(2,	'2023-01-07 12:02:49.467',	'2023-01-07 12:02:49.467',	NULL,	1,	1,	'jupiter-demo'),
(3,	'2023-01-07 12:02:50.528',	'2023-01-07 12:02:50.528',	NULL,	1,	2,	'juno-admin');

DROP TABLE IF EXISTS `board`;
CREATE TABLE `board` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE utf8mb4_bin NOT NULL,
  `src` longtext COLLATE utf8mb4_bin NOT NULL,
  `meta_data` json NOT NULL,
  `is_enable` tinyint(1) NOT NULL,
  `is_common` tinyint(1) NOT NULL,
  `created_at` bigint(20) NOT NULL,
  `updated_at` bigint(20) NOT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_board_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `board_auth`;
CREATE TABLE `board_auth` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `did` bigint(20) NOT NULL,
  `uid` bigint(20) NOT NULL,
  `created_at` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `casbin_policy_auth`;
CREATE TABLE `casbin_policy_auth` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `sub` longtext COLLATE utf8mb4_bin NOT NULL,
  `obj` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `act` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `type` longtext COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `casbin_policy_group`;
CREATE TABLE `casbin_policy_group` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `group_name` varchar(30) COLLATE utf8mb4_bin NOT NULL,
  `uid` bigint(20) NOT NULL,
  `app_name` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `app_env` varchar(30) COLLATE utf8mb4_bin NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `type` longtext COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_casbin_policy_group_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `casbin_policy_group` (`id`, `created_at`, `updated_at`, `deleted_at`, `group_name`, `uid`, `app_name`, `app_env`, `url`, `type`) VALUES
(1,	'2023-01-07 11:13:55.386',	'2023-01-07 11:13:55.386',	NULL,	'admin',	1,	'',	'',	'',	'user'),
(2,	'2023-01-07 11:13:55.487',	'2023-01-07 11:13:55.487',	NULL,	'default',	2,	'',	'',	'',	'user');

DROP TABLE IF EXISTS `cmc_tpl`;
CREATE TABLE `cmc_tpl` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tpl_type` longtext COLLATE utf8mb4_bin NOT NULL,
  `content` longtext COLLATE utf8mb4_bin NOT NULL,
  `create_time` bigint(20) NOT NULL,
  `update_time` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `configuration`;
CREATE TABLE `configuration` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `aid` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_bin,
  `format` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL,
  `env` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL,
  `zone` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `version` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `access_token_id` bigint(20) unsigned DEFAULT NULL,
  `uid` bigint(20) unsigned DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `published_at` datetime(3) DEFAULT NULL,
  `lock_uid` bigint(20) unsigned DEFAULT NULL,
  `lock_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `configuration_cluster_status`;
CREATE TABLE `configuration_cluster_status` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `configuration_id` bigint(20) unsigned DEFAULT NULL,
  `configuration_publish_id` bigint(20) unsigned DEFAULT NULL,
  `cluster_name` longtext COLLATE utf8mb4_bin,
  `used` bigint(20) unsigned DEFAULT NULL,
  `synced` bigint(20) unsigned DEFAULT NULL,
  `take_effect` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `update_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `configuration_history`;
CREATE TABLE `configuration_history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `access_token_id` bigint(20) unsigned DEFAULT NULL,
  `uid` bigint(20) unsigned DEFAULT NULL,
  `configuration_id` bigint(20) unsigned DEFAULT NULL,
  `change_log` longtext COLLATE utf8mb4_bin,
  `content` longtext COLLATE utf8mb4_bin,
  `version` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `configuration_publish`;
CREATE TABLE `configuration_publish` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) DEFAULT NULL,
  `access_token_id` bigint(20) unsigned DEFAULT NULL,
  `configuration_id` bigint(20) unsigned DEFAULT NULL,
  `configuration_history_id` bigint(20) unsigned DEFAULT NULL,
  `apply_instance` longtext COLLATE utf8mb4_bin,
  `file_path` longtext COLLATE utf8mb4_bin,
  `created_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `configuration_resource_relation`;
CREATE TABLE `configuration_resource_relation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `configuration_history_id` bigint(20) unsigned DEFAULT NULL,
  `config_resource_value_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `configuration_status`;
CREATE TABLE `configuration_status` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `configuration_id` bigint(20) unsigned DEFAULT NULL,
  `configuration_publish_id` bigint(20) unsigned DEFAULT NULL,
  `host_name` longtext COLLATE utf8mb4_bin,
  `used` bigint(20) unsigned DEFAULT NULL,
  `synced` bigint(20) unsigned DEFAULT NULL,
  `take_effect` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `update_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `config_resource`;
CREATE TABLE `config_resource` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) unsigned DEFAULT NULL,
  `is_global` tinyint(1) DEFAULT NULL,
  `name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `env` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  `zone_code` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_bin,
  `visible` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `config_resource_tag`;
CREATE TABLE `config_resource_tag` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `config_resource_id` bigint(20) unsigned DEFAULT NULL,
  `value` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `config_resource_value`;
CREATE TABLE `config_resource_value` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `config_resource_id` bigint(20) unsigned DEFAULT NULL,
  `value` text COLLATE utf8mb4_bin,
  `created_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `cron_job`;
CREATE TABLE `cron_job` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `name` longtext COLLATE utf8mb4_bin,
  `uid` bigint(20) unsigned DEFAULT NULL,
  `app_name` longtext COLLATE utf8mb4_bin,
  `env` longtext COLLATE utf8mb4_bin,
  `zone` longtext COLLATE utf8mb4_bin,
  `timeout` bigint(20) unsigned DEFAULT NULL,
  `retry_count` bigint(20) unsigned DEFAULT NULL,
  `retry_interval` bigint(20) unsigned DEFAULT NULL,
  `script` longtext COLLATE utf8mb4_bin,
  `enable` tinyint(1) DEFAULT NULL,
  `nodes` json DEFAULT NULL,
  `job_type` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `cron_job_timer`;
CREATE TABLE `cron_job_timer` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `job_id` bigint(20) unsigned DEFAULT NULL,
  `cron` longtext COLLATE utf8mb4_bin,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `cron_task`;
CREATE TABLE `cron_task` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `job_id` bigint(20) unsigned DEFAULT NULL,
  `node` longtext COLLATE utf8mb4_bin,
  `env` longtext COLLATE utf8mb4_bin,
  `zone` longtext COLLATE utf8mb4_bin,
  `status` longtext COLLATE utf8mb4_bin,
  `timeout` bigint(20) unsigned DEFAULT NULL,
  `executed_at` datetime(3) DEFAULT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  `retry_count` bigint(20) unsigned DEFAULT NULL,
  `log` longtext COLLATE utf8mb4_bin,
  `script` longtext COLLATE utf8mb4_bin,
  `execute_type` bigint(20) DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cron_task_job_id` (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `grpc_proto`;
CREATE TABLE `grpc_proto` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `app_name` bigint(20) DEFAULT NULL,
  `file_name` longtext COLLATE utf8mb4_bin,
  `package_name` longtext COLLATE utf8mb4_bin,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `grpc_proto_service`;
CREATE TABLE `grpc_proto_service` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `proto_id` bigint(20) unsigned DEFAULT NULL,
  `name` longtext COLLATE utf8mb4_bin,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `grpc_service_method`;
CREATE TABLE `grpc_service_method` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `service_id` bigint(20) unsigned DEFAULT NULL,
  `name` longtext COLLATE utf8mb4_bin NOT NULL,
  `method_comment` longtext COLLATE utf8mb4_bin,
  `input_name` longtext COLLATE utf8mb4_bin NOT NULL,
  `input_type` json NOT NULL,
  `output_type` json NOT NULL,
  `output_name` longtext COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `grpc_test_case`;
CREATE TABLE `grpc_test_case` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `method_id` bigint(20) unsigned DEFAULT NULL,
  `uid` bigint(20) unsigned DEFAULT NULL,
  `name` longtext COLLATE utf8mb4_bin,
  `input` longtext COLLATE utf8mb4_bin,
  `metadata` longtext COLLATE utf8mb4_bin,
  `script` longtext COLLATE utf8mb4_bin,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `grpc_test_log`;
CREATE TABLE `grpc_test_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `method_id` bigint(20) unsigned DEFAULT NULL,
  `operator_type` longtext COLLATE utf8mb4_bin,
  `operator_id` bigint(20) unsigned DEFAULT NULL,
  `input` longtext COLLATE utf8mb4_bin,
  `output` longtext COLLATE utf8mb4_bin,
  `status` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL,
  `error` longtext COLLATE utf8mb4_bin,
  `time_cost` int(10) unsigned DEFAULT NULL,
  `addr` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  `metadata` longtext COLLATE utf8mb4_bin,
  `script` longtext COLLATE utf8mb4_bin,
  `test_passed` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `http_test_case`;
CREATE TABLE `http_test_case` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `collection_id` bigint(20) unsigned DEFAULT NULL,
  `name` longtext COLLATE utf8mb4_bin,
  `url` longtext COLLATE utf8mb4_bin,
  `method` longtext COLLATE utf8mb4_bin,
  `query` json DEFAULT NULL,
  `headers` json DEFAULT NULL,
  `content_type` longtext COLLATE utf8mb4_bin,
  `body` longtext COLLATE utf8mb4_bin,
  `script` longtext COLLATE utf8mb4_bin,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `http_test_collection`;
CREATE TABLE `http_test_collection` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `app_name` longtext COLLATE utf8mb4_bin,
  `name` longtext COLLATE utf8mb4_bin,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `http_test_log`;
CREATE TABLE `http_test_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `operator_type` longtext COLLATE utf8mb4_bin,
  `operator_id` bigint(20) unsigned DEFAULT NULL,
  `app_name` longtext COLLATE utf8mb4_bin,
  `name` longtext COLLATE utf8mb4_bin,
  `url` longtext COLLATE utf8mb4_bin,
  `method` longtext COLLATE utf8mb4_bin,
  `query` json DEFAULT NULL,
  `headers` json DEFAULT NULL,
  `content_type` longtext COLLATE utf8mb4_bin,
  `body` longtext COLLATE utf8mb4_bin,
  `response_body` longtext COLLATE utf8mb4_bin,
  `response_headers` json DEFAULT NULL,
  `size` bigint(20) DEFAULT NULL,
  `cost` bigint(20) DEFAULT NULL,
  `code` bigint(20) DEFAULT NULL,
  `status` longtext COLLATE utf8mb4_bin,
  `error` longtext COLLATE utf8mb4_bin,
  `test_logs` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `k8s_pod`;
CREATE TABLE `k8s_pod` (
  `pod_name` varchar(191) COLLATE utf8mb4_bin NOT NULL,
  `env` longtext COLLATE utf8mb4_bin,
  `namespace` longtext COLLATE utf8mb4_bin,
  `host_ip` longtext COLLATE utf8mb4_bin,
  `pod_ip` longtext COLLATE utf8mb4_bin,
  `node_name` varchar(191) COLLATE utf8mb4_bin DEFAULT NULL,
  `start_time` datetime(3) DEFAULT NULL,
  `update_time` datetime(3) DEFAULT NULL,
  `image` longtext COLLATE utf8mb4_bin,
  `status` longtext COLLATE utf8mb4_bin,
  `instance_group_id` longtext COLLATE utf8mb4_bin,
  `instance_group_name` longtext COLLATE utf8mb4_bin,
  `md5` varchar(191) COLLATE utf8mb4_bin DEFAULT NULL,
  `is_del` int(11) DEFAULT NULL,
  `aid` int(11) DEFAULT NULL,
  `app_name` varchar(191) COLLATE utf8mb4_bin DEFAULT NULL,
  `zone_code` longtext COLLATE utf8mb4_bin,
  `domain` longtext COLLATE utf8mb4_bin,
  PRIMARY KEY (`pod_name`),
  KEY `idx_md5` (`md5`),
  KEY `idx_aid` (`aid`),
  KEY `idx_appname` (`app_name`),
  KEY `idx_node_name` (`node_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `log_store`;
CREATE TABLE `log_store` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` longtext COLLATE utf8mb4_bin NOT NULL,
  `active_key` longtext COLLATE utf8mb4_bin NOT NULL,
  `app_name` longtext COLLATE utf8mb4_bin NOT NULL,
  `env` longtext COLLATE utf8mb4_bin NOT NULL,
  `region` longtext COLLATE utf8mb4_bin,
  `project` longtext COLLATE utf8mb4_bin NOT NULL,
  `log_store` longtext COLLATE utf8mb4_bin NOT NULL,
  `remark` longtext COLLATE utf8mb4_bin NOT NULL,
  `ctime` bigint(20) NOT NULL DEFAULT '0',
  `utime` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `node`;
CREATE TABLE `node` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `host_name` longtext COLLATE utf8mb4_bin NOT NULL,
  `ip` longtext COLLATE utf8mb4_bin NOT NULL,
  `create_time` bigint(20) NOT NULL,
  `update_time` bigint(20) NOT NULL,
  `env` longtext COLLATE utf8mb4_bin NOT NULL,
  `region_code` longtext COLLATE utf8mb4_bin NOT NULL,
  `region_name` longtext COLLATE utf8mb4_bin NOT NULL,
  `zone_code` longtext COLLATE utf8mb4_bin NOT NULL,
  `zone_name` longtext COLLATE utf8mb4_bin NOT NULL,
  `agent_heartbeat_time` bigint(20) NOT NULL,
  `proxy_heartbeat_time` bigint(20) NOT NULL,
  `node_type` bigint(20) NOT NULL,
  `agent_type` bigint(20) NOT NULL,
  `agent_version` longtext COLLATE utf8mb4_bin NOT NULL,
  `proxy_type` bigint(20) NOT NULL,
  `proxy_version` longtext COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `node` (`id`, `host_name`, `ip`, `create_time`, `update_time`, `env`, `region_code`, `region_name`, `zone_code`, `zone_name`, `agent_heartbeat_time`, `proxy_heartbeat_time`, `node_type`, `agent_type`, `agent_version`, `proxy_type`, `proxy_version`) VALUES
(1,	'wuhan-host-1-1',	'192.168.1.1',	1673061235,	1673061235,	'dev',	'cn-wuhan',	'武汉',	'cn-wuhan-guanggu-f1',	'武汉光谷F1区',	0,	0,	1,	0,	'',	0,	'');

DROP TABLE IF EXISTS `ops_supervisor_config`;
CREATE TABLE `ops_supervisor_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `aid` bigint(20) DEFAULT NULL,
  `app_name` longtext COLLATE utf8mb4_bin,
  `ops_app_name` longtext COLLATE utf8mb4_bin,
  `zone_code` longtext COLLATE utf8mb4_bin,
  `access_key` longtext COLLATE utf8mb4_bin,
  `access_secret` longtext COLLATE utf8mb4_bin,
  `create_time` bigint(20) DEFAULT NULL,
  `update_time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `option`;
CREATE TABLE `option` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `option_title` longtext COLLATE utf8mb4_bin NOT NULL,
  `option_name` longtext COLLATE utf8mb4_bin NOT NULL,
  `option_value` longtext COLLATE utf8mb4_bin NOT NULL,
  `create_time` bigint(20) NOT NULL COMMENT '''创建时间''',
  `update_time` bigint(20) NOT NULL COMMENT '''更新时间''',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `pprof`;
CREATE TABLE `pprof` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` longtext COLLATE utf8mb4_bin NOT NULL,
  `scene_id` longtext COLLATE utf8mb4_bin NOT NULL,
  `app_name` longtext COLLATE utf8mb4_bin NOT NULL,
  `aid` bigint(20) NOT NULL,
  `file_info` longtext COLLATE utf8mb4_bin NOT NULL,
  `zone_code` longtext COLLATE utf8mb4_bin NOT NULL,
  `env` longtext COLLATE utf8mb4_bin NOT NULL,
  `ext` longtext COLLATE utf8mb4_bin NOT NULL,
  `remark` longtext COLLATE utf8mb4_bin NOT NULL,
  `host_name` longtext COLLATE utf8mb4_bin NOT NULL,
  `create_time` bigint(20) DEFAULT NULL,
  `update_time` bigint(20) DEFAULT NULL,
  `delete_time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_pprof_delete_time` (`delete_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `proxy_manage`;
CREATE TABLE `proxy_manage` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` longtext COLLATE utf8mb4_bin NOT NULL,
  `sub_path` longtext COLLATE utf8mb4_bin NOT NULL,
  `is_rewrite` bigint(20) NOT NULL DEFAULT '0',
  `proxy_addr` longtext COLLATE utf8mb4_bin NOT NULL,
  `create_time` bigint(20) NOT NULL DEFAULT '0',
  `update_time` bigint(20) NOT NULL DEFAULT '0',
  `delete_time` bigint(20) NOT NULL DEFAULT '0',
  `uid` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `proxy_menu`;
CREATE TABLE `proxy_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `panel_type` longtext COLLATE utf8mb4_bin NOT NULL,
  `proxy_url` longtext COLLATE utf8mb4_bin NOT NULL,
  `key` longtext COLLATE utf8mb4_bin NOT NULL,
  `create_time` bigint(20) NOT NULL DEFAULT '0',
  `update_time` bigint(20) NOT NULL DEFAULT '0',
  `delete_time` bigint(20) NOT NULL DEFAULT '0',
  `uid` bigint(20) NOT NULL DEFAULT '0',
  `title` longtext COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `system_config`;
CREATE TABLE `system_config` (
  `name` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `content` longtext COLLATE utf8mb4_bin NOT NULL,
  `create_time` bigint(20) NOT NULL,
  `update_time` bigint(20) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `system_config` (`name`, `content`, `create_time`, `update_time`) VALUES
('etcd',	'[{\"prefix\":\"/prometheus/job/\",\"info\":\"监控查询\"}]',	1673061016,	0),
('grafana',	'{\"host\":\"http://127.0.0.1:3000\",\"header_name\":\"X-WEBAUTH-USER\",\"scheme\":\"http\"}',	1673061016,	0),
('version',	'[{\"name\":\"jupiter1.0\",\"version\":\"v1.0\",\"versionKey\":\"jupiter1.0\",\"host\":\"http://127.0.0.1:3000\",\"header_name\":\"X-WEBAUTH-USER\",\"dashboards\":[{\"name\":\"API监控面板地址\",\"value\":\"/grafana/d/api\"},{\"name\":\"实例监控面板\",\"value\":\"/grafana/d/instance\"},{\"name\":\"概览监控面板\",\"value\":\"/grafana/d/overview\"}]}]',	1673061016,	0);

DROP TABLE IF EXISTS `test_pipeline`;
CREATE TABLE `test_pipeline` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `name` longtext COLLATE utf8mb4_bin,
  `app_name` longtext COLLATE utf8mb4_bin,
  `env` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  `zone_code` longtext COLLATE utf8mb4_bin,
  `branch` longtext COLLATE utf8mb4_bin,
  `code_check` tinyint(1) DEFAULT NULL,
  `unit_test` tinyint(1) DEFAULT NULL,
  `http_test_collection` bigint(20) DEFAULT NULL,
  `grpc_test_addr` longtext COLLATE utf8mb4_bin,
  `grpc_test_cases` json DEFAULT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `test_pipeline_step_status`;
CREATE TABLE `test_pipeline_step_status` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `task_id` bigint(20) unsigned DEFAULT NULL,
  `step_name` longtext COLLATE utf8mb4_bin,
  `status` longtext COLLATE utf8mb4_bin,
  `logs` longtext COLLATE utf8mb4_bin,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `test_pipeline_task`;
CREATE TABLE `test_pipeline_task` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `pipeline_id` bigint(20) unsigned DEFAULT NULL,
  `name` longtext COLLATE utf8mb4_bin,
  `app_name` longtext COLLATE utf8mb4_bin,
  `branch` longtext COLLATE utf8mb4_bin,
  `env` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  `zone_code` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  `desc` json DEFAULT NULL,
  `status` longtext COLLATE utf8mb4_bin,
  `logs` longtext COLLATE utf8mb4_bin,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `tool`;
CREATE TABLE `tool` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '''id''',
  `name` longtext COLLATE utf8mb4_bin NOT NULL COMMENT '''工具名''',
  `url` longtext COLLATE utf8mb4_bin NOT NULL COMMENT '''工具地址''',
  `pic_url` longtext COLLATE utf8mb4_bin NOT NULL COMMENT '''图片地址''',
  `desc` longtext COLLATE utf8mb4_bin NOT NULL COMMENT '''工具描述''',
  `create_time` bigint(20) NOT NULL COMMENT '''创建时间''',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `uid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `oaid` bigint(20) NOT NULL COMMENT '''oa uid''',
  `username` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '''用户名''',
  `nickname` longtext COLLATE utf8mb4_bin NOT NULL COMMENT '''昵称''',
  `secret` longtext COLLATE utf8mb4_bin NOT NULL COMMENT '''秘钥''',
  `email` longtext COLLATE utf8mb4_bin NOT NULL COMMENT '''email''',
  `avatar` longtext COLLATE utf8mb4_bin NOT NULL COMMENT '''avatart''',
  `web_url` longtext COLLATE utf8mb4_bin NOT NULL COMMENT '''注释''',
  `state` longtext COLLATE utf8mb4_bin NOT NULL COMMENT '''注释''',
  `hash` longtext COLLATE utf8mb4_bin NOT NULL COMMENT '''注释''',
  `create_time` bigint(20) NOT NULL COMMENT '''注释''',
  `update_time` bigint(20) NOT NULL COMMENT '''注释''',
  `oauth` longtext COLLATE utf8mb4_bin NOT NULL,
  `oauth_id` longtext COLLATE utf8mb4_bin NOT NULL,
  `password` longtext COLLATE utf8mb4_bin NOT NULL COMMENT '''注释''',
  `current_authority` longtext COLLATE utf8mb4_bin,
  `access` longtext COLLATE utf8mb4_bin,
  `oauth_token` json DEFAULT NULL COMMENT '''OAuth Token 信息''',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `user` (`uid`, `oaid`, `username`, `nickname`, `secret`, `email`, `avatar`, `web_url`, `state`, `hash`, `create_time`, `update_time`, `oauth`, `oauth_id`, `password`, `current_authority`, `access`, `oauth_token`) VALUES
(1,	0,	'admin',	'admin',	'',	'',	'',	'',	'',	'',	1673061235,	1673061235,	'',	'',	'$2a$10$r9DQ07wk24/Pzkf99OR2huTT/4SbJp.pckSvQMl7bC7OXgOn1NZRi',	'',	'admin',	'{}'),
(2,	0,	'default',	'default',	'',	'',	'',	'',	'',	'',	1673061235,	1673061235,	'',	'',	'$2a$10$8H/zMx1BGrOIoPv0gnreu.s1i0zK8pGicyFXANbpXCYHOTQ9Y160O',	'',	'user',	'{}');

DROP TABLE IF EXISTS `user_config`;
CREATE TABLE `user_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) NOT NULL COMMENT '''用户id''',
  `aid` bigint(20) NOT NULL COMMENT '''应用id''',
  `content` longtext COLLATE utf8mb4_bin NOT NULL,
  `create_time` bigint(20) NOT NULL,
  `update_time` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `user_relation`;
CREATE TABLE `user_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '''注释''',
  `uid` bigint(20) NOT NULL COMMENT '''注释''',
  `bid` bigint(20) NOT NULL COMMENT '''注释''',
  `type` bigint(20) NOT NULL COMMENT '''注释''',
  `create_time` bigint(20) NOT NULL COMMENT '''注释''',
  `update_time` bigint(20) NOT NULL COMMENT '''注释''',
  `delete_time` bigint(20) NOT NULL COMMENT '''注释''',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `user_visit`;
CREATE TABLE `user_visit` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) NOT NULL COMMENT '''用户id''',
  `aid` bigint(20) NOT NULL COMMENT '''应用id''',
  `app_name` longtext COLLATE utf8mb4_bin NOT NULL,
  `zone_code` varchar(191) COLLATE utf8mb4_bin NOT NULL,
  `env` varchar(191) COLLATE utf8mb4_bin NOT NULL,
  `tab` longtext COLLATE utf8mb4_bin NOT NULL,
  `url` longtext COLLATE utf8mb4_bin NOT NULL,
  `ts` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_env` (`env`),
  KEY `tx` (`ts`),
  KEY `idx_uid` (`uid`),
  KEY `idx_aid` (`aid`),
  KEY `idx_zone_code` (`zone_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `worker_node`;
CREATE TABLE `worker_node` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `host_name` longtext COLLATE utf8mb4_bin,
  `region_code` longtext COLLATE utf8mb4_bin,
  `region_name` longtext COLLATE utf8mb4_bin,
  `zone_code` longtext COLLATE utf8mb4_bin,
  `zone_name` longtext COLLATE utf8mb4_bin,
  `ip` longtext COLLATE utf8mb4_bin,
  `port` bigint(20) DEFAULT NULL,
  `env` longtext COLLATE utf8mb4_bin,
  `last_heartbeat` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `zone`;
CREATE TABLE `zone` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '''注释''',
  `env` longtext COLLATE utf8mb4_bin NOT NULL,
  `region_code` longtext COLLATE utf8mb4_bin NOT NULL,
  `region_name` longtext COLLATE utf8mb4_bin NOT NULL,
  `zone_code` varchar(191) COLLATE utf8mb4_bin NOT NULL,
  `zone_name` longtext COLLATE utf8mb4_bin NOT NULL,
  `create_time` bigint(20) NOT NULL COMMENT '''注释''',
  `update_time` bigint(20) NOT NULL COMMENT '''注释''',
  `created_by` bigint(20) NOT NULL COMMENT '''注释''',
  `updated_by` bigint(20) NOT NULL COMMENT '''注释''',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `zone` (`id`, `env`, `region_code`, `region_name`, `zone_code`, `zone_name`, `create_time`, `update_time`, `created_by`, `updated_by`) VALUES
(1,	'dev',	'cn-wuhan',	'武汉',	'cn-wuhan-guanggu-f1',	'武汉光谷F1区',	1673064118,	1673064118,	0,	0);

-- 2023-01-07 04:03:08