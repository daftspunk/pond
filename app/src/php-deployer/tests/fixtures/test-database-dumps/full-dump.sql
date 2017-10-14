/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table axmit_storage_cms_content
# ------------------------------------------------------------

CREATE TABLE `axmit_storage_cms_content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `directory` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `extension` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  `settings` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dir_filename_ext_unique` (`directory`,`filename`,`extension`),
  KEY `axmit_storage_cms_content_directory_index` (`directory`),
  KEY `axmit_storage_cms_content_filename_index` (`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table backend_access_log
# ------------------------------------------------------------

CREATE TABLE `backend_access_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `ip_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `backend_access_log` WRITE;
/*!40000 ALTER TABLE `backend_access_log` DISABLE KEYS */;

INSERT INTO `backend_access_log` (`id`, `user_id`, `ip_address`, `created_at`, `updated_at`)
VALUES
    (1,1,'10.0.2.2','2017-06-21 01:58:42','2017-06-21 01:58:42'),
    (2,1,'10.0.2.2','2017-06-21 02:09:17','2017-06-21 02:09:17'),
    (3,1,'10.0.2.2','2017-06-21 23:23:11','2017-06-21 23:23:11'),
    (4,1,'10.0.2.2','2017-06-22 23:05:00','2017-06-22 23:05:00'),
    (5,1,'10.0.2.2','2017-06-28 00:03:24','2017-06-28 00:03:24'),
    (6,1,'10.0.2.2','2017-06-30 01:33:59','2017-06-30 01:33:59'),
    (7,1,'10.0.2.2','2017-06-30 01:34:34','2017-06-30 01:34:34'),
    (8,1,'10.0.2.2','2017-06-30 01:35:33','2017-06-30 01:35:33'),
    (9,1,'10.0.2.2','2017-06-30 01:49:02','2017-06-30 01:49:02'),
    (10,1,'10.0.2.2','2017-07-04 02:39:27','2017-07-04 02:39:27'),
    (11,1,'10.0.2.2','2017-07-05 23:57:00','2017-07-05 23:57:00'),
    (12,1,'10.0.2.2','2017-07-07 00:10:14','2017-07-07 00:10:14'),
    (13,1,'10.0.2.2','2017-07-07 00:10:45','2017-07-07 00:10:45'),
    (14,1,'10.0.2.2','2017-07-07 00:16:08','2017-07-07 00:16:08'),
    (15,1,'10.0.2.2','2017-07-11 23:56:53','2017-07-11 23:56:53'),
    (16,1,'10.0.2.2','2017-07-19 00:04:28','2017-07-19 00:04:28'),
    (17,1,'10.0.2.2','2017-08-09 02:07:07','2017-08-09 02:07:07'),
    (18,1,'10.0.2.2','2017-08-09 02:31:43','2017-08-09 02:31:43'),
    (19,1,'10.0.2.2','2017-08-09 02:47:11','2017-08-09 02:47:11'),
    (20,1,'10.0.2.2','2017-08-09 02:47:47','2017-08-09 02:47:47'),
    (21,1,'10.0.2.2','2017-08-09 02:50:56','2017-08-09 02:50:56'),
    (22,1,'10.0.2.2','2017-08-17 22:49:24','2017-08-17 22:49:24'),
    (23,1,'10.0.2.2','2017-08-22 23:28:02','2017-08-22 23:28:02'),
    (24,1,'10.0.2.2','2017-08-24 00:05:53','2017-08-24 00:05:53'),
    (25,1,'10.0.2.2','2017-08-24 00:06:53','2017-08-24 00:06:53'),
    (26,1,'10.0.2.2','2017-09-06 00:12:46','2017-09-06 00:12:46'),
    (27,1,'10.0.2.2','2017-09-07 00:50:24','2017-09-07 00:50:24'),
    (28,1,'10.0.2.2','2017-09-12 00:13:43','2017-09-12 00:13:43'),
    (29,1,'10.0.2.2','2017-09-13 00:05:45','2017-09-13 00:05:45'),
    (30,1,'10.0.2.2','2017-09-13 23:11:02','2017-09-13 23:11:02'),
    (31,1,'10.0.2.2','2017-09-13 23:17:55','2017-09-13 23:17:55'),
    (32,1,'10.0.2.2','2017-09-21 00:33:56','2017-09-21 00:33:56'),
    (33,1,'10.0.2.2','2017-09-29 22:28:04','2017-09-29 22:28:04'),
    (34,1,'10.0.2.2','2017-10-03 22:40:52','2017-10-03 22:40:52'),
    (35,1,'10.0.2.2','2017-10-03 22:41:52','2017-10-03 22:41:52'),
    (36,1,'10.0.2.2','2017-10-11 00:32:54','2017-10-11 00:32:54'),
    (37,1,'10.0.2.2','2017-10-11 00:49:10','2017-10-11 00:49:10');

/*!40000 ALTER TABLE `backend_access_log` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table backend_user_groups
# ------------------------------------------------------------

CREATE TABLE `backend_user_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `permissions` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `is_new_user_default` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_unique` (`name`),
  KEY `code_index` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `backend_user_groups` WRITE;
/*!40000 ALTER TABLE `backend_user_groups` DISABLE KEYS */;

INSERT INTO `backend_user_groups` (`id`, `name`, `permissions`, `created_at`, `updated_at`, `code`, `description`, `is_new_user_default`)
VALUES
    (1,'Owners',NULL,'2017-06-20 23:47:43','2017-06-20 23:47:43','owners','Default group for website owners.',0);

/*!40000 ALTER TABLE `backend_user_groups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table backend_user_preferences
# ------------------------------------------------------------

CREATE TABLE `backend_user_preferences` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `namespace` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `group` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `item` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `user_item_index` (`user_id`,`namespace`,`group`,`item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table backend_user_throttle
# ------------------------------------------------------------

CREATE TABLE `backend_user_throttle` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `ip_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attempts` int(11) NOT NULL DEFAULT '0',
  `last_attempt_at` timestamp NULL DEFAULT NULL,
  `is_suspended` tinyint(1) NOT NULL DEFAULT '0',
  `suspended_at` timestamp NULL DEFAULT NULL,
  `is_banned` tinyint(1) NOT NULL DEFAULT '0',
  `banned_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `backend_user_throttle_user_id_index` (`user_id`),
  KEY `backend_user_throttle_ip_address_index` (`ip_address`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `backend_user_throttle` WRITE;
/*!40000 ALTER TABLE `backend_user_throttle` DISABLE KEYS */;

INSERT INTO `backend_user_throttle` (`id`, `user_id`, `ip_address`, `attempts`, `last_attempt_at`, `is_suspended`, `suspended_at`, `is_banned`, `banned_at`)
VALUES
    (1,1,'10.0.2.2',0,NULL,0,NULL,0,NULL);

/*!40000 ALTER TABLE `backend_user_throttle` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table backend_users
# ------------------------------------------------------------

CREATE TABLE `backend_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `login` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `activation_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `persist_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `permissions` text COLLATE utf8_unicode_ci,
  `is_activated` tinyint(1) NOT NULL DEFAULT '0',
  `activated_at` timestamp NULL DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `login_unique` (`login`),
  UNIQUE KEY `email_unique` (`email`),
  KEY `act_code_index` (`activation_code`),
  KEY `reset_code_index` (`reset_password_code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `backend_users` WRITE;
/*!40000 ALTER TABLE `backend_users` DISABLE KEYS */;

INSERT INTO `backend_users` (`id`, `first_name`, `last_name`, `login`, `email`, `password`, `activation_code`, `persist_code`, `reset_password_code`, `permissions`, `is_activated`, `activated_at`, `last_login`, `created_at`, `updated_at`, `is_superuser`)
VALUES
    (1,'Admin','Person','admin','admin@domain.tld','$2y$10$BQ9MkxjwbpCwdM.Yk0mIEO9U.ILoaFMy2C3I.mvJNpUquaOXTWWVy',NULL,'$2y$10$abDX0gUj41Q6zPQLiRI7G.QT.do/PwLOYyIkXF5WOndZQr8p8y8Tm',NULL,'',1,NULL,'2017-10-11 00:49:09','2017-06-20 23:47:43','2017-10-11 00:49:09',1);

/*!40000 ALTER TABLE `backend_users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table backend_users_groups
# ------------------------------------------------------------

CREATE TABLE `backend_users_groups` (
  `user_id` int(10) unsigned NOT NULL,
  `user_group_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`user_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `backend_users_groups` WRITE;
/*!40000 ALTER TABLE `backend_users_groups` DISABLE KEYS */;

INSERT INTO `backend_users_groups` (`user_id`, `user_group_id`)
VALUES
    (1,1);

/*!40000 ALTER TABLE `backend_users_groups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cache
# ------------------------------------------------------------

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` longtext COLLATE utf8_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL,
  UNIQUE KEY `cache_key_unique` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table cms_theme_data
# ------------------------------------------------------------

CREATE TABLE `cms_theme_data` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `theme` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` mediumtext COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cms_theme_data_theme_index` (`theme`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `cms_theme_data` WRITE;
/*!40000 ALTER TABLE `cms_theme_data` DISABLE KEYS */;

INSERT INTO `cms_theme_data` (`id`, `theme`, `data`, `created_at`, `updated_at`)
VALUES
    (1,'jumplink-freifunk','{\"site_name\":\"Freifunk Cuxhaven\",\"site_desc\":\"Die Freifunk-Community aus Cuxhaven\",\"phone_number\":\"\",\"email_address\":\"moin@freifunk-cuxhaven.de\",\"owner_name\":\"Freifunk Cuxhaven\",\"street\":\"Kasernenstra\\u00dfe 8\",\"city\":\"Cuxhaven\",\"zip\":\"27472\",\"country\":\"Deutschland\",\"router_base_fw_url\":\"https:\\/\\/nord.freifunk.net\\/firmware\",\"router_fw_version\":\"gluon-ffnord-2016.2.5\",\"router_base_specifications_url\":\"https:\\/\\/wiki.openwrt.org\\/toh\",\"meshviewer_url\":\"https:\\/\\/mesh.freifunknord.de\\/#!v:m;n:14cc20c01de0\",\"intergram_id\":\"-1001068783947\",\"intergram_title_closed\":\"Freifunk Live Chat\",\"intergram_title_open\":\"Freifunk Live Chat\",\"intergram_intro_message\":\"Hallo und herzlich Willommen bei Freifunk Cuxhaven. Frage uns hier einfach was du willst \\ud83d\\ude00\",\"intergram_auto_response\":\"Danke f\\u00fcr deine Nachricht, es wird dir jemand antworten sobald er deine Nachricht bemerkt\",\"intergram_auto_no_response\":\"Scheinbar sind gerade alle besch\\u00e4ftigt, du kannst uns stattdessen eine E-Mail schreiben: moin@freifunk-cuxhaven.de oder deine Kontaktdaten hier hinterlassen, wir werden uns dann bei dir melden. Schau auch gerne im Telegram Chat https:\\/\\/t.me\\/FreifunkCuxhaven oder im IRC https:\\/\\/chat.ffcux.net vorbei.\",\"intergram_main_color\":\"#bd0c70\",\"intergram_always_use_floating_button\":true,\"intergram_widget_source\":\"https:\\/\\/www.intergram.xyz\\/js\\/widget.js\",\"tax_id\":\"\",\"bs4-white\":\"#fff\",\"bs4-black\":\"#000\",\"bs4-red\":\"#d9534f\",\"bs4-orange\":\"#f0ad4e\",\"bs4-yellow\":\"#ffd500\",\"bs4-green\":\"#5cb85c\",\"bs4-blue\":\"#0275d8\",\"bs4-teal\":\"#5bc0de\",\"bs4-pink\":\"#ff5b77\",\"bs4-purple\":\"#613d7c\",\"bs4-gray-dark\":\"#292b2c\",\"bs4-gray\":\"#464a4c\",\"bs4-gray-light\":\"#636c72\",\"bs4-gray-lighter\":\"#eceeef\",\"bs4-gray-lightest\":\"#f7f7f9\",\"bs4-brand-primary\":\"$blue\",\"bs4-brand-success\":\"$green\",\"bs4-brand-info\":\"$teal\",\"bs4-brand-warning\":\"$orange\",\"bs4-brand-danger\":\"$red\",\"bs4-brand-inverse\":\"$gray-dark\",\"bs4-enable-rounded\":true,\"bs4-enable-shadows\":false,\"bs4-enable-gradients\":false,\"bs4-enable-transitions\":true,\"bs4-enable-hover-media-query\":false,\"bs4-enable-grid-classes\":true,\"bs4-enable-print-styles\":true,\"bs4-spacer\":\"1rem\",\"bs4-spacer-x\":\"$spacer\",\"bs4-spacer-y\":\"$spacer\",\"bs4-spacers-x-0\":\"0\",\"bs4-spacers-y-0\":\"0\",\"bs4-spacers-x-1\":\"$spacer-x * .25\",\"bs4-spacers-y-1\":\"$spacer-y * .25\",\"bs4-spacers-x-2\":\"($spacer-x * .5)\",\"bs4-spacers-y-2\":\"($spacer-y * .5)\",\"bs4-spacers-x-3\":\"($spacer-x)\",\"bs4-spacers-y-3\":\"($spacer-y)\",\"bs4-spacers-x-4\":\"($spacer-x * 1.5)\",\"bs4-spacers-y-4\":\"($spacer-y * 1.5)\",\"bs4-spacers-x-5\":\"($spacer-x * 3)\",\"bs4-spacers-y-5\":\"($spacer-y * 3)\",\"bs4-border-width\":\"1px\",\"bs4-body-bg\":\"$white\",\"bs4-body-color\":\"$gray-dark\",\"bs4-inverse-bg\":\"$gray-dark\",\"bs4-inverse-color\":\"$gray-lighter\",\"bs4-link-color\":\"$brand-primary\",\"bs4-link-decoration\":\"none\",\"bs4-link-hover-color\":\"darken($link-color, 15%)\",\"bs4-link-hover-decoration\":\"underline\",\"bs4-grid-breakpoints-xs\":\"0\",\"bs4-grid-breakpoints-sm\":\"576px\",\"bs4-grid-breakpoints-md\":\"768px\",\"bs4-grid-breakpoints-lg\":\"992px\",\"bs4-grid-breakpoints-xl\":\"1200px\",\"bs4-container-max-widths-xs\":\"null\",\"bs4-container-max-widths-sm\":\"540px\",\"bs4-container-max-widths-md\":\"720px\",\"bs4-container-max-widths-lg\":\"960px\",\"bs4-container-max-widths-xl\":\"1140px\",\"bs4-grid-columns\":\"12\",\"bs4-grid-gutter-width-base\":\"30px\",\"bs4-grid-gutter-widths-xs\":\"$grid-gutter-width-base\",\"bs4-grid-gutter-widths-sm\":\"$grid-gutter-width-base\",\"bs4-grid-gutter-widths-md\":\"$grid-gutter-width-base\",\"bs4-grid-gutter-widths-lg\":\"$grid-gutter-width-base\",\"bs4-grid-gutter-widths-xl\":\"$grid-gutter-width-base\",\"bs4-font-family-sans-serif\":\"-apple-system, system-ui, BlinkMacSystemFont, \\\"Segoe UI\\\", Roboto, \\\"Helvetica Neue\\\", Arial, sans-serif\",\"bs4-font-family-serif\":\"Georgia, \\\"Times New Roman\\\", Times, serif\",\"bs4-font-family-monospace\":\"Menlo, Monaco, Consolas, \\\"Liberation Mono\\\", \\\"Courier New\\\", monospace\",\"bs4-font-family-base\":\"$font-family-sans-serif\",\"bs4-font-size-root\":\"16px\",\"bs4-font-size-base\":\"1rem\",\"bs4-font-size-lg\":\"1.25rem\",\"bs4-font-size-sm\":\".875rem\",\"bs4-font-size-xs\":\".75rem\",\"bs4-font-weight-normal\":\"normal\",\"bs4-font-weight-bold\":\"bold\",\"bs4-font-weight-base\":\"$font-weight-normal\",\"bs4-line-height-base\":\"1.5\",\"bs4-font-size-h1\":\"2.5rem\",\"bs4-font-size-h2\":\"2rem\",\"bs4-font-size-h3\":\"1.75rem\",\"bs4-font-size-h4\":\"1.5rem\",\"bs4-font-size-h5\":\"1.25rem\",\"bs4-font-size-h6\":\"1rem\",\"bs4-headings-margin-bottom\":\"($spacer \\/ 2)\",\"bs4-headings-font-family\":\"inherit\",\"bs4-headings-font-weight\":\"500\",\"bs4-headings-line-height\":\"1.1\",\"bs4-headings-color\":\"inherit\",\"bs4-display1-size\":\"6rem\",\"bs4-display2-size\":\"5.5rem\",\"bs4-display3-size\":\"4.5rem\",\"bs4-display4-size\":\"3.5rem\",\"bs4-display1-weight\":\"300\",\"bs4-display2-weight\":\"300\",\"bs4-display3-weight\":\"300\",\"bs4-display4-weight\":\"300\",\"bs4-display-line-height\":\"$headings-line-height\",\"bs4-lead-font-size\":\"1.25rem\",\"bs4-lead-font-weight\":\"300\",\"bs4-small-font-size\":\"80%\",\"bs4-text-muted\":\"$gray-light\",\"bs4-abbr-border-color\":\"$gray-light\",\"bs4-blockquote-small-color\":\"$gray-light\",\"bs4-blockquote-font-size\":\"($font-size-base * 1.25)\",\"bs4-blockquote-border-color\":\"$gray-lighter\",\"bs4-blockquote-border-width\":\".25rem\",\"bs4-hr-border-color\":\"rgba($black,.1)\",\"bs4-hr-border-width\":\"$border-width\",\"bs4-mark-padding\":\".2em\",\"bs4-dt-font-weight\":\"$font-weight-bold\",\"bs4-kbd-box-shadow\":\"inset 0 -.1rem 0 rgba($black,.25)\",\"bs4-nested-kbd-font-weight\":\"$font-weight-bold\",\"bs4-list-inline-padding\":\"5px\",\"bs4-line-height-lg\":\"(4 \\/ 3)\",\"bs4-line-height-sm\":\"1.5\",\"bs4-border-radius\":\".25rem\",\"bs4-border-radius-lg\":\".3rem\",\"bs4-border-radius-sm\":\".2rem\",\"bs4-component-active-color\":\"$white\",\"bs4-component-active-bg\":\"$brand-primary\",\"bs4-caret-width\":\".3em\",\"bs4-caret-width-lg\":\"$caret-width\",\"bs4-transition-base\":\"all .2s ease-in-out\",\"bs4-transition-fade\":\"opacity .15s linear\",\"bs4-transition-collapse\":\"height .35s ease\",\"bs4-table-cell-padding\":\".75rem\",\"bs4-table-sm-cell-padding\":\".3rem\",\"bs4-table-bg\":\"transparent\",\"bs4-table-inverse-bg\":\"$gray-dark\",\"bs4-table-inverse-color\":\"$body-bg\",\"bs4-table-bg-accent\":\"rgba($black,.05)\",\"bs4-table-bg-hover\":\"rgba($black,.075)\",\"bs4-table-bg-active\":\"$table-bg-hover\",\"bs4-table-head-bg\":\"$gray-lighter\",\"bs4-table-head-color\":\"$gray\",\"bs4-table-border-width\":\"$border-width\",\"bs4-table-border-color\":\"$gray-lighter\",\"bs4-btn-padding-x\":\"1rem\",\"bs4-btn-padding-y\":\".5rem\",\"bs4-btn-line-height\":\"1.25\",\"bs4-btn-font-weight\":\"$font-weight-normal\",\"bs4-btn-box-shadow\":\"inset 0 1px 0 rgba($white,.15), 0 1px 1px rgba($black,.075)\",\"bs4-btn-focus-box-shadow\":\"0 0 0 2px rgba($brand-primary, .25)\",\"bs4-btn-active-box-shadow\":\"inset 0 3px 5px rgba($black,.125)\",\"bs4-btn-primary-color\":\"$white\",\"bs4-btn-primary-bg\":\"$brand-primary\",\"bs4-btn-primary-border\":\"$btn-primary-bg\",\"bs4-btn-secondary-color\":\"$gray-dark\",\"bs4-btn-secondary-bg\":\"$white\",\"bs4-btn-secondary-border\":\"#ccc\",\"bs4-btn-info-color\":\"$white\",\"bs4-btn-info-bg\":\"$brand-info\",\"bs4-btn-info-border\":\"$btn-info-bg\",\"bs4-btn-success-color\":\"$white\",\"bs4-btn-success-bg\":\"$brand-success\",\"bs4-btn-success-border\":\"$btn-success-bg\",\"bs4-btn-warning-color\":\"$white\",\"bs4-btn-warning-bg\":\"$brand-warning\",\"bs4-btn-warning-border\":\"$btn-warning-bg\",\"bs4-btn-danger-color\":\"$white\",\"bs4-btn-danger-bg\":\"$brand-danger\",\"bs4-btn-danger-border\":\"$btn-danger-bg\",\"bs4-btn-link-disabled-color\":\"$gray-light\",\"bs4-btn-padding-x-sm\":\".5rem\",\"bs4-btn-padding-y-sm\":\".25rem\",\"bs4-btn-padding-x-lg\":\"1.5rem\",\"bs4-btn-padding-y-lg\":\".75rem\",\"bs4-btn-block-spacing-y\":\".5rem\",\"bs4-btn-toolbar-margin\":\".5rem\",\"bs4-btn-border-radius\":\"$border-radius\",\"bs4-btn-border-radius-lg\":\"$border-radius-lg\",\"bs4-btn-border-radius-sm\":\"$border-radius-sm\",\"bs4-btn-transition\":\"all .2s ease-in-out\",\"bs4-input-padding-x\":\".75rem\",\"bs4-input-padding-y\":\".5rem\",\"bs4-input-line-height\":\"1.25\",\"bs4-input-bg\":\"$white\",\"bs4-input-bg-disabled\":\"$gray-lighter\",\"bs4-input-color\":\"$gray\",\"bs4-input-border-color\":\"rgba($black,.15)\",\"bs4-input-btn-border-width\":\"$border-width\",\"bs4-input-box-shadow\":\"inset 0 1px 1px rgba($black,.075)\",\"bs4-input-border-radius\":\"$border-radius\",\"bs4-input-border-radius-lg\":\"$border-radius-lg\",\"bs4-input-border-radius-sm\":\"$border-radius-sm\",\"bs4-input-bg-focus\":\"$input-bg\",\"bs4-input-border-focus\":\"lighten($brand-primary, 25%)\",\"bs4-input-box-shadow-focus\":\"$input-box-shadow, rgba($input-border-focus, .6)\",\"bs4-input-color-focus\":\"$input-color\",\"bs4-input-color-placeholder\":\"$gray-light\",\"bs4-input-padding-x-sm\":\".5rem\",\"bs4-input-padding-y-sm\":\".25rem\",\"bs4-input-padding-x-lg\":\"1.5rem\",\"bs4-input-padding-y-lg\":\".75rem\",\"bs4-input-height\":\"(($font-size-base * $input-line-height) + ($input-padding-y * 2))\",\"bs4-input-height-lg\":\"(($font-size-lg * $line-height-lg) + ($input-padding-y-lg * 2))\",\"bs4-input-height-sm\":\"(($font-size-sm * $line-height-sm) + ($input-padding-y-sm * 2))\",\"bs4-input-transition\":\"border-color ease-in-out .15s, box-shadow ease-in-out .15s\",\"bs4-form-text-margin-top\":\".25rem\",\"bs4-form-feedback-margin-top\":\"$form-text-margin-top\",\"bs4-form-check-margin-bottom\":\".5rem\",\"bs4-form-check-input-gutter\":\"1.25rem\",\"bs4-form-check-input-margin-y\":\".25rem\",\"bs4-form-check-input-margin-x\":\".25rem\",\"bs4-form-check-inline-margin-x\":\".75rem\",\"bs4-form-group-margin-bottom\":\"$spacer-y\",\"bs4-input-group-addon-bg\":\"$gray-lighter\",\"bs4-input-group-addon-border-color\":\"$input-border-color\",\"bs4-cursor-disabled\":\"not-allowed\",\"bs4-custom-control-gutter\":\"1.5rem\",\"bs4-custom-control-spacer-x\":\"1rem\",\"bs4-custom-control-spacer-y\":\".25rem\",\"bs4-custom-control-indicator-size\":\"1rem\",\"bs4-custom-control-indicator-margin-y\":\"(($line-height-base * 1rem) - $custom-control-indicator-size) \\/ -2\",\"bs4-custom-control-indicator-bg\":\"#ddd\",\"bs4-custom-control-indicator-bg-size\":\"50% 50%\",\"bs4-custom-control-indicator-box-shadow\":\"inset 0 .25rem .25rem rgba($black,.1)\",\"bs4-custom-control-disabled-cursor\":\"$cursor-disabled\",\"bs4-custom-control-disabled-indicator-bg\":\"$gray-lighter\",\"bs4-custom-control-disabled-description-color\":\"$gray-light\",\"bs4-custom-control-checked-indicator-color\":\"$white\",\"bs4-custom-control-checked-indicator-bg\":\"$brand-primary\",\"bs4-custom-control-checked-indicator-box-shadow\":\"none\",\"bs4-custom-control-focus-indicator-box-shadow\":\"0 0 0 1px $body-bg, 0 0 0 3px $brand-primary\",\"bs4-custom-control-active-indicator-color\":\"$white\",\"bs4-custom-control-active-indicator-bg\":\"lighten($brand-primary, 35%)\",\"bs4-custom-control-active-indicator-box-shadow\":\"none\",\"bs4-custom-checkbox-radius\":\"$border-radius\",\"bs4-custom-checkbox-indeterminate-bg\":\"$brand-primary\",\"bs4-custom-checkbox-indeterminate-indicator-color\":\"$custom-control-checked-indicator-color\",\"bs4-custom-checkbox-indeterminate-box-shadow\":\"none\",\"bs4-custom-radio-radius\":\"50%\",\"bs4-custom-select-padding-x\":\".75rem\",\"bs4-custom-select-padding-y\":\".375rem\",\"bs4-custom-select-indicator-padding\":\"1rem\",\"bs4-custom-select-line-height\":\"$input-line-height\",\"bs4-custom-select-color\":\"$input-color\",\"bs4-custom-select-disabled-color\":\"$gray-light\",\"bs4-custom-select-bg\":\"$white\",\"bs4-custom-select-disabled-bg\":\"$gray-lighter\",\"bs4-custom-select-bg-size\":\"8px 10px\",\"bs4-custom-select-indicator-color\":\"#333\",\"bs4-custom-select-border-width\":\"$input-btn-border-width\",\"bs4-custom-select-border-color\":\"$input-border-color\",\"bs4-custom-select-border-radius\":\"$border-radius\",\"bs4-custom-select-focus-border-color\":\"lighten($brand-primary, 25%)\",\"bs4-custom-select-focus-box-shadow\":\"inset 0 1px 2px rgba($black, .075), 0 0 5px rgba($custom-select-focus-border-color, .5)\",\"bs4-custom-select-sm-padding-y\":\".2rem\",\"bs4-custom-select-sm-font-size\":\"75%\",\"bs4-custom-file-height\":\"2.5rem\",\"bs4-custom-file-width\":\"14rem\",\"bs4-custom-file-focus-box-shadow\":\"0 0 0 .075rem $white, 0 0 0 .2rem $brand-primary\",\"bs4-custom-file-padding-x\":\".5rem\",\"bs4-custom-file-padding-y\":\"1rem\",\"bs4-custom-file-line-height\":\"1.5\",\"bs4-custom-file-color\":\"$gray\",\"bs4-custom-file-bg\":\"$white\",\"bs4-custom-file-border-width\":\"$border-width\",\"bs4-custom-file-border-color\":\"$input-border-color\",\"bs4-custom-file-border-radius\":\"$border-radius\",\"bs4-custom-file-box-shadow\":\"inset 0 .2rem .4rem rgba($black,.05)\",\"bs4-custom-file-button-color\":\"$custom-file-color\",\"bs4-custom-file-button-bg\":\"$gray-lighter\",\"bs4-custom-file-text-placeholder-en\":\"\\\"Choose file...\\\"\",\"bs4-custom-file-text-placeholder-de\":\"\\\"Datei ausw\\u00e4hlen...\\\"\",\"bs4-custom-file-text-button-label-en\":\"\\\"Browse\\\"\",\"bs4-custom-file-text-button-label-de\":\"\\\"Durchsuchen\\\"\",\"bs4-form-icon-success-color\":\"$brand-success\",\"bs4-form-icon-warning-color\":\"$brand-warning\",\"bs4-form-icon-danger-color\":\"$brand-danger\",\"bs4-dropdown-min-width\":\"10rem\",\"bs4-dropdown-padding-y\":\".5rem\",\"bs4-dropdown-margin-top\":\".125rem\",\"bs4-dropdown-bg\":\"$white\",\"bs4-dropdown-border-color\":\"rgba($black,.15)\",\"bs4-dropdown-border-width\":\"$border-width\",\"bs4-dropdown-divider-bg\":\"$gray-lighter\",\"bs4-dropdown-box-shadow\":\"0 .5rem 1rem rgba($black,.175)\",\"bs4-dropdown-link-color\":\"$gray-dark\",\"bs4-dropdown-link-hover-color\":\"darken($gray-dark, 5%)\",\"bs4-dropdown-link-hover-bg\":\"$gray-lightest\",\"bs4-dropdown-link-active-color\":\"$component-active-color\",\"bs4-dropdown-link-active-bg\":\"$component-active-bg\",\"bs4-dropdown-link-disabled-color\":\"$gray-light\",\"bs4-dropdown-item-padding-x\":\"1.5rem\",\"bs4-dropdown-header-color\":\"$gray-light\",\"bs4-zindex-dropdown-backdrop\":\"990\",\"bs4-zindex-navbar\":\"1000\",\"bs4-zindex-dropdown\":\"1000\",\"bs4-zindex-fixed\":\"1030\",\"bs4-zindex-sticky\":\"1030\",\"bs4-zindex-modal-backdrop\":\"1040\",\"bs4-zindex-modal\":\"1050\",\"bs4-zindex-popover\":\"1060\",\"bs4-zindex-tooltip\":\"1070\",\"bs4-navbar-border-radius\":\"$border-radius\",\"bs4-navbar-padding-x\":\"$spacer\",\"bs4-navbar-padding-y\":\"($spacer \\/ 2)\",\"bs4-navbar-brand-padding-y\":\".25rem\",\"bs4-navbar-toggler-padding-x\":\".75rem\",\"bs4-navbar-toggler-padding-y\":\".25rem\",\"bs4-navbar-toggler-font-size\":\"$font-size-lg\",\"bs4-navbar-toggler-border-radius\":\"$btn-border-radius\",\"bs4-navbar-inverse-color\":\"rgba($white,.5)\",\"bs4-navbar-inverse-hover-color\":\"rgba($white,.75)\",\"bs4-navbar-inverse-active-color\":\"rgba($white,1)\",\"bs4-navbar-inverse-disabled-color\":\"rgba($white,.25)\",\"bs4-navbar-inverse-toggler-border\":\"rgba($white,.1)\",\"bs4-navbar-light-color\":\"rgba($black,.5)\",\"bs4-navbar-light-hover-color\":\"rgba($black,.7)\",\"bs4-navbar-light-active-color\":\"rgba($black,.9)\",\"bs4-navbar-light-disabled-color\":\"rgba($black,.3)\",\"bs4-navbar-light-toggler-border\":\"rgba($black,.1)\",\"bs4-nav-item-margin\":\".2rem\",\"bs4-nav-item-inline-spacer\":\"1rem\",\"bs4-nav-link-padding\":\".5em 1em\",\"bs4-nav-link-hover-bg\":\"$gray-lighter\",\"bs4-nav-disabled-link-color\":\"$gray-light\",\"bs4-nav-disabled-link-hover-color\":\"$gray-light\",\"bs4-nav-disabled-link-hover-bg\":\"transparent\",\"bs4-nav-tabs-border-color\":\"#ddd\",\"bs4-nav-tabs-border-width\":\"$border-width\",\"bs4-nav-tabs-border-radius\":\"$border-radius\",\"bs4-nav-tabs-link-hover-border-color\":\"$gray-lighter\",\"bs4-nav-tabs-active-link-hover-color\":\"$gray\",\"bs4-nav-tabs-active-link-hover-bg\":\"$body-bg\",\"bs4-nav-tabs-active-link-hover-border-color\":\"#ddd\",\"bs4-nav-tabs-justified-link-border-color\":\"#ddd\",\"bs4-nav-tabs-justified-active-link-border-color\":\"$body-bg\",\"bs4-nav-pills-border-radius\":\"$border-radius\",\"bs4-nav-pills-active-link-color\":\"$component-active-color\",\"bs4-nav-pills-active-link-bg\":\"$component-active-bg\",\"bs4-pagination-padding-x\":\".75rem\",\"bs4-pagination-padding-y\":\".5rem\",\"bs4-pagination-padding-x-sm\":\".5rem\",\"bs4-pagination-padding-y-sm\":\".25rem\",\"bs4-pagination-padding-x-lg\":\"1.5rem\",\"bs4-pagination-padding-y-lg\":\".75rem\",\"bs4-pagination-line-height\":\"1.25\",\"bs4-pagination-color\":\"$link-color\",\"bs4-pagination-bg\":\"$white\",\"bs4-pagination-border-width\":\"$border-width\",\"bs4-pagination-border-color\":\"#ddd\",\"bs4-pagination-hover-color\":\"$link-hover-color\",\"bs4-pagination-hover-bg\":\"$gray-lighter\",\"bs4-pagination-hover-border\":\"#ddd\",\"bs4-pagination-active-color\":\"$white\",\"bs4-pagination-active-bg\":\"$brand-primary\",\"bs4-pagination-active-border\":\"$brand-primary\",\"bs4-pagination-disabled-color\":\"$gray-light\",\"bs4-pagination-disabled-bg\":\"$white\",\"bs4-pagination-disabled-border\":\"#ddd\",\"bs4-jumbotron-padding\":\"2rem\",\"bs4-jumbotron-bg\":\"$gray-lighter\",\"bs4-state-success-text\":\"#3c763d\",\"bs4-state-success-bg\":\"#dff0d8\",\"bs4-state-success-border\":\"darken($state-success-bg, 5%)\",\"bs4-state-info-text\":\"#31708f\",\"bs4-state-info-bg\":\"#d9edf7\",\"bs4-state-info-border\":\"darken($state-info-bg, 7%)\",\"bs4-state-warning-text\":\"#8a6d3b\",\"bs4-state-warning-bg\":\"#fcf8e3\",\"bs4-mark-bg\":\"$state-warning-bg\",\"bs4-state-warning-border\":\"darken($state-warning-bg, 5%)\",\"bs4-state-danger-text\":\"#a94442\",\"bs4-state-danger-bg\":\"#f2dede\",\"bs4-state-danger-border\":\"darken($state-danger-bg, 5%)\",\"bs4-card-spacer-x\":\"1.25rem\",\"bs4-card-spacer-y\":\".75rem\",\"bs4-card-border-width\":\"1px\",\"bs4-card-border-radius\":\"$border-radius\",\"bs4-card-border-color\":\"rgba($black,.125)\",\"bs4-card-border-radius-inner\":\"calc(#{$card-border-radius} - #{$card-border-width})\",\"bs4-card-cap-bg\":\"$gray-lightest\",\"bs4-card-bg\":\"$white\",\"bs4-card-link-hover-color\":\"$white\",\"bs4-card-img-overlay-padding\":\"1.25rem\",\"bs4-card-deck-margin\":\"($grid-gutter-width-base \\/ 2)\",\"bs4-card-columns-sm-up-column-gap\":\"1.25rem\",\"bs4-card-columns-count\":\"3\",\"bs4-card-columns-gap\":\"1.25rem\",\"bs4-card-columns-margin\":\"$card-spacer-y\",\"bs4-tooltip-max-width\":\"200px\",\"bs4-tooltip-color\":\"$white\",\"bs4-tooltip-bg\":\"$black\",\"bs4-tooltip-opacity\":\".9\",\"bs4-tooltip-padding-y\":\"3px\",\"bs4-tooltip-padding-x\":\"8px\",\"bs4-tooltip-margin\":\"3px\",\"bs4-tooltip-arrow-width\":\"5px\",\"bs4-tooltip-arrow-color\":\"$tooltip-bg\",\"bs4-popover-inner-padding\":\"1px\",\"bs4-popover-bg\":\"$white\",\"bs4-popover-max-width\":\"276px\",\"bs4-popover-border-width\":\"$border-width\",\"bs4-popover-border-color\":\"rgba($black,.2)\",\"bs4-popover-box-shadow\":\"0 5px 10px rgba($black,.2)\",\"bs4-popover-title-bg\":\"darken($popover-bg, 3%)\",\"bs4-popover-title-padding-x\":\"14px\",\"bs4-popover-title-padding-y\":\"8px\",\"bs4-popover-content-padding-x\":\"14px\",\"bs4-popover-content-padding-y\":\"9px\",\"bs4-popover-arrow-width\":\"10px\",\"bs4-popover-arrow-color\":\"$popover-bg\",\"bs4-popover-arrow-outer-width\":\"($popover-arrow-width + 1px)\",\"bs4-popover-arrow-outer-color\":\"fade-in($popover-border-color, .05)\",\"bs4-badge-default-bg\":\"$gray-light\",\"bs4-badge-primary-bg\":\"$brand-primary\",\"bs4-badge-success-bg\":\"$brand-success\",\"bs4-badge-info-bg\":\"$brand-info\",\"bs4-badge-warning-bg\":\"$brand-warning\",\"bs4-badge-danger-bg\":\"$brand-danger\",\"bs4-badge-color\":\"$white\",\"bs4-badge-link-hover-color\":\"$white\",\"bs4-badge-font-size\":\"75%\",\"bs4-badge-font-weight\":\"bold\",\"bs4-badge-padding-x\":\".4em\",\"bs4-badge-padding-y\":\".25em\",\"bs4-badge-pill-padding-x\":\".6em\",\"bs4-badge-pill-border-radius\":\"10rem\",\"bs4-modal-inner-padding\":\"15px\",\"bs4-modal-dialog-margin\":\"10px\",\"bs4-modal-dialog-sm-up-margin-y\":\"30px\",\"bs4-modal-title-line-height\":\"$line-height-base\",\"bs4-modal-content-bg\":\"$white\",\"bs4-modal-content-border-color\":\"rgba($black,.2)\",\"bs4-modal-content-border-width\":\"$border-width\",\"bs4-modal-content-xs-box-shadow\":\"0 3px 9px rgba($black,.5)\",\"bs4-modal-content-sm-up-box-shadow\":\"0 5px 15px rgba($black,.5)\",\"bs4-modal-backdrop-bg\":\"$black\",\"bs4-modal-backdrop-opacity\":\".5\",\"bs4-modal-header-border-color\":\"$gray-lighter\",\"bs4-modal-footer-border-color\":\"$modal-header-border-color\",\"bs4-modal-header-border-width\":\"$modal-content-border-width\",\"bs4-modal-footer-border-width\":\"$modal-header-border-width\",\"bs4-modal-header-padding\":\"15px\",\"bs4-modal-lg\":\"800px\",\"bs4-modal-md\":\"500px\",\"bs4-modal-sm\":\"300px\",\"bs4-modal-transition\":\"transform .3s ease-out\",\"bs4-alert-padding-x\":\"1.25rem\",\"bs4-alert-padding-y\":\".75rem\",\"bs4-alert-margin-bottom\":\"$spacer-y\",\"bs4-alert-border-radius\":\"$border-radius\",\"bs4-alert-link-font-weight\":\"$font-weight-bold\",\"bs4-alert-border-width\":\"$border-width\",\"bs4-alert-success-bg\":\"$state-success-bg\",\"bs4-alert-success-text\":\"$state-success-text\",\"bs4-alert-success-border\":\"$state-success-border\",\"bs4-alert-info-bg\":\"$state-info-bg\",\"bs4-alert-info-text\":\"$state-info-text\",\"bs4-alert-info-border\":\"$state-info-border\",\"bs4-alert-warning-bg\":\"$state-warning-bg\",\"bs4-alert-warning-text\":\"$state-warning-text\",\"bs4-alert-warning-border\":\"$state-warning-border\",\"bs4-alert-danger-bg\":\"$state-danger-bg\",\"bs4-alert-danger-text\":\"$state-danger-text\",\"bs4-alert-danger-border\":\"$state-danger-border\",\"bs4-progress-height\":\"1rem\",\"bs4-progress-font-size\":\".75rem\",\"bs4-progress-bg\":\"$gray-lighter\",\"bs4-progress-border-radius\":\"$border-radius\",\"bs4-progress-box-shadow\":\"inset 0 .1rem .1rem rgba($black,.1)\",\"bs4-progress-bar-color\":\"$white\",\"bs4-progress-bar-bg\":\"$brand-primary\",\"bs4-progress-bar-animation-timing\":\"1s linear infinite\",\"bs4-list-group-color\":\"$body-color\",\"bs4-list-group-bg\":\"transparent\",\"bs4-list-group-border-color\":\"rgba($black,.125)\",\"bs4-list-group-border-width\":\"$border-width\",\"bs4-list-group-border-radius\":\"$border-radius\",\"bs4-list-group-item-padding-x\":\"1.25rem\",\"bs4-list-group-item-padding-y\":\".75rem\",\"bs4-list-group-hover-bg\":\"$gray-lightest\",\"bs4-list-group-active-color\":\"$component-active-color\",\"bs4-list-group-active-bg\":\"$component-active-bg\",\"bs4-list-group-active-border\":\"$list-group-active-bg\",\"bs4-list-group-active-text-color\":\"lighten($list-group-active-bg, 50%)\",\"bs4-list-group-disabled-color\":\"$gray-light\",\"bs4-list-group-disabled-bg\":\"$list-group-bg\",\"bs4-list-group-disabled-text-color\":\"$list-group-disabled-color\",\"bs4-list-group-link-color\":\"$gray\",\"bs4-list-group-link-heading-color\":\"$gray-dark\",\"bs4-list-group-link-hover-color\":\"$list-group-link-color\",\"bs4-list-group-link-active-color\":\"$list-group-color\",\"bs4-list-group-link-active-bg\":\"$gray-lighter\",\"bs4-thumbnail-padding\":\".25rem\",\"bs4-thumbnail-bg\":\"$body-bg\",\"bs4-thumbnail-border-width\":\"$border-width\",\"bs4-thumbnail-border-color\":\"#ddd\",\"bs4-thumbnail-border-radius\":\"$border-radius\",\"bs4-thumbnail-box-shadow\":\"0 1px 2px rgba($black,.075)\",\"bs4-thumbnail-transition\":\"all .2s ease-in-out\",\"bs4-figure-caption-font-size\":\"90%\",\"bs4-figure-caption-color\":\"$gray-light\",\"bs4-breadcrumb-padding-y\":\".75rem\",\"bs4-breadcrumb-padding-x\":\"1rem\",\"bs4-breadcrumb-item-padding\":\".5rem\",\"bs4-breadcrumb-bg\":\"$gray-lighter\",\"bs4-breadcrumb-divider-color\":\"$gray-light\",\"bs4-breadcrumb-active-color\":\"$gray-light\",\"bs4-breadcrumb-divider\":\"\\\"\\/\\\"\",\"bs4-media-margin-top\":\"15px\",\"bs4-media-heading-margin-bottom\":\"5px\",\"bs4-media-alignment-padding-x\":\"10px\",\"bs4-carousel-control-color\":\"$white\",\"bs4-carousel-control-width\":\"15%\",\"bs4-carousel-control-opacity\":\".5\",\"bs4-carousel-indicator-width\":\"30px\",\"bs4-carousel-indicator-height\":\"3px\",\"bs4-carousel-indicator-spacer\":\"3px\",\"bs4-carousel-indicator-active-bg\":\"$white\",\"bs4-carousel-caption-width\":\"70%\",\"bs4-carousel-caption-color\":\"$white\",\"bs4-carousel-control-icon-width\":\"20px\",\"bs4-carousel-transition\":\"transform .6s ease-in-out\",\"bs4-close-font-size\":\"$font-size-base * 1.5\",\"bs4-close-font-weight\":\"$font-weight-bold\",\"bs4-close-color\":\"$black\",\"bs4-close-text-shadow\":\"0 1px 0 $white\",\"bs4-code-font-size\":\"90%\",\"bs4-code-padding-x\":\".4rem\",\"bs4-code-padding-y\":\".2rem\",\"bs4-code-color\":\"#bd4147\",\"bs4-code-bg\":\"$gray-lightest\",\"bs4-kbd-color\":\"$white\",\"bs4-kbd-bg\":\"$gray-dark\",\"bs4-pre-bg\":\"$gray-lightest\",\"bs4-pre-color\":\"$gray-dark\",\"bs4-pre-border-color\":\"#ccc\",\"bs4-pre-scrollable-max-height\":\"340px\"}','2017-08-12 00:23:16','2017-08-12 00:23:16'),
    (2,'ksoft-ksoft-bulma','{\"site_name\":\"Bulma theme for OctoberCMS\",\"site_slogan\":\"Another amazing OctoberCMS Theme!\",\"site_author\":\"Sunnyface.com\",\"site_url\":\"http:\\/\\/october.sunnyface.com\\/?demos=true&theme=bulma&color=purple\",\"description\":\"OctoberCMS theme for developpers.\",\"keywords\":\"bulma,octobercms,vuejs,buefy\",\"primary_color\":\"#300032\",\"load_octobercms_framework\":false,\"load_material_icons\":false,\"load_animate_css\":true,\"load_wow_js\":false,\"social_icon_size\":\"is-normale\"}','2017-08-16 00:08:32','2017-08-16 00:08:32');

/*!40000 ALTER TABLE `cms_theme_data` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cms_theme_logs
# ------------------------------------------------------------

CREATE TABLE `cms_theme_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `theme` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `template` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `old_template` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` longtext COLLATE utf8_unicode_ci,
  `old_content` longtext COLLATE utf8_unicode_ci,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cms_theme_logs_type_index` (`type`),
  KEY `cms_theme_logs_theme_index` (`theme`),
  KEY `cms_theme_logs_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table deferred_bindings
# ------------------------------------------------------------

CREATE TABLE `deferred_bindings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `master_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `master_field` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slave_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slave_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `session_key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `is_bind` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deferred_bindings_master_type_index` (`master_type`),
  KEY `deferred_bindings_master_field_index` (`master_field`),
  KEY `deferred_bindings_slave_type_index` (`slave_type`),
  KEY `deferred_bindings_slave_id_index` (`slave_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table failed_jobs
# ------------------------------------------------------------

CREATE TABLE `failed_jobs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8_unicode_ci NOT NULL,
  `queue` text COLLATE utf8_unicode_ci NOT NULL,
  `payload` text COLLATE utf8_unicode_ci NOT NULL,
  `failed_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table feegleweb_octoshop_categories
# ------------------------------------------------------------

CREATE TABLE `feegleweb_octoshop_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_visible` tinyint(1) NOT NULL DEFAULT '1',
  `parent_id` int(10) unsigned DEFAULT NULL,
  `nest_left` int(11) NOT NULL DEFAULT '0',
  `nest_right` int(11) NOT NULL DEFAULT '0',
  `nest_depth` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `feegleweb_octoshop_categories_slug_unique` (`slug`),
  KEY `feegleweb_octoshop_categories_title_index` (`name`),
  KEY `feegleweb_octoshop_categories_parent_id_index` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table feegleweb_octoshop_orders
# ------------------------------------------------------------

CREATE TABLE `feegleweb_octoshop_orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `items` text COLLATE utf8_unicode_ci NOT NULL,
  `total` decimal(7,2) NOT NULL,
  `is_paid` tinyint(1) NOT NULL DEFAULT '0',
  `stripe_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_street` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_town` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_county` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_postcode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shipping_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shipping_street` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shipping_town` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shipping_county` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shipping_postcode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shipping_country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table feegleweb_octoshop_prod_cat
# ------------------------------------------------------------

CREATE TABLE `feegleweb_octoshop_prod_cat` (
  `product_id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table feegleweb_octoshop_products
# ------------------------------------------------------------

CREATE TABLE `feegleweb_octoshop_products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intro` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` decimal(20,5) DEFAULT '0.00000',
  `is_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_stockable` tinyint(1) NOT NULL DEFAULT '0',
  `stock` int(11) DEFAULT '0',
  `available_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `feegleweb_octoshop_products_slug_unique` (`slug`),
  KEY `feegleweb_octoshop_products_title_index` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table getright_services_services
# ------------------------------------------------------------

CREATE TABLE `getright_services_services` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(55) COLLATE utf8_unicode_ci NOT NULL,
  `text` text COLLATE utf8_unicode_ci NOT NULL,
  `link` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table hare_attribute
# ------------------------------------------------------------

CREATE TABLE `hare_attribute` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `group_id` int(10) unsigned NOT NULL,
  `type` tinyint(4) NOT NULL COMMENT '1: product, 2 : customer, 3: category, 4: order',
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hare_attribute_group_id_foreign` (`group_id`),
  CONSTRAINT `hare_attribute_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `hare_attribute_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `hare_attribute` WRITE;
/*!40000 ALTER TABLE `hare_attribute` DISABLE KEYS */;

INSERT INTO `hare_attribute` (`id`, `name`, `group_id`, `type`, `slug`)
VALUES
    (1,'attribute 1',1,1,'attribute_1');

/*!40000 ALTER TABLE `hare_attribute` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table hare_attribute_group
# ------------------------------------------------------------

CREATE TABLE `hare_attribute_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `hare_attribute_group` WRITE;
/*!40000 ALTER TABLE `hare_attribute_group` DISABLE KEYS */;

INSERT INTO `hare_attribute_group` (`id`, `name`, `description`)
VALUES
    (1,'Group 1','');

/*!40000 ALTER TABLE `hare_attribute_group` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table hare_categories
# ------------------------------------------------------------

CREATE TABLE `hare_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `pretty_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `parent_id` int(10) unsigned NOT NULL,
  `nest_left` int(10) unsigned NOT NULL,
  `nest_right` int(10) unsigned NOT NULL,
  `nest_depth` int(10) unsigned NOT NULL,
  `status` tinyint(4) NOT NULL,
  `seo_title` text COLLATE utf8_unicode_ci,
  `seo_keyword` text COLLATE utf8_unicode_ci,
  `seo_description` text COLLATE utf8_unicode_ci,
  `featured_image` text COLLATE utf8_unicode_ci,
  `description` text COLLATE utf8_unicode_ci,
  `cat_order` int(10) unsigned DEFAULT NULL,
  `attribute_json` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `hare_categories` WRITE;
/*!40000 ALTER TABLE `hare_categories` DISABLE KEYS */;

INSERT INTO `hare_categories` (`id`, `name`, `pretty_url`, `parent_id`, `nest_left`, `nest_right`, `nest_depth`, `status`, `seo_title`, `seo_keyword`, `seo_description`, `featured_image`, `description`, `cat_order`, `attribute_json`, `created_at`, `updated_at`)
VALUES
    (1,'Uncategory','uncategory',0,1,2,0,1,'','','','',NULL,NULL,NULL,'2017-06-30 01:34:33','2017-06-30 01:34:33');

/*!40000 ALTER TABLE `hare_categories` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table hare_city
# ------------------------------------------------------------

CREATE TABLE `hare_city` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `geo_zone_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hare_city_geo_zone_id_foreign` (`geo_zone_id`),
  CONSTRAINT `hare_city_geo_zone_id_foreign` FOREIGN KEY (`geo_zone_id`) REFERENCES `hare_geo_zone` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `hare_city` WRITE;
/*!40000 ALTER TABLE `hare_city` DISABLE KEYS */;

INSERT INTO `hare_city` (`id`, `name`, `geo_zone_id`)
VALUES
    (1,'city 1',1);

/*!40000 ALTER TABLE `hare_city` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table hare_currency
# ------------------------------------------------------------

CREATE TABLE `hare_currency` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `symbol` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `symbol_position` tinyint(4) NOT NULL COMMENT '0: before, 1: after',
  `value` double(15,8) DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `hare_currency` WRITE;
/*!40000 ALTER TABLE `hare_currency` DISABLE KEYS */;

INSERT INTO `hare_currency` (`id`, `name`, `code`, `symbol`, `symbol_position`, `value`, `date_modified`)
VALUES
    (1,'Us Dollar','USD','$',0,1.00000000,'2017-06-30 01:34:33');

/*!40000 ALTER TABLE `hare_currency` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table hare_filter
# ------------------------------------------------------------

CREATE TABLE `hare_filter` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `hare_filter` WRITE;
/*!40000 ALTER TABLE `hare_filter` DISABLE KEYS */;

INSERT INTO `hare_filter` (`id`, `name`)
VALUES
    (1,'color'),
    (2,'size'),
    (3,'brand');

/*!40000 ALTER TABLE `hare_filter` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table hare_filter_option
# ------------------------------------------------------------

CREATE TABLE `hare_filter_option` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `option_order` int(10) unsigned NOT NULL,
  `option_value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `option_type` tinyint(4) NOT NULL COMMENT '1: color, 2: text, 3: image',
  `filter_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hare_filter_option_filter_id_foreign` (`filter_id`),
  CONSTRAINT `hare_filter_option_filter_id_foreign` FOREIGN KEY (`filter_id`) REFERENCES `hare_filter` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `hare_filter_option` WRITE;
/*!40000 ALTER TABLE `hare_filter_option` DISABLE KEYS */;

INSERT INTO `hare_filter_option` (`id`, `name`, `option_order`, `option_value`, `option_type`, `filter_id`)
VALUES
    (1,'White',1,'#ffffff',1,1),
    (2,'Black',2,'#0f0f0f',1,1),
    (3,'S',1,'S',2,2),
    (4,'M',2,'M',2,2),
    (5,'L',3,'L',2,2),
    (6,'XL',4,'XL',2,2),
    (7,'Sony',1,'Sony',2,3),
    (8,'LG',2,'LG',2,3);

/*!40000 ALTER TABLE `hare_filter_option` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table hare_geo_zone
# ------------------------------------------------------------

CREATE TABLE `hare_geo_zone` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `hare_geo_zone` WRITE;
/*!40000 ALTER TABLE `hare_geo_zone` DISABLE KEYS */;

INSERT INTO `hare_geo_zone` (`id`, `name`, `description`)
VALUES
    (1,'Area 1','');

/*!40000 ALTER TABLE `hare_geo_zone` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table hare_length
# ------------------------------------------------------------

CREATE TABLE `hare_length` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `unit` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `value` decimal(15,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `hare_length` WRITE;
/*!40000 ALTER TABLE `hare_length` DISABLE KEYS */;

INSERT INTO `hare_length` (`id`, `name`, `unit`, `value`)
VALUES
    (1,'Centimeter','cm',1.00),
    (2,'Inch','in',0.39);

/*!40000 ALTER TABLE `hare_length` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table hare_order
# ------------------------------------------------------------

CREATE TABLE `hare_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `billing_name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `billing_address` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `billing_city_id` int(11) NOT NULL,
  `billing_email` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `billing_telephone` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `billing_post_code` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `shipping_name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `shipping_address` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `shipping_city_id` int(11) NOT NULL,
  `shipping_email` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `shipping_telephone` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `shipping_post_code` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `shipping_rule_id` int(11) NOT NULL,
  `payment_method_id` int(11) NOT NULL,
  `comment` text COLLATE utf8_unicode_ci,
  `shipping_cost` decimal(15,2) NOT NULL,
  `total` decimal(15,2) NOT NULL,
  `order_status_id` int(10) unsigned NOT NULL,
  `order_json` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hare_order_order_status_id_foreign` (`order_status_id`),
  CONSTRAINT `hare_order_order_status_id_foreign` FOREIGN KEY (`order_status_id`) REFERENCES `hare_order_status` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table hare_order_product
# ------------------------------------------------------------

CREATE TABLE `hare_order_product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `name` varchar(512) COLLATE utf8_unicode_ci NOT NULL,
  `qty` int(10) unsigned NOT NULL,
  `price_after_tax` decimal(15,2) NOT NULL,
  `total` decimal(15,2) NOT NULL,
  `weight` decimal(15,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hare_order_product_order_id_foreign` (`order_id`),
  CONSTRAINT `hare_order_product_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `hare_order` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table hare_order_status
# ------------------------------------------------------------

CREATE TABLE `hare_order_status` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `hare_order_status` WRITE;
/*!40000 ALTER TABLE `hare_order_status` DISABLE KEYS */;

INSERT INTO `hare_order_status` (`id`, `name`)
VALUES
    (1,'Pending'),
    (2,'Shipped'),
    (3,'Processing'),
    (4,'Complete'),
    (5,'Denied'),
    (6,'Failed'),
    (7,'Refunded'),
    (8,'Chargeback'),
    (9,'Canceled'),
    (10,'Voided'),
    (11,'Expired');

/*!40000 ALTER TABLE `hare_order_status` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table hare_order_status_change
# ------------------------------------------------------------

CREATE TABLE `hare_order_status_change` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `order_status_id` int(10) unsigned NOT NULL,
  `comment` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hare_order_status_change_order_id_foreign` (`order_id`),
  CONSTRAINT `hare_order_status_change_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `hare_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table hare_product
# ------------------------------------------------------------

CREATE TABLE `hare_product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `pretty_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sku` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` decimal(15,2) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `qty_order` int(11) DEFAULT '0',
  `featured_image` text COLLATE utf8_unicode_ci,
  `str_gallery` text COLLATE utf8_unicode_ci,
  `status` tinyint(4) NOT NULL,
  `product_order` int(10) unsigned DEFAULT NULL,
  `product_type` tinyint(4) NOT NULL,
  `tax_class_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `related_product` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `hare_product` WRITE;
/*!40000 ALTER TABLE `hare_product` DISABLE KEYS */;

INSERT INTO `hare_product` (`id`, `name`, `pretty_url`, `sku`, `price`, `qty`, `qty_order`, `featured_image`, `str_gallery`, `status`, `product_order`, `product_type`, `tax_class_id`, `created_at`, `updated_at`, `related_product`)
VALUES
    (1,'Product 1','product-1','',899.00,404,0,'/5.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (2,'Product 2','product-2','',365.00,85,0,'/3.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (3,'Product 3','product-3','',62.00,850,0,'/7.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (4,'Product 4','product-4','',106.00,660,0,'/10.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (5,'Product 5','product-5','',538.00,189,0,'/4.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (6,'Product 6','product-6','',488.00,511,0,'/3.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (7,'Product 7','product-7','',627.00,918,0,'/5.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (8,'Product 8','product-8','',100.00,440,0,'/5.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (9,'Product 9','product-9','',976.00,329,0,'/4.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (10,'Product 10','product-10','',533.00,59,0,'/6.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (11,'Product 11','product-11','',656.00,949,0,'/10.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (12,'Product 12','product-12','',146.00,314,0,'/1.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (13,'Product 13','product-13','',439.00,366,0,'/10.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (14,'Product 14','product-14','',90.00,463,0,'/6.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (15,'Product 15','product-15','',65.00,991,0,'/8.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (16,'Product 16','product-16','',407.00,478,0,'/3.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (17,'Product 17','product-17','',638.00,105,0,'/2.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (18,'Product 18','product-18','',126.00,195,0,'/6.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (19,'Product 19','product-19','',567.00,171,0,'/10.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (20,'Product 20','product-20','',933.00,695,0,'/10.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (21,'Product 21','product-21','',517.00,351,0,'/10.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (22,'Product 22','product-22','',496.00,487,0,'/3.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (23,'Product 23','product-23','',551.00,916,0,'/6.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (24,'Product 24','product-24','',456.00,997,0,'/1.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (25,'Product 25','product-25','',20.00,61,0,'/1.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (26,'Product 26','product-26','',754.00,458,0,'/6.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (27,'Product 27','product-27','',999.00,96,0,'/7.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (28,'Product 28','product-28','',171.00,213,0,'/8.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (29,'Product 29','product-29','',764.00,770,0,'/10.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (30,'Product 30','product-30','',686.00,703,0,'/7.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (31,'Product 31','product-31','',657.00,220,0,'/10.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (32,'Product 32','product-32','',578.00,706,0,'/5.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (33,'Product 33','product-33','',802.00,257,0,'/4.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (34,'Product 34','product-34','',392.00,703,0,'/4.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (35,'Product 35','product-35','',436.00,713,0,'/5.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (36,'Product 36','product-36','',470.00,467,0,'/9.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (37,'Product 37','product-37','',973.00,466,0,'/10.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (38,'Product 38','product-38','',581.00,627,0,'/2.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (39,'Product 39','product-39','',375.00,391,0,'/10.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (40,'Product 40','product-40','',330.00,76,0,'/7.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (41,'Product 41','product-41','',971.00,724,0,'/9.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (42,'Product 42','product-42','',962.00,301,0,'/6.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (43,'Product 43','product-43','',440.00,103,0,'/9.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (44,'Product 44','product-44','',824.00,485,0,'/6.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (45,'Product 45','product-45','',213.00,912,0,'/3.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (46,'Product 46','product-46','',645.00,381,0,'/7.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (47,'Product 47','product-47','',535.00,354,0,'/2.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (48,'Product 48','product-48','',512.00,925,0,'/8.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (49,'Product 49','product-49','',692.00,299,0,'/2.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL),
    (50,'Product 50','product-50','',642.00,620,0,'/3.jpg','',1,NULL,1,1,'2017-06-30 01:34:33','2017-06-30 01:34:33',NULL);

/*!40000 ALTER TABLE `hare_product` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table hare_product_attribute
# ------------------------------------------------------------

CREATE TABLE `hare_product_attribute` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `short_intro` text COLLATE utf8_unicode_ci,
  `full_intro` text COLLATE utf8_unicode_ci,
  `seo_title` text COLLATE utf8_unicode_ci,
  `seo_keyword` text COLLATE utf8_unicode_ci,
  `seo_description` text COLLATE utf8_unicode_ci,
  `is_homepage` tinyint(4) NOT NULL,
  `is_featured_product` tinyint(4) NOT NULL,
  `attribute_json` text COLLATE utf8_unicode_ci,
  `weight` decimal(15,2) NOT NULL,
  `weight_id` int(10) unsigned NOT NULL,
  `length` decimal(15,2) DEFAULT NULL,
  `width` decimal(15,2) DEFAULT NULL,
  `height` decimal(15,2) DEFAULT NULL,
  `length_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hare_product_attribute_product_id_index` (`product_id`),
  CONSTRAINT `hare_product_attribute_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `hare_product` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `hare_product_attribute` WRITE;
/*!40000 ALTER TABLE `hare_product_attribute` DISABLE KEYS */;

INSERT INTO `hare_product_attribute` (`id`, `product_id`, `short_intro`, `full_intro`, `seo_title`, `seo_keyword`, `seo_description`, `is_homepage`, `is_featured_product`, `attribute_json`, `weight`, `weight_id`, `length`, `width`, `height`, `length_id`)
VALUES
    (1,1,'product 1','product 1','product 1','product 1','product 1',1,1,NULL,3.00,1,NULL,NULL,NULL,1),
    (2,2,'product 2','product 2','product 2','product 2','product 2',1,1,NULL,6.00,1,NULL,NULL,NULL,1),
    (3,3,'product 3','product 3','product 3','product 3','product 3',1,1,NULL,10.00,1,NULL,NULL,NULL,1),
    (4,4,'product 4','product 4','product 4','product 4','product 4',1,1,NULL,2.00,1,NULL,NULL,NULL,1),
    (5,5,'product 5','product 5','product 5','product 5','product 5',1,1,NULL,6.00,1,NULL,NULL,NULL,1),
    (6,6,'product 6','product 6','product 6','product 6','product 6',1,1,NULL,3.00,1,NULL,NULL,NULL,1),
    (7,7,'product 7','product 7','product 7','product 7','product 7',1,1,NULL,8.00,1,NULL,NULL,NULL,1),
    (8,8,'product 8','product 8','product 8','product 8','product 8',1,1,NULL,10.00,1,NULL,NULL,NULL,1),
    (9,9,'product 9','product 9','product 9','product 9','product 9',1,1,NULL,4.00,1,NULL,NULL,NULL,1),
    (10,10,'product 10','product 10','product 10','product 10','product 10',1,1,NULL,6.00,1,NULL,NULL,NULL,1),
    (11,11,'product 11','product 11','product 11','product 11','product 11',1,1,NULL,9.00,1,NULL,NULL,NULL,1),
    (12,12,'product 12','product 12','product 12','product 12','product 12',1,1,NULL,9.00,1,NULL,NULL,NULL,1),
    (13,13,'product 13','product 13','product 13','product 13','product 13',1,1,NULL,1.00,1,NULL,NULL,NULL,1),
    (14,14,'product 14','product 14','product 14','product 14','product 14',1,1,NULL,1.00,1,NULL,NULL,NULL,1),
    (15,15,'product 15','product 15','product 15','product 15','product 15',1,1,NULL,8.00,1,NULL,NULL,NULL,1),
    (16,16,'product 16','product 16','product 16','product 16','product 16',1,1,NULL,3.00,1,NULL,NULL,NULL,1),
    (17,17,'product 17','product 17','product 17','product 17','product 17',1,1,NULL,7.00,1,NULL,NULL,NULL,1),
    (18,18,'product 18','product 18','product 18','product 18','product 18',1,1,NULL,1.00,1,NULL,NULL,NULL,1),
    (19,19,'product 19','product 19','product 19','product 19','product 19',1,1,NULL,10.00,1,NULL,NULL,NULL,1),
    (20,20,'product 20','product 20','product 20','product 20','product 20',1,1,NULL,2.00,1,NULL,NULL,NULL,1),
    (21,21,'product 21','product 21','product 21','product 21','product 21',1,1,NULL,5.00,1,NULL,NULL,NULL,1),
    (22,22,'product 22','product 22','product 22','product 22','product 22',1,1,NULL,2.00,1,NULL,NULL,NULL,1),
    (23,23,'product 23','product 23','product 23','product 23','product 23',1,1,NULL,7.00,1,NULL,NULL,NULL,1),
    (24,24,'product 24','product 24','product 24','product 24','product 24',1,1,NULL,4.00,1,NULL,NULL,NULL,1),
    (25,25,'product 25','product 25','product 25','product 25','product 25',1,1,NULL,9.00,1,NULL,NULL,NULL,1),
    (26,26,'product 26','product 26','product 26','product 26','product 26',1,1,NULL,4.00,1,NULL,NULL,NULL,1),
    (27,27,'product 27','product 27','product 27','product 27','product 27',1,1,NULL,7.00,1,NULL,NULL,NULL,1),
    (28,28,'product 28','product 28','product 28','product 28','product 28',1,1,NULL,1.00,1,NULL,NULL,NULL,1),
    (29,29,'product 29','product 29','product 29','product 29','product 29',1,1,NULL,1.00,1,NULL,NULL,NULL,1),
    (30,30,'product 30','product 30','product 30','product 30','product 30',1,1,NULL,3.00,1,NULL,NULL,NULL,1),
    (31,31,'product 31','product 31','product 31','product 31','product 31',1,1,NULL,3.00,1,NULL,NULL,NULL,1),
    (32,32,'product 32','product 32','product 32','product 32','product 32',1,1,NULL,4.00,1,NULL,NULL,NULL,1),
    (33,33,'product 33','product 33','product 33','product 33','product 33',1,1,NULL,9.00,1,NULL,NULL,NULL,1),
    (34,34,'product 34','product 34','product 34','product 34','product 34',1,1,NULL,2.00,1,NULL,NULL,NULL,1),
    (35,35,'product 35','product 35','product 35','product 35','product 35',1,1,NULL,5.00,1,NULL,NULL,NULL,1),
    (36,36,'product 36','product 36','product 36','product 36','product 36',1,1,NULL,5.00,1,NULL,NULL,NULL,1),
    (37,37,'product 37','product 37','product 37','product 37','product 37',1,1,NULL,5.00,1,NULL,NULL,NULL,1),
    (38,38,'product 38','product 38','product 38','product 38','product 38',1,1,NULL,2.00,1,NULL,NULL,NULL,1),
    (39,39,'product 39','product 39','product 39','product 39','product 39',1,1,NULL,4.00,1,NULL,NULL,NULL,1),
    (40,40,'product 40','product 40','product 40','product 40','product 40',1,1,NULL,8.00,1,NULL,NULL,NULL,1),
    (41,41,'product 41','product 41','product 41','product 41','product 41',1,1,NULL,7.00,1,NULL,NULL,NULL,1),
    (42,42,'product 42','product 42','product 42','product 42','product 42',1,1,NULL,2.00,1,NULL,NULL,NULL,1),
    (43,43,'product 43','product 43','product 43','product 43','product 43',1,1,NULL,6.00,1,NULL,NULL,NULL,1),
    (44,44,'product 44','product 44','product 44','product 44','product 44',1,1,NULL,8.00,1,NULL,NULL,NULL,1),
    (45,45,'product 45','product 45','product 45','product 45','product 45',1,1,NULL,3.00,1,NULL,NULL,NULL,1),
    (46,46,'product 46','product 46','product 46','product 46','product 46',1,1,NULL,3.00,1,NULL,NULL,NULL,1),
    (47,47,'product 47','product 47','product 47','product 47','product 47',1,1,NULL,1.00,1,NULL,NULL,NULL,1),
    (48,48,'product 48','product 48','product 48','product 48','product 48',1,1,NULL,9.00,1,NULL,NULL,NULL,1),
    (49,49,'product 49','product 49','product 49','product 49','product 49',1,1,NULL,4.00,1,NULL,NULL,NULL,1),
    (50,50,'product 50','product 50','product 50','product 50','product 50',1,1,NULL,10.00,1,NULL,NULL,NULL,1);

/*!40000 ALTER TABLE `hare_product_attribute` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table hare_product_configurable
# ------------------------------------------------------------

CREATE TABLE `hare_product_configurable` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `str_filter_id` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `str_filter_option_id` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pc_product_id` int(10) unsigned DEFAULT NULL COMMENT 'id of product config child',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'id of product config parent',
  PRIMARY KEY (`id`),
  KEY `hare_product_configurable_product_id_foreign` (`product_id`),
  CONSTRAINT `hare_product_configurable_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `hare_product` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table hare_product_to_category
# ------------------------------------------------------------

CREATE TABLE `hare_product_to_category` (
  `product_id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `category_detail` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `hare_product_to_category_category_id_index` (`category_id`),
  KEY `hare_product_to_category_product_id_foreign` (`product_id`),
  CONSTRAINT `hare_product_to_category_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `hare_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `hare_product_to_category_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `hare_product` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `hare_product_to_category` WRITE;
/*!40000 ALTER TABLE `hare_product_to_category` DISABLE KEYS */;

INSERT INTO `hare_product_to_category` (`product_id`, `category_id`, `category_detail`)
VALUES
    (1,1,'1-0-Uncategory-0'),
    (2,1,'1-0-Uncategory-0'),
    (3,1,'1-0-Uncategory-0'),
    (4,1,'1-0-Uncategory-0'),
    (5,1,'1-0-Uncategory-0'),
    (6,1,'1-0-Uncategory-0'),
    (7,1,'1-0-Uncategory-0'),
    (8,1,'1-0-Uncategory-0'),
    (9,1,'1-0-Uncategory-0'),
    (10,1,'1-0-Uncategory-0'),
    (11,1,'1-0-Uncategory-0'),
    (12,1,'1-0-Uncategory-0'),
    (13,1,'1-0-Uncategory-0'),
    (14,1,'1-0-Uncategory-0'),
    (15,1,'1-0-Uncategory-0'),
    (16,1,'1-0-Uncategory-0'),
    (17,1,'1-0-Uncategory-0'),
    (18,1,'1-0-Uncategory-0'),
    (19,1,'1-0-Uncategory-0'),
    (20,1,'1-0-Uncategory-0'),
    (21,1,'1-0-Uncategory-0'),
    (22,1,'1-0-Uncategory-0'),
    (23,1,'1-0-Uncategory-0'),
    (24,1,'1-0-Uncategory-0'),
    (25,1,'1-0-Uncategory-0'),
    (26,1,'1-0-Uncategory-0'),
    (27,1,'1-0-Uncategory-0'),
    (28,1,'1-0-Uncategory-0'),
    (29,1,'1-0-Uncategory-0'),
    (30,1,'1-0-Uncategory-0'),
    (31,1,'1-0-Uncategory-0'),
    (32,1,'1-0-Uncategory-0'),
    (33,1,'1-0-Uncategory-0'),
    (34,1,'1-0-Uncategory-0'),
    (35,1,'1-0-Uncategory-0'),
    (36,1,'1-0-Uncategory-0'),
    (37,1,'1-0-Uncategory-0'),
    (38,1,'1-0-Uncategory-0'),
    (39,1,'1-0-Uncategory-0'),
    (40,1,'1-0-Uncategory-0'),
    (41,1,'1-0-Uncategory-0'),
    (42,1,'1-0-Uncategory-0'),
    (43,1,'1-0-Uncategory-0'),
    (44,1,'1-0-Uncategory-0'),
    (45,1,'1-0-Uncategory-0'),
    (46,1,'1-0-Uncategory-0'),
    (47,1,'1-0-Uncategory-0'),
    (48,1,'1-0-Uncategory-0'),
    (49,1,'1-0-Uncategory-0'),
    (50,1,'1-0-Uncategory-0');

/*!40000 ALTER TABLE `hare_product_to_category` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table hare_product_to_filter_option
# ------------------------------------------------------------

CREATE TABLE `hare_product_to_filter_option` (
  `product_id` int(10) unsigned NOT NULL,
  `filter_option_id` int(10) unsigned NOT NULL,
  KEY `hare_product_to_filter_option_filter_option_id_index` (`filter_option_id`),
  KEY `hare_product_to_filter_option_product_id_foreign` (`product_id`),
  CONSTRAINT `hare_product_to_filter_option_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `hare_product` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table hare_product_type
# ------------------------------------------------------------

CREATE TABLE `hare_product_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type_id` int(10) unsigned NOT NULL,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hare_product_type_type_id_unique` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `hare_product_type` WRITE;
/*!40000 ALTER TABLE `hare_product_type` DISABLE KEYS */;

INSERT INTO `hare_product_type` (`id`, `type_id`, `name`)
VALUES
    (1,1,'Simple'),
    (2,2,'Configurable'),
    (3,3,'Configurable Child');

/*!40000 ALTER TABLE `hare_product_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table hare_routes
# ------------------------------------------------------------

CREATE TABLE `hare_routes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pretty_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `entity_id` int(10) unsigned NOT NULL,
  `route_type` tinyint(4) NOT NULL COMMENT '0: product, 1: category',
  PRIMARY KEY (`id`),
  KEY `hare_routes_entity_id_index` (`entity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `hare_routes` WRITE;
/*!40000 ALTER TABLE `hare_routes` DISABLE KEYS */;

INSERT INTO `hare_routes` (`id`, `pretty_url`, `entity_id`, `route_type`)
VALUES
    (1,'uncategory',1,1),
    (2,'product-1',1,0),
    (3,'product-2',2,0),
    (4,'product-3',3,0),
    (5,'product-4',4,0),
    (6,'product-5',5,0),
    (7,'product-6',6,0),
    (8,'product-7',7,0),
    (9,'product-8',8,0),
    (10,'product-9',9,0),
    (11,'product-10',10,0),
    (12,'product-11',11,0),
    (13,'product-12',12,0),
    (14,'product-13',13,0),
    (15,'product-14',14,0),
    (16,'product-15',15,0),
    (17,'product-16',16,0),
    (18,'product-17',17,0),
    (19,'product-18',18,0),
    (20,'product-19',19,0),
    (21,'product-20',20,0),
    (22,'product-21',21,0),
    (23,'product-22',22,0),
    (24,'product-23',23,0),
    (25,'product-24',24,0),
    (26,'product-25',25,0),
    (27,'product-26',26,0),
    (28,'product-27',27,0),
    (29,'product-28',28,0),
    (30,'product-29',29,0),
    (31,'product-30',30,0),
    (32,'product-31',31,0),
    (33,'product-32',32,0),
    (34,'product-33',33,0),
    (35,'product-34',34,0),
    (36,'product-35',35,0),
    (37,'product-36',36,0),
    (38,'product-37',37,0),
    (39,'product-38',38,0),
    (40,'product-39',39,0),
    (41,'product-40',40,0),
    (42,'product-41',41,0),
    (43,'product-42',42,0),
    (44,'product-43',43,0),
    (45,'product-44',44,0),
    (46,'product-45',45,0),
    (47,'product-46',46,0),
    (48,'product-47',47,0),
    (49,'product-48',48,0),
    (50,'product-49',49,0),
    (51,'product-50',50,0);

/*!40000 ALTER TABLE `hare_routes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table hare_settings
# ------------------------------------------------------------

CREATE TABLE `hare_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `hare_settings` WRITE;
/*!40000 ALTER TABLE `hare_settings` DISABLE KEYS */;

INSERT INTO `hare_settings` (`id`, `name`, `value`)
VALUES
    (1,'plugin_setting','{\"currency_default\":\"1\"}');

/*!40000 ALTER TABLE `hare_settings` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table hare_ship_rule
# ------------------------------------------------------------

CREATE TABLE `hare_ship_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `above_price` decimal(15,2) DEFAULT NULL,
  `geo_zone_id` int(10) unsigned DEFAULT NULL,
  `shipping_method_weight` int(10) unsigned DEFAULT NULL,
  `cost` decimal(15,2) NOT NULL,
  `type` tinyint(4) NOT NULL COMMENT '0: price, 1: geo, 2: method, 3: per item',
  `status` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `hare_ship_rule` WRITE;
/*!40000 ALTER TABLE `hare_ship_rule` DISABLE KEYS */;

INSERT INTO `hare_ship_rule` (`id`, `name`, `above_price`, `geo_zone_id`, `shipping_method_weight`, `cost`, `type`, `status`)
VALUES
    (1,'Flat price',50.00,NULL,0,10.00,0,1),
    (2,'Pick up from store',0.00,NULL,0,0.00,0,1);

/*!40000 ALTER TABLE `hare_ship_rule` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table hare_tax_class
# ------------------------------------------------------------

CREATE TABLE `hare_tax_class` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `hare_tax_class` WRITE;
/*!40000 ALTER TABLE `hare_tax_class` DISABLE KEYS */;

INSERT INTO `hare_tax_class` (`id`, `name`, `description`)
VALUES
    (1,'Tax class 1','');

/*!40000 ALTER TABLE `hare_tax_class` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table hare_tax_rate
# ------------------------------------------------------------

CREATE TABLE `hare_tax_rate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` tinyint(4) NOT NULL COMMENT '0: percentage, 1: fixed amount',
  `geo_zone_id` int(10) unsigned NOT NULL,
  `rate` decimal(15,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hare_tax_rate_geo_zone_id_foreign` (`geo_zone_id`),
  CONSTRAINT `hare_tax_rate_geo_zone_id_foreign` FOREIGN KEY (`geo_zone_id`) REFERENCES `hare_geo_zone` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `hare_tax_rate` WRITE;
/*!40000 ALTER TABLE `hare_tax_rate` DISABLE KEYS */;

INSERT INTO `hare_tax_rate` (`id`, `name`, `type`, `geo_zone_id`, `rate`)
VALUES
    (1,'Tax rate 1',0,1,10.00);

/*!40000 ALTER TABLE `hare_tax_rate` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table hare_tax_rule
# ------------------------------------------------------------

CREATE TABLE `hare_tax_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tax_class_id` int(10) unsigned NOT NULL,
  `tax_rate_id` int(10) unsigned NOT NULL,
  `based` tinyint(4) NOT NULL COMMENT '0: customer address, 1: store address',
  PRIMARY KEY (`id`),
  KEY `hare_tax_rule_tax_class_id_foreign` (`tax_class_id`),
  KEY `hare_tax_rule_tax_rate_id_foreign` (`tax_rate_id`),
  CONSTRAINT `hare_tax_rule_tax_class_id_foreign` FOREIGN KEY (`tax_class_id`) REFERENCES `hare_tax_class` (`id`),
  CONSTRAINT `hare_tax_rule_tax_rate_id_foreign` FOREIGN KEY (`tax_rate_id`) REFERENCES `hare_tax_rate` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `hare_tax_rule` WRITE;
/*!40000 ALTER TABLE `hare_tax_rule` DISABLE KEYS */;

INSERT INTO `hare_tax_rule` (`id`, `tax_class_id`, `tax_rate_id`, `based`)
VALUES
    (1,1,1,0);

/*!40000 ALTER TABLE `hare_tax_rule` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table hare_users_extends
# ------------------------------------------------------------

CREATE TABLE `hare_users_extends` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `telephone` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `post_code` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `city_id` int(10) unsigned NOT NULL,
  `attribute_json` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table hare_weight
# ------------------------------------------------------------

CREATE TABLE `hare_weight` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `unit` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `value` decimal(15,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `hare_weight` WRITE;
/*!40000 ALTER TABLE `hare_weight` DISABLE KEYS */;

INSERT INTO `hare_weight` (`id`, `name`, `unit`, `value`)
VALUES
    (1,'Kilograms','Kg',1.00),
    (2,'Gram','g',1000.00),
    (3,'Pound','lb',2.20);

/*!40000 ALTER TABLE `hare_weight` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table janvince_smallrecords_areas
# ------------------------------------------------------------

CREATE TABLE `janvince_smallrecords_areas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `allowed_fields` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `janvince_smallrecords_areas_name_index` (`name`),
  KEY `janvince_smallrecords_areas_slug_index` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `janvince_smallrecords_areas` WRITE;
/*!40000 ALTER TABLE `janvince_smallrecords_areas` DISABLE KEYS */;

INSERT INTO `janvince_smallrecords_areas` (`id`, `name`, `slug`, `active`, `description`, `allowed_fields`, `created_at`, `updated_at`)
VALUES
    (1,'werwerwerwer','werwerwerwer',1,'werwer','[\"category\",\"preview_image\",\"description\",\"date\",\"url\",\"active\",\"favourite\",\"content\",\"images\",\"tags\",\"attributes\",\"files\",\"categories\",\"repeater\"]','2017-09-13 00:05:54','2017-09-13 00:05:54');

/*!40000 ALTER TABLE `janvince_smallrecords_areas` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table janvince_smallrecords_attributes
# ------------------------------------------------------------

CREATE TABLE `janvince_smallrecords_attributes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `janvince_smallrecords_attributes_name_index` (`name`),
  KEY `janvince_smallrecords_attributes_slug_index` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table janvince_smallrecords_categories
# ------------------------------------------------------------

CREATE TABLE `janvince_smallrecords_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `nest_left` int(10) unsigned DEFAULT NULL,
  `nest_right` int(10) unsigned DEFAULT NULL,
  `nest_depth` int(10) unsigned DEFAULT NULL,
  `sort_order` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `content` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `janvince_smallrecords_categories_parent_id_index` (`parent_id`),
  KEY `janvince_smallrecords_categories_nest_left_index` (`nest_left`),
  KEY `janvince_smallrecords_categories_nest_right_index` (`nest_right`),
  KEY `janvince_smallrecords_categories_nest_depth_index` (`nest_depth`),
  KEY `janvince_smallrecords_categories_sort_order_index` (`sort_order`),
  KEY `janvince_smallrecords_categories_name_index` (`name`),
  KEY `janvince_smallrecords_categories_slug_index` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table janvince_smallrecords_records
# ------------------------------------------------------------

CREATE TABLE `janvince_smallrecords_records` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `area_id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `content` text COLLATE utf8_unicode_ci,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `favourite` tinyint(1) DEFAULT NULL,
  `repeater` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `janvince_smallrecords_records_area_id_index` (`area_id`),
  KEY `janvince_smallrecords_records_category_id_index` (`category_id`),
  KEY `janvince_smallrecords_records_slug_index` (`slug`),
  KEY `janvince_smallrecords_records_url_index` (`url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table janvince_smallrecords_records_attributes
# ------------------------------------------------------------

CREATE TABLE `janvince_smallrecords_records_attributes` (
  `record_id` int(10) unsigned NOT NULL,
  `attribute_id` int(10) unsigned NOT NULL,
  `value_string` char(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value_text` text COLLATE utf8_unicode_ci,
  `value_number` decimal(9,2) DEFAULT NULL,
  `value_boolean` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`record_id`,`attribute_id`),
  KEY `janvince_smallrecords_records_attributes_value_string_index` (`value_string`),
  KEY `janvince_smallrecords_records_attributes_value_number_index` (`value_number`),
  KEY `janvince_smallrecords_records_attributes_value_boolean_index` (`value_boolean`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table janvince_smallrecords_records_categories
# ------------------------------------------------------------

CREATE TABLE `janvince_smallrecords_records_categories` (
  `record_id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`record_id`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table janvince_smallrecords_records_tags
# ------------------------------------------------------------

CREATE TABLE `janvince_smallrecords_records_tags` (
  `record_id` int(10) unsigned NOT NULL,
  `tag_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`record_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table janvince_smallrecords_tags
# ------------------------------------------------------------

CREATE TABLE `janvince_smallrecords_tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `content` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `janvince_smallrecords_tags_name_index` (`name`),
  KEY `janvince_smallrecords_tags_slug_index` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table jetminds_job_resumes
# ------------------------------------------------------------

CREATE TABLE `jetminds_job_resumes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `location` longtext COLLATE utf8_unicode_ci,
  `resume_category` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `resume_education` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `education_note` longtext COLLATE utf8_unicode_ci,
  `resume_experience` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `experience_note` longtext COLLATE utf8_unicode_ci,
  `resume_language` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `resume_skill` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `resume_note` longtext COLLATE utf8_unicode_ci,
  `is_invite` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table jetminds_job_vacancies
# ------------------------------------------------------------

CREATE TABLE `jetminds_job_vacancies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `excerpt` text COLLATE utf8_unicode_ci,
  `description` longtext COLLATE utf8_unicode_ci,
  `requirements` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `expectations` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `published_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `jetminds_job_vacancies_slug_index` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `jetminds_job_vacancies` WRITE;
/*!40000 ALTER TABLE `jetminds_job_vacancies` DISABLE KEYS */;

INSERT INTO `jetminds_job_vacancies` (`id`, `title`, `slug`, `excerpt`, `description`, `requirements`, `expectations`, `published`, `published_at`, `created_at`, `updated_at`)
VALUES
    (1,'','','','','[{\"title\":\"wewee\"}]','[]',0,NULL,'2017-08-17 22:49:47','2017-08-17 22:49:47'),
    (2,'','','','','[{\"title\":\"wewee\"}]','[]',0,NULL,'2017-08-17 22:49:47','2017-08-17 22:49:47');

/*!40000 ALTER TABLE `jetminds_job_vacancies` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table jobs
# ------------------------------------------------------------

CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `payload` text COLLATE utf8_unicode_ci NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table ksoft_links_categories
# ------------------------------------------------------------

CREATE TABLE `ksoft_links_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ksoft_links_categories_slug_index` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table ksoft_links_items
# ------------------------------------------------------------

CREATE TABLE `ksoft_links_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `category_id` int(10) unsigned NOT NULL,
  `title` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `link` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `target` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ksoft_links_items_category_id_index` (`category_id`),
  KEY `ksoft_links_items_slug_index` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table kurtjensen_passage_groups_keys
# ------------------------------------------------------------

CREATE TABLE `kurtjensen_passage_groups_keys` (
  `user_group_id` int(10) unsigned NOT NULL,
  `key_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_group_id`,`key_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table kurtjensen_passage_keys
# ------------------------------------------------------------

CREATE TABLE `kurtjensen_passage_keys` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table mavitm_estate_categories
# ------------------------------------------------------------

CREATE TABLE `mavitm_estate_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `sort_order` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table mavitm_estate_realty
# ------------------------------------------------------------

CREATE TABLE `mavitm_estate_realty` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `excerpt` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `price` double(10,2) NOT NULL,
  `published` smallint(6) NOT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table mavitm_estate_realty_properties
# ------------------------------------------------------------

CREATE TABLE `mavitm_estate_realty_properties` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `realty_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `iconcss` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mavitm_estate_realty_properties_realty_id_index` (`realty_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table mavitm_estate_realty_tag
# ------------------------------------------------------------

CREATE TABLE `mavitm_estate_realty_tag` (
  `realty_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table mavitm_estate_tags
# ------------------------------------------------------------

CREATE TABLE `mavitm_estate_tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table migrations
# ------------------------------------------------------------

CREATE TABLE `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;

INSERT INTO `migrations` (`migration`, `batch`)
VALUES
    ('2013_10_01_000001_Db_Deferred_Bindings',1),
    ('2013_10_01_000002_Db_System_Files',1),
    ('2013_10_01_000003_Db_System_Plugin_Versions',1),
    ('2013_10_01_000004_Db_System_Plugin_History',1),
    ('2013_10_01_000005_Db_System_Settings',1),
    ('2013_10_01_000006_Db_System_Parameters',1),
    ('2013_10_01_000007_Db_System_Add_Disabled_Flag',1),
    ('2013_10_01_000008_Db_System_Mail_Templates',1),
    ('2013_10_01_000009_Db_System_Mail_Layouts',1),
    ('2014_10_01_000010_Db_Jobs',1),
    ('2014_10_01_000011_Db_System_Event_Logs',1),
    ('2014_10_01_000012_Db_System_Request_Logs',1),
    ('2014_10_01_000013_Db_System_Sessions',1),
    ('2015_10_01_000014_Db_System_Mail_Layout_Rename',1),
    ('2015_10_01_000015_Db_System_Add_Frozen_Flag',1),
    ('2015_10_01_000016_Db_Cache',1),
    ('2015_10_01_000017_Db_System_Revisions',1),
    ('2015_10_01_000018_Db_FailedJobs',1),
    ('2016_10_01_000019_Db_System_Plugin_History_Detail_Text',1),
    ('2016_10_01_000020_Db_System_Timestamp_Fix',1),
    ('2013_10_01_000001_Db_Backend_Users',2),
    ('2013_10_01_000002_Db_Backend_User_Groups',2),
    ('2013_10_01_000003_Db_Backend_Users_Groups',2),
    ('2013_10_01_000004_Db_Backend_User_Throttle',2),
    ('2014_01_04_000005_Db_Backend_User_Preferences',2),
    ('2014_10_01_000006_Db_Backend_Access_Log',2),
    ('2014_10_01_000007_Db_Backend_Add_Description_Field',2),
    ('2015_10_01_000008_Db_Backend_Add_Superuser_Flag',2),
    ('2016_10_01_000009_Db_Backend_Timestamp_Fix',2),
    ('2014_10_01_000001_Db_Cms_Theme_Data',3),
    ('2016_10_01_000002_Db_Cms_Timestamp_Fix',3),
    ('2017_10_01_000003_Db_Cms_Theme_Logs',3);

/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table offline_cashier_subscriptions
# ------------------------------------------------------------

CREATE TABLE `offline_cashier_subscriptions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `stripe_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `stripe_plan` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `ends_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table raccoon_geolocation_ip_info_locations
# ------------------------------------------------------------

CREATE TABLE `raccoon_geolocation_ip_info_locations` (
  `ip` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `country_code` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zip` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `latitude` decimal(8,5) NOT NULL DEFAULT '0.00000',
  `longitude` decimal(8,5) NOT NULL DEFAULT '0.00000',
  `timezone` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table rainlab_translate_attributes
# ------------------------------------------------------------

CREATE TABLE `rainlab_translate_attributes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `locale` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `model_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attribute_data` mediumtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `rainlab_translate_attributes_locale_index` (`locale`),
  KEY `rainlab_translate_attributes_model_id_index` (`model_id`),
  KEY `rainlab_translate_attributes_model_type_index` (`model_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table rainlab_translate_indexes
# ------------------------------------------------------------

CREATE TABLE `rainlab_translate_indexes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `locale` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `model_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `item` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` mediumtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `rainlab_translate_indexes_locale_index` (`locale`),
  KEY `rainlab_translate_indexes_model_id_index` (`model_id`),
  KEY `rainlab_translate_indexes_model_type_index` (`model_type`),
  KEY `rainlab_translate_indexes_item_index` (`item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table rainlab_translate_locales
# ------------------------------------------------------------

CREATE TABLE `rainlab_translate_locales` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `is_enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `rainlab_translate_locales_code_index` (`code`),
  KEY `rainlab_translate_locales_name_index` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `rainlab_translate_locales` WRITE;
/*!40000 ALTER TABLE `rainlab_translate_locales` DISABLE KEYS */;

INSERT INTO `rainlab_translate_locales` (`id`, `code`, `name`, `is_default`, `is_enabled`)
VALUES
    (1,'en','English',1,1);

/*!40000 ALTER TABLE `rainlab_translate_locales` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table rainlab_translate_messages
# ------------------------------------------------------------

CREATE TABLE `rainlab_translate_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `message_data` mediumtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `rainlab_translate_messages_code_index` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table rainlab_user_mail_blockers
# ------------------------------------------------------------

CREATE TABLE `rainlab_user_mail_blockers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `template` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rainlab_user_mail_blockers_email_index` (`email`),
  KEY `rainlab_user_mail_blockers_template_index` (`template`),
  KEY `rainlab_user_mail_blockers_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table sessions
# ------------------------------------------------------------

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `payload` text COLLATE utf8_unicode_ci,
  `last_activity` int(11) DEFAULT NULL,
  UNIQUE KEY `sessions_id_unique` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table shajid_videoplayer_
# ------------------------------------------------------------

CREATE TABLE `shajid_videoplayer_` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `shajid_videoplayer_` WRITE;
/*!40000 ALTER TABLE `shajid_videoplayer_` DISABLE KEYS */;

INSERT INTO `shajid_videoplayer_` (`id`, `name`)
VALUES
    (1,'qweqwewqe');

/*!40000 ALTER TABLE `shajid_videoplayer_` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table stefan_gallery_galleries
# ------------------------------------------------------------

CREATE TABLE `stefan_gallery_galleries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `published` tinyint(1) DEFAULT '1',
  `sort_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stefan_gallery_galleries_title_index` (`title`),
  KEY `stefan_gallery_galleries_slug_index` (`slug`),
  KEY `stefan_gallery_galleries_published_index` (`published`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table stefan_gallery_tags
# ------------------------------------------------------------

CREATE TABLE `stefan_gallery_tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `stefan_gallery_tags_title_index` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table system_event_logs
# ------------------------------------------------------------

CREATE TABLE `system_event_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `level` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8_unicode_ci,
  `details` mediumtext COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `system_event_logs_level_index` (`level`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `system_event_logs` WRITE;
/*!40000 ALTER TABLE `system_event_logs` DISABLE KEYS */;

INSERT INTO `system_event_logs` (`id`, `level`, `message`, `details`, `created_at`, `updated_at`)
VALUES
    (1,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Faker\\Factory\' not found\' in /var/www-sandbox/plugins/getright/services/updates/seeders/SeedServicesTable.php:25\nStack trace:\n#0 {main}',NULL,'2017-06-21 23:29:27','2017-06-21 23:29:27'),
    (2,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Jiri\\JKShop\\Models\\Order\' not found\' in /var/www-sandbox/plugins/viral/shopreviews/Plugin.php:101\nStack trace:\n#0 {main}',NULL,'2017-06-28 00:03:07','2017-06-28 00:03:07'),
    (3,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Jiri\\JKShop\\Models\\Order\' not found\' in /var/www-sandbox/plugins/viral/shopreviews/Plugin.php:101\nStack trace:\n#0 {main}',NULL,'2017-06-28 00:03:08','2017-06-28 00:03:08'),
    (4,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Jiri\\JKShop\\Models\\Order\' not found\' in /var/www-sandbox/plugins/viral/shopreviews/Plugin.php:101\nStack trace:\n#0 {main}',NULL,'2017-06-28 00:03:16','2017-06-28 00:03:16'),
    (5,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Jiri\\JKShop\\Models\\Order\' not found\' in /var/www-sandbox/plugins/viral/shopreviews/Plugin.php:101\nStack trace:\n#0 {main}',NULL,'2017-06-28 00:03:19','2017-06-28 00:03:19'),
    (6,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Jiri\\JKShop\\Models\\Order\' not found\' in /var/www-sandbox/plugins/viral/shopreviews/Plugin.php:101\nStack trace:\n#0 {main}',NULL,'2017-06-28 00:03:24','2017-06-28 00:03:24'),
    (7,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Jiri\\JKShop\\Models\\Order\' not found\' in /var/www-sandbox/plugins/viral/shopreviews/Plugin.php:101\nStack trace:\n#0 {main}',NULL,'2017-06-28 00:03:24','2017-06-28 00:03:24'),
    (8,'error','exception \'October\\Rain\\Exception\\SystemException\' with message \'Class name is not registered for the component \"staticPage\". Check the component plugin.\' in /var/www-sandbox/modules/cms/Classes/ComponentManager.php:200\nStack trace:\n#0 /var/www-sandbox/modules/cms/Classes/Controller.php(1217): Cms\\Classes\\ComponentManager->makeComponent(\'staticPage\', Object(Cms5955add00ec27748680601_c68677140b428a5c7c58893e11bb0eb6Class), Array)\n#1 /var/www-sandbox/modules/cms/Classes/Controller.php(546): Cms\\Classes\\Controller->addComponent(\'staticPage\', \'staticPage\', Array, true)\n#2 /var/www-sandbox/modules/cms/Classes/Controller.php(304): Cms\\Classes\\Controller->initComponents()\n#3 /var/www-sandbox/modules/cms/Classes/Controller.php(213): Cms\\Classes\\Controller->runPage(Object(Cms\\Classes\\Page))\n#4 /var/www-sandbox/modules/cms/Classes/CmsController.php(50): Cms\\Classes\\Controller->run(\'/\')\n#5 [internal function]: Cms\\Classes\\CmsController->run(\'/\')\n#6 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Controller.php(256): call_user_func_array(Array, Array)\n#7 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(164): Illuminate\\Routing\\Controller->callAction(\'run\', Array)\n#8 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(112): Illuminate\\Routing\\ControllerDispatcher->call(Object(Cms\\Classes\\CmsController), Object(Illuminate\\Routing\\Route), \'run\')\n#9 [internal function]: Illuminate\\Routing\\ControllerDispatcher->Illuminate\\Routing\\{closure}(Object(Illuminate\\Http\\Request))\n#10 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(139): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#11 [internal function]: Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#12 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#13 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(114): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(69): Illuminate\\Routing\\ControllerDispatcher->callWithinStack(Object(Cms\\Classes\\CmsController), Object(Illuminate\\Routing\\Route), Object(Illuminate\\Http\\Request), \'run\')\n#15 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Route.php(203): Illuminate\\Routing\\ControllerDispatcher->dispatch(Object(Illuminate\\Routing\\Route), Object(Illuminate\\Http\\Request), \'Cms\\\\Classes\\\\Cms...\', \'run\')\n#16 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Route.php(134): Illuminate\\Routing\\Route->runWithCustomDispatcher(Object(Illuminate\\Http\\Request))\n#17 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(708): Illuminate\\Routing\\Route->run(Object(Illuminate\\Http\\Request))\n#18 [internal function]: Illuminate\\Routing\\Router->Illuminate\\Routing\\{closure}(Object(Illuminate\\Http\\Request))\n#19 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(139): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#20 [internal function]: Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#21 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#22 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(710): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#23 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(675): Illuminate\\Routing\\Router->runRouteWithinStack(Object(Illuminate\\Routing\\Route), Object(Illuminate\\Http\\Request))\n#24 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(635): Illuminate\\Routing\\Router->dispatchToRoute(Object(Illuminate\\Http\\Request))\n#25 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(236): Illuminate\\Routing\\Router->dispatch(Object(Illuminate\\Http\\Request))\n#26 [internal function]: Illuminate\\Foundation\\Http\\Kernel->Illuminate\\Foundation\\Http\\{closure}(Object(Illuminate\\Http\\Request))\n#27 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(139): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#28 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/View/Middleware/ShareErrorsFromSession.php(49): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#29 [internal function]: Illuminate\\View\\Middleware\\ShareErrorsFromSession->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#30 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#31 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Session/Middleware/StartSession.php(62): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#32 [internal function]: Illuminate\\Session\\Middleware\\StartSession->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#33 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#34 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Cookie/Middleware/AddQueuedCookiesToResponse.php(37): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#35 [internal function]: Illuminate\\Cookie\\Middleware\\AddQueuedCookiesToResponse->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#36 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#37 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Cookie/Middleware/EncryptCookies.php(59): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#38 [internal function]: Illuminate\\Cookie\\Middleware\\EncryptCookies->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#39 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#40 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Middleware/CheckForMaintenanceMode.php(44): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#41 [internal function]: Illuminate\\Foundation\\Http\\Middleware\\CheckForMaintenanceMode->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#42 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#43 [internal function]: Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#44 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#45 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(122): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#46 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(87): Illuminate\\Foundation\\Http\\Kernel->sendRequestThroughRouter(Object(Illuminate\\Http\\Request))\n#47 /var/www-sandbox/index.php(44): Illuminate\\Foundation\\Http\\Kernel->handle(Object(Illuminate\\Http\\Request))\n#48 {main}',NULL,'2017-06-30 01:48:00','2017-06-30 01:48:00'),
    (9,'error','exception \'ErrorException\' with message \'Missing argument 2 for Viral\\ShopReviews\\Helpers\\ShopPluginHelper::getConfig(), called in /var/www-sandbox/plugins/viral/shopreviews/models/Settings.php on line 35 and defined\' in /var/www-sandbox/plugins/viral/shopreviews/helpers/ShopPluginHelper.php:92\nStack trace:\n#0 /var/www-sandbox/plugins/viral/shopreviews/helpers/ShopPluginHelper.php(92): Illuminate\\Foundation\\Bootstrap\\HandleExceptions->handleError(2, \'Missing argumen...\', \'/var/www-sandbo...\', 92, Array)\n#1 /var/www-sandbox/plugins/viral/shopreviews/models/Settings.php(35): Viral\\ShopReviews\\Helpers\\ShopPluginHelper::getConfig(\'widget_review_l...\')\n#2 /var/www-sandbox/modules/system/Behaviors/SettingsModel.php(75): Viral\\ShopReviews\\Models\\Settings->initSettingsData()\n#3 /var/www-sandbox/modules/system/Behaviors/SettingsModel.php(133): System\\Behaviors\\SettingsModel->instance()\n#4 [internal function]: System\\Behaviors\\SettingsModel->get(\'plugin\')\n#5 /var/www-sandbox/vendor/october/rain/src/Extension/ExtendableTrait.php(371): call_user_func_array(Array, Array)\n#6 /var/www-sandbox/vendor/october/rain/src/Database/Model.php(516): October\\Rain\\Database\\Model->extendableCall(\'get\', Array)\n#7 [internal function]: October\\Rain\\Database\\Model->__call(\'get\', Array)\n#8 [internal function]: Viral\\ShopReviews\\Models\\Settings->get(\'plugin\')\n#9 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Model.php(3458): call_user_func_array(Array, Array)\n#10 /var/www-sandbox/plugins/viral/shopreviews/Plugin.php(57): Illuminate\\Database\\Eloquent\\Model::__callStatic(\'get\', Array)\n#11 /var/www-sandbox/plugins/viral/shopreviews/Plugin.php(57): Viral\\ShopReviews\\Models\\Settings::get(\'plugin\')\n#12 /var/www-sandbox/modules/system/Classes/PluginManager.php(269): Viral\\ShopReviews\\Plugin->boot()\n#13 /var/www-sandbox/modules/system/Classes/PluginManager.php(251): System\\Classes\\PluginManager->bootPlugin(Object(Viral\\ShopReviews\\Plugin))\n#14 /var/www-sandbox/modules/system/ServiceProvider.php(87): System\\Classes\\PluginManager->bootAll()\n#15 [internal function]: System\\ServiceProvider->boot()\n#16 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Container/Container.php(507): call_user_func_array(Array, Array)\n#17 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Application.php(734): Illuminate\\Container\\Container->call(Array)\n#18 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Application.php(717): Illuminate\\Foundation\\Application->bootProvider(Object(System\\ServiceProvider))\n#19 [internal function]: Illuminate\\Foundation\\Application->Illuminate\\Foundation\\{closure}(Object(System\\ServiceProvider), 21)\n#20 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Application.php(718): array_walk(Array, Object(Closure))\n#21 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Bootstrap/BootProviders.php(17): Illuminate\\Foundation\\Application->boot()\n#22 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Application.php(203): Illuminate\\Foundation\\Bootstrap\\BootProviders->bootstrap(Object(October\\Rain\\Foundation\\Application))\n#23 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(222): Illuminate\\Foundation\\Application->bootstrapWith(Array)\n#24 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(117): Illuminate\\Foundation\\Http\\Kernel->bootstrap()\n#25 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(87): Illuminate\\Foundation\\Http\\Kernel->sendRequestThroughRouter(Object(Illuminate\\Http\\Request))\n#26 /var/www-sandbox/index.php(44): Illuminate\\Foundation\\Http\\Kernel->handle(Object(Illuminate\\Http\\Request))\n#27 {main}',NULL,'2017-07-04 02:33:24','2017-07-04 02:33:24'),
    (10,'error','exception \'ErrorException\' with message \'Missing argument 2 for Viral\\ShopReviews\\Helpers\\ShopPluginHelper::getConfig(), called in /var/www-sandbox/plugins/viral/shopreviews/models/Settings.php on line 35 and defined\' in /var/www-sandbox/plugins/viral/shopreviews/helpers/ShopPluginHelper.php:92\nStack trace:\n#0 /var/www-sandbox/plugins/viral/shopreviews/helpers/ShopPluginHelper.php(92): Illuminate\\Foundation\\Bootstrap\\HandleExceptions->handleError(2, \'Missing argumen...\', \'/var/www-sandbo...\', 92, Array)\n#1 /var/www-sandbox/plugins/viral/shopreviews/models/Settings.php(35): Viral\\ShopReviews\\Helpers\\ShopPluginHelper::getConfig(\'widget_review_l...\')\n#2 /var/www-sandbox/modules/system/Behaviors/SettingsModel.php(75): Viral\\ShopReviews\\Models\\Settings->initSettingsData()\n#3 /var/www-sandbox/modules/system/Behaviors/SettingsModel.php(133): System\\Behaviors\\SettingsModel->instance()\n#4 [internal function]: System\\Behaviors\\SettingsModel->get(\'plugin\')\n#5 /var/www-sandbox/vendor/october/rain/src/Extension/ExtendableTrait.php(371): call_user_func_array(Array, Array)\n#6 /var/www-sandbox/vendor/october/rain/src/Database/Model.php(516): October\\Rain\\Database\\Model->extendableCall(\'get\', Array)\n#7 [internal function]: October\\Rain\\Database\\Model->__call(\'get\', Array)\n#8 [internal function]: Viral\\ShopReviews\\Models\\Settings->get(\'plugin\')\n#9 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Model.php(3458): call_user_func_array(Array, Array)\n#10 /var/www-sandbox/plugins/viral/shopreviews/Plugin.php(57): Illuminate\\Database\\Eloquent\\Model::__callStatic(\'get\', Array)\n#11 /var/www-sandbox/plugins/viral/shopreviews/Plugin.php(57): Viral\\ShopReviews\\Models\\Settings::get(\'plugin\')\n#12 /var/www-sandbox/modules/system/Classes/PluginManager.php(269): Viral\\ShopReviews\\Plugin->boot()\n#13 /var/www-sandbox/modules/system/Classes/PluginManager.php(251): System\\Classes\\PluginManager->bootPlugin(Object(Viral\\ShopReviews\\Plugin))\n#14 /var/www-sandbox/modules/system/ServiceProvider.php(87): System\\Classes\\PluginManager->bootAll()\n#15 [internal function]: System\\ServiceProvider->boot()\n#16 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Container/Container.php(507): call_user_func_array(Array, Array)\n#17 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Application.php(734): Illuminate\\Container\\Container->call(Array)\n#18 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Application.php(717): Illuminate\\Foundation\\Application->bootProvider(Object(System\\ServiceProvider))\n#19 [internal function]: Illuminate\\Foundation\\Application->Illuminate\\Foundation\\{closure}(Object(System\\ServiceProvider), 21)\n#20 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Application.php(718): array_walk(Array, Object(Closure))\n#21 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Bootstrap/BootProviders.php(17): Illuminate\\Foundation\\Application->boot()\n#22 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Application.php(203): Illuminate\\Foundation\\Bootstrap\\BootProviders->bootstrap(Object(October\\Rain\\Foundation\\Application))\n#23 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(222): Illuminate\\Foundation\\Application->bootstrapWith(Array)\n#24 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(117): Illuminate\\Foundation\\Http\\Kernel->bootstrap()\n#25 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(87): Illuminate\\Foundation\\Http\\Kernel->sendRequestThroughRouter(Object(Illuminate\\Http\\Request))\n#26 /var/www-sandbox/index.php(44): Illuminate\\Foundation\\Http\\Kernel->handle(Object(Illuminate\\Http\\Request))\n#27 {main}',NULL,'2017-07-04 02:33:25','2017-07-04 02:33:25'),
    (11,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Gouzi\\Taxonomy\\Controllers\\Taxon\' not found\' in /var/www-sandbox/plugins/gouzi/video/controllers/taxonmovie.php:13\nStack trace:\n#0 {main}',NULL,'2017-07-19 00:04:31','2017-07-19 00:04:31'),
    (12,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Gouzi\\Resource\\Behaviors\\TranslatableListController\' not found\' in /var/www-sandbox/vendor/october/rain/src/Extension/ExtendableTrait.php:199\nStack trace:\n#0 {main}',NULL,'2017-07-19 00:04:42','2017-07-19 00:04:42'),
    (13,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Gouzi\\Resource\\Behaviors\\TranslatableListController\' not found\' in /var/www-sandbox/vendor/october/rain/src/Extension/ExtendableTrait.php:199\nStack trace:\n#0 {main}',NULL,'2017-07-19 00:06:31','2017-07-19 00:06:31'),
    (14,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Gouzi\\Resource\\Behaviors\\TranslatableListController\' not found\' in /var/www-sandbox/vendor/october/rain/src/Extension/ExtendableTrait.php:199\nStack trace:\n#0 {main}',NULL,'2017-07-19 00:07:44','2017-07-19 00:07:44'),
    (15,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Gouzi\\Resource\\Behaviors\\TranslatableListController\' not found\' in /var/www-sandbox/vendor/october/rain/src/Extension/ExtendableTrait.php:199\nStack trace:\n#0 {main}',NULL,'2017-07-19 00:07:45','2017-07-19 00:07:45'),
    (16,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Gouzi\\Resource\\Behaviors\\TranslatableListController\' not found\' in /var/www-sandbox/vendor/october/rain/src/Extension/ExtendableTrait.php:199\nStack trace:\n#0 {main}',NULL,'2017-07-19 00:11:58','2017-07-19 00:11:58'),
    (17,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Gouzi\\Taxonomy\\Controllers\\Taxon\' not found\' in /var/www-sandbox/plugins/gouzi/video/controllers/taxonmovie.php:13\nStack trace:\n#0 {main}',NULL,'2017-07-19 00:12:57','2017-07-19 00:12:57'),
    (18,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Gouzi\\Resource\\Behaviors\\TranslatableListController\' not found\' in /var/www-sandbox/vendor/october/rain/src/Extension/ExtendableTrait.php:199\nStack trace:\n#0 {main}',NULL,'2017-07-19 00:13:37','2017-07-19 00:13:37'),
    (19,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Gouzi\\Comment\\Controllers\\Comment\' not found\' in /var/www-sandbox/plugins/gouzi/video/controllers/commentvideomovie.php:14\nStack trace:\n#0 {main}',NULL,'2017-07-19 00:13:47','2017-07-19 00:13:47'),
    (20,'error','exception \'PDOException\' with message \'SQLSTATE[42S02]: Base table or view not found: 1146 Table \'october-sandbox.mavitm_estate_realty\' doesn\'t exist\' in /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Connection.php:319\nStack trace:\n#0 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Connection.php(319): PDO->prepare(\'select count(*)...\')\n#1 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Connection.php(659): Illuminate\\Database\\Connection->Illuminate\\Database\\{closure}(Object(October\\Rain\\Database\\Connections\\MySqlConnection), \'select count(*)...\', Array)\n#2 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Connection.php(622): Illuminate\\Database\\Connection->runQueryCallback(\'select count(*)...\', Array, Object(Closure))\n#3 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Connection.php(324): Illuminate\\Database\\Connection->run(\'select count(*)...\', Array, Object(Closure))\n#4 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Query/Builder.php(1431): Illuminate\\Database\\Connection->select(\'select count(*)...\', Array, true)\n#5 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Query/Builder.php(1408): Illuminate\\Database\\Query\\Builder->runSelect()\n#6 /var/www-sandbox/vendor/october/rain/src/Database/QueryBuilder.php(110): Illuminate\\Database\\Query\\Builder->get(Array)\n#7 /var/www-sandbox/vendor/october/rain/src/Database/QueryBuilder.php(80): October\\Rain\\Database\\QueryBuilder->getDuplicateCached(Array)\n#8 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Query/Builder.php(1491): October\\Rain\\Database\\QueryBuilder->get()\n#9 /var/www-sandbox/vendor/october/rain/src/Database/Builder.php(137): Illuminate\\Database\\Query\\Builder->getCountForPagination()\n#10 /var/www-sandbox/modules/backend/Widgets/Lists.php(521): October\\Rain\\Database\\Builder->paginate(\'15\', NULL)\n#11 /var/www-sandbox/modules/backend/Widgets/Lists.php(246): Backend\\Widgets\\Lists->getRecords()\n#12 /var/www-sandbox/modules/backend/Widgets/Lists.php(234): Backend\\Widgets\\Lists->prepareVars()\n#13 /var/www-sandbox/modules/backend/Behaviors/listcontroller/partials/_container.htm(9): Backend\\Widgets\\Lists->render()\n#14 /var/www-sandbox/modules/system/Traits/ViewMaker.php(244): include(\'/var/www-sandbo...\')\n#15 /var/www-sandbox/modules/backend/Classes/ControllerBehavior.php(142): Backend\\Classes\\Controller->makeFileContents(\'/var/www-sandbo...\', Array)\n#16 /var/www-sandbox/modules/system/Traits/ViewMaker.php(98): Backend\\Classes\\ControllerBehavior->makeFileContents(\'/var/www-sandbo...\', Array)\n#17 /var/www-sandbox/modules/backend/Behaviors/ListController.php(393): Backend\\Classes\\ControllerBehavior->makePartial(\'container\', Array)\n#18 /var/www-sandbox/modules/backend/Behaviors/ListController.php(380): Backend\\Behaviors\\ListController->listMakePartial(\'container\', Array)\n#19 [internal function]: Backend\\Behaviors\\ListController->listRender()\n#20 /var/www-sandbox/vendor/october/rain/src/Extension/ExtendableTrait.php(371): call_user_func_array(Array, Array)\n#21 /var/www-sandbox/vendor/october/rain/src/Extension/Extendable.php(42): October\\Rain\\Extension\\Extendable->extendableCall(\'listRender\', Array)\n#22 /var/www-sandbox/plugins/mavitm/estate/controllers/realties/index.htm(1): October\\Rain\\Extension\\Extendable->__call(\'listRender\', Array)\n#23 /var/www-sandbox/plugins/mavitm/estate/controllers/realties/index.htm(1): Mavitm\\Estate\\Controllers\\Realties->listRender()\n#24 /var/www-sandbox/modules/system/Traits/ViewMaker.php(244): include(\'/var/www-sandbo...\')\n#25 /var/www-sandbox/modules/system/Traits/ViewMaker.php(110): Backend\\Classes\\Controller->makeFileContents(\'/var/www-sandbo...\')\n#26 /var/www-sandbox/modules/backend/Classes/Controller.php(375): Backend\\Classes\\Controller->makeView(\'index\')\n#27 /var/www-sandbox/modules/backend/Classes/Controller.php(257): Backend\\Classes\\Controller->execPageAction(\'index\', Array)\n#28 /var/www-sandbox/modules/backend/Classes/BackendController.php(112): Backend\\Classes\\Controller->run(\'index\', Array)\n#29 [internal function]: Backend\\Classes\\BackendController->run(\'mavitm/estate/r...\')\n#30 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Controller.php(256): call_user_func_array(Array, Array)\n#31 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(164): Illuminate\\Routing\\Controller->callAction(\'run\', Array)\n#32 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(112): Illuminate\\Routing\\ControllerDispatcher->call(Object(Backend\\Classes\\BackendController), Object(Illuminate\\Routing\\Route), \'run\')\n#33 [internal function]: Illuminate\\Routing\\ControllerDispatcher->Illuminate\\Routing\\{closure}(Object(Illuminate\\Http\\Request))\n#34 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(139): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#35 [internal function]: Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#36 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#37 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(114): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#38 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(69): Illuminate\\Routing\\ControllerDispatcher->callWithinStack(Object(Backend\\Classes\\BackendController), Object(Illuminate\\Routing\\Route), Object(Illuminate\\Http\\Request), \'run\')\n#39 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Route.php(203): Illuminate\\Routing\\ControllerDispatcher->dispatch(Object(Illuminate\\Routing\\Route), Object(Illuminate\\Http\\Request), \'Backend\\\\Classes...\', \'run\')\n#40 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Route.php(134): Illuminate\\Routing\\Route->runWithCustomDispatcher(Object(Illuminate\\Http\\Request))\n#41 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(708): Illuminate\\Routing\\Route->run(Object(Illuminate\\Http\\Request))\n#42 [internal function]: Illuminate\\Routing\\Router->Illuminate\\Routing\\{closure}(Object(Illuminate\\Http\\Request))\n#43 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(139): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#44 [internal function]: Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#45 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#46 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(710): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#47 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(675): Illuminate\\Routing\\Router->runRouteWithinStack(Object(Illuminate\\Routing\\Route), Object(Illuminate\\Http\\Request))\n#48 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(635): Illuminate\\Routing\\Router->dispatchToRoute(Object(Illuminate\\Http\\Request))\n#49 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(236): Illuminate\\Routing\\Router->dispatch(Object(Illuminate\\Http\\Request))\n#50 [internal function]: Illuminate\\Foundation\\Http\\Kernel->Illuminate\\Foundation\\Http\\{closure}(Object(Illuminate\\Http\\Request))\n#51 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(139): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#52 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/View/Middleware/ShareErrorsFromSession.php(49): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#53 [internal function]: Illuminate\\View\\Middleware\\ShareErrorsFromSession->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#54 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#55 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Session/Middleware/StartSession.php(62): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#56 [internal function]: Illuminate\\Session\\Middleware\\StartSession->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#57 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#58 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Cookie/Middleware/AddQueuedCookiesToResponse.php(37): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#59 [internal function]: Illuminate\\Cookie\\Middleware\\AddQueuedCookiesToResponse->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#60 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#61 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Cookie/Middleware/EncryptCookies.php(59): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#62 [internal function]: Illuminate\\Cookie\\Middleware\\EncryptCookies->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#63 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#64 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Middleware/CheckForMaintenanceMode.php(44): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#65 [internal function]: Illuminate\\Foundation\\Http\\Middleware\\CheckForMaintenanceMode->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#66 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#67 [internal function]: Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#68 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#69 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(122): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#70 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(87): Illuminate\\Foundation\\Http\\Kernel->sendRequestThroughRouter(Object(Illuminate\\Http\\Request))\n#71 /var/www-sandbox/index.php(45): Illuminate\\Foundation\\Http\\Kernel->handle(Object(Illuminate\\Http\\Request))\n#72 {main}\n\nNext exception \'Illuminate\\Database\\QueryException\' with message \'SQLSTATE[42S02]: Base table or view not found: 1146 Table \'october-sandbox.mavitm_estate_realty\' doesn\'t exist (SQL: select count(*) as aggregate from `mavitm_estate_realty`)\' in /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Connection.php:666\nStack trace:\n#0 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Connection.php(622): Illuminate\\Database\\Connection->runQueryCallback(\'select count(*)...\', Array, Object(Closure))\n#1 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Connection.php(324): Illuminate\\Database\\Connection->run(\'select count(*)...\', Array, Object(Closure))\n#2 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Query/Builder.php(1431): Illuminate\\Database\\Connection->select(\'select count(*)...\', Array, true)\n#3 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Query/Builder.php(1408): Illuminate\\Database\\Query\\Builder->runSelect()\n#4 /var/www-sandbox/vendor/october/rain/src/Database/QueryBuilder.php(110): Illuminate\\Database\\Query\\Builder->get(Array)\n#5 /var/www-sandbox/vendor/october/rain/src/Database/QueryBuilder.php(80): October\\Rain\\Database\\QueryBuilder->getDuplicateCached(Array)\n#6 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Query/Builder.php(1491): October\\Rain\\Database\\QueryBuilder->get()\n#7 /var/www-sandbox/vendor/october/rain/src/Database/Builder.php(137): Illuminate\\Database\\Query\\Builder->getCountForPagination()\n#8 /var/www-sandbox/modules/backend/Widgets/Lists.php(521): October\\Rain\\Database\\Builder->paginate(\'15\', NULL)\n#9 /var/www-sandbox/modules/backend/Widgets/Lists.php(246): Backend\\Widgets\\Lists->getRecords()\n#10 /var/www-sandbox/modules/backend/Widgets/Lists.php(234): Backend\\Widgets\\Lists->prepareVars()\n#11 /var/www-sandbox/modules/backend/Behaviors/listcontroller/partials/_container.htm(9): Backend\\Widgets\\Lists->render()\n#12 /var/www-sandbox/modules/system/Traits/ViewMaker.php(244): include(\'/var/www-sandbo...\')\n#13 /var/www-sandbox/modules/backend/Classes/ControllerBehavior.php(142): Backend\\Classes\\Controller->makeFileContents(\'/var/www-sandbo...\', Array)\n#14 /var/www-sandbox/modules/system/Traits/ViewMaker.php(98): Backend\\Classes\\ControllerBehavior->makeFileContents(\'/var/www-sandbo...\', Array)\n#15 /var/www-sandbox/modules/backend/Behaviors/ListController.php(393): Backend\\Classes\\ControllerBehavior->makePartial(\'container\', Array)\n#16 /var/www-sandbox/modules/backend/Behaviors/ListController.php(380): Backend\\Behaviors\\ListController->listMakePartial(\'container\', Array)\n#17 [internal function]: Backend\\Behaviors\\ListController->listRender()\n#18 /var/www-sandbox/vendor/october/rain/src/Extension/ExtendableTrait.php(371): call_user_func_array(Array, Array)\n#19 /var/www-sandbox/vendor/october/rain/src/Extension/Extendable.php(42): October\\Rain\\Extension\\Extendable->extendableCall(\'listRender\', Array)\n#20 /var/www-sandbox/plugins/mavitm/estate/controllers/realties/index.htm(1): October\\Rain\\Extension\\Extendable->__call(\'listRender\', Array)\n#21 /var/www-sandbox/plugins/mavitm/estate/controllers/realties/index.htm(1): Mavitm\\Estate\\Controllers\\Realties->listRender()\n#22 /var/www-sandbox/modules/system/Traits/ViewMaker.php(244): include(\'/var/www-sandbo...\')\n#23 /var/www-sandbox/modules/system/Traits/ViewMaker.php(110): Backend\\Classes\\Controller->makeFileContents(\'/var/www-sandbo...\')\n#24 /var/www-sandbox/modules/backend/Classes/Controller.php(375): Backend\\Classes\\Controller->makeView(\'index\')\n#25 /var/www-sandbox/modules/backend/Classes/Controller.php(257): Backend\\Classes\\Controller->execPageAction(\'index\', Array)\n#26 /var/www-sandbox/modules/backend/Classes/BackendController.php(112): Backend\\Classes\\Controller->run(\'index\', Array)\n#27 [internal function]: Backend\\Classes\\BackendController->run(\'mavitm/estate/r...\')\n#28 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Controller.php(256): call_user_func_array(Array, Array)\n#29 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(164): Illuminate\\Routing\\Controller->callAction(\'run\', Array)\n#30 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(112): Illuminate\\Routing\\ControllerDispatcher->call(Object(Backend\\Classes\\BackendController), Object(Illuminate\\Routing\\Route), \'run\')\n#31 [internal function]: Illuminate\\Routing\\ControllerDispatcher->Illuminate\\Routing\\{closure}(Object(Illuminate\\Http\\Request))\n#32 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(139): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#33 [internal function]: Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#34 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#35 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(114): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#36 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(69): Illuminate\\Routing\\ControllerDispatcher->callWithinStack(Object(Backend\\Classes\\BackendController), Object(Illuminate\\Routing\\Route), Object(Illuminate\\Http\\Request), \'run\')\n#37 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Route.php(203): Illuminate\\Routing\\ControllerDispatcher->dispatch(Object(Illuminate\\Routing\\Route), Object(Illuminate\\Http\\Request), \'Backend\\\\Classes...\', \'run\')\n#38 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Route.php(134): Illuminate\\Routing\\Route->runWithCustomDispatcher(Object(Illuminate\\Http\\Request))\n#39 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(708): Illuminate\\Routing\\Route->run(Object(Illuminate\\Http\\Request))\n#40 [internal function]: Illuminate\\Routing\\Router->Illuminate\\Routing\\{closure}(Object(Illuminate\\Http\\Request))\n#41 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(139): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#42 [internal function]: Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#43 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#44 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(710): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#45 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(675): Illuminate\\Routing\\Router->runRouteWithinStack(Object(Illuminate\\Routing\\Route), Object(Illuminate\\Http\\Request))\n#46 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(635): Illuminate\\Routing\\Router->dispatchToRoute(Object(Illuminate\\Http\\Request))\n#47 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(236): Illuminate\\Routing\\Router->dispatch(Object(Illuminate\\Http\\Request))\n#48 [internal function]: Illuminate\\Foundation\\Http\\Kernel->Illuminate\\Foundation\\Http\\{closure}(Object(Illuminate\\Http\\Request))\n#49 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(139): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#50 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/View/Middleware/ShareErrorsFromSession.php(49): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#51 [internal function]: Illuminate\\View\\Middleware\\ShareErrorsFromSession->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#52 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#53 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Session/Middleware/StartSession.php(62): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#54 [internal function]: Illuminate\\Session\\Middleware\\StartSession->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#55 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#56 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Cookie/Middleware/AddQueuedCookiesToResponse.php(37): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#57 [internal function]: Illuminate\\Cookie\\Middleware\\AddQueuedCookiesToResponse->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#58 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#59 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Cookie/Middleware/EncryptCookies.php(59): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#60 [internal function]: Illuminate\\Cookie\\Middleware\\EncryptCookies->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#61 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#62 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Middleware/CheckForMaintenanceMode.php(44): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#63 [internal function]: Illuminate\\Foundation\\Http\\Middleware\\CheckForMaintenanceMode->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#64 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#65 [internal function]: Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#66 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#67 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(122): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#68 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(87): Illuminate\\Foundation\\Http\\Kernel->sendRequestThroughRouter(Object(Illuminate\\Http\\Request))\n#69 /var/www-sandbox/index.php(45): Illuminate\\Foundation\\Http\\Kernel->handle(Object(Illuminate\\Http\\Request))\n#70 {main}',NULL,'2017-08-09 02:06:53','2017-08-09 02:06:53'),
    (21,'error','exception \'ErrorException\' with message \'Undefined index: \' in /var/www-sandbox/modules/cms/Classes/CodeParser.php(290) : eval()\'d code:26\nStack trace:\n#0 /var/www-sandbox/modules/cms/Classes/CodeParser.php(290) : eval()\'d code(26): Illuminate\\Foundation\\Bootstrap\\HandleExceptions->handleError(8, \'Undefined index...\', \'/var/www-sandbo...\', 26, Array)\n#1 /var/www-sandbox/modules/cms/Classes/Controller.php(411): Cms59938d003c2a0657591721_37637b30dd036acbff583d8b34648111Class->onStart()\n#2 /var/www-sandbox/modules/cms/Classes/Controller.php(349): Cms\\Classes\\Controller->execPageCycle()\n#3 /var/www-sandbox/modules/cms/Classes/Controller.php(213): Cms\\Classes\\Controller->runPage(Object(Cms\\Classes\\Page))\n#4 /var/www-sandbox/modules/cms/Classes/CmsController.php(50): Cms\\Classes\\Controller->run(\'/\')\n#5 [internal function]: Cms\\Classes\\CmsController->run(\'/\')\n#6 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Controller.php(256): call_user_func_array(Array, Array)\n#7 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(164): Illuminate\\Routing\\Controller->callAction(\'run\', Array)\n#8 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(112): Illuminate\\Routing\\ControllerDispatcher->call(Object(Cms\\Classes\\CmsController), Object(Illuminate\\Routing\\Route), \'run\')\n#9 [internal function]: Illuminate\\Routing\\ControllerDispatcher->Illuminate\\Routing\\{closure}(Object(Illuminate\\Http\\Request))\n#10 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(139): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#11 [internal function]: Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#12 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#13 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(114): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(69): Illuminate\\Routing\\ControllerDispatcher->callWithinStack(Object(Cms\\Classes\\CmsController), Object(Illuminate\\Routing\\Route), Object(Illuminate\\Http\\Request), \'run\')\n#15 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Route.php(203): Illuminate\\Routing\\ControllerDispatcher->dispatch(Object(Illuminate\\Routing\\Route), Object(Illuminate\\Http\\Request), \'Cms\\\\Classes\\\\Cms...\', \'run\')\n#16 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Route.php(134): Illuminate\\Routing\\Route->runWithCustomDispatcher(Object(Illuminate\\Http\\Request))\n#17 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(708): Illuminate\\Routing\\Route->run(Object(Illuminate\\Http\\Request))\n#18 [internal function]: Illuminate\\Routing\\Router->Illuminate\\Routing\\{closure}(Object(Illuminate\\Http\\Request))\n#19 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(139): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#20 [internal function]: Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#21 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#22 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(710): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#23 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(675): Illuminate\\Routing\\Router->runRouteWithinStack(Object(Illuminate\\Routing\\Route), Object(Illuminate\\Http\\Request))\n#24 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(635): Illuminate\\Routing\\Router->dispatchToRoute(Object(Illuminate\\Http\\Request))\n#25 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(236): Illuminate\\Routing\\Router->dispatch(Object(Illuminate\\Http\\Request))\n#26 [internal function]: Illuminate\\Foundation\\Http\\Kernel->Illuminate\\Foundation\\Http\\{closure}(Object(Illuminate\\Http\\Request))\n#27 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(139): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#28 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/View/Middleware/ShareErrorsFromSession.php(49): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#29 [internal function]: Illuminate\\View\\Middleware\\ShareErrorsFromSession->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#30 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#31 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Session/Middleware/StartSession.php(62): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#32 [internal function]: Illuminate\\Session\\Middleware\\StartSession->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#33 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#34 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Cookie/Middleware/AddQueuedCookiesToResponse.php(37): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#35 [internal function]: Illuminate\\Cookie\\Middleware\\AddQueuedCookiesToResponse->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#36 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#37 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Cookie/Middleware/EncryptCookies.php(59): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#38 [internal function]: Illuminate\\Cookie\\Middleware\\EncryptCookies->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#39 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#40 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Middleware/CheckForMaintenanceMode.php(44): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#41 [internal function]: Illuminate\\Foundation\\Http\\Middleware\\CheckForMaintenanceMode->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#42 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#43 [internal function]: Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#44 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#45 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(122): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#46 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(87): Illuminate\\Foundation\\Http\\Kernel->sendRequestThroughRouter(Object(Illuminate\\Http\\Request))\n#47 /var/www-sandbox/index.php(45): Illuminate\\Foundation\\Http\\Kernel->handle(Object(Illuminate\\Http\\Request))\n#48 {main}',NULL,'2017-08-16 00:08:32','2017-08-16 00:08:32'),
    (22,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'syntax error, unexpected \'?\'\' in /var/www-sandbox/storage/cms/cache/e7/ad/components.htm.php:6\nStack trace:\n#0 {main}',NULL,'2017-08-16 23:44:39','2017-08-16 23:44:39'),
    (23,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'syntax error, unexpected \'?\'\' in /var/www-sandbox/storage/cms/cache/e7/ad/components.htm.php:6\nStack trace:\n#0 {main}',NULL,'2017-08-16 23:44:48','2017-08-16 23:44:48'),
    (24,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'syntax error, unexpected \'?\'\' in /var/www-sandbox/storage/cms/cache/f7/b7/elements.htm.php:6\nStack trace:\n#0 {main}',NULL,'2017-08-16 23:44:53','2017-08-16 23:44:53'),
    (25,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'syntax error, unexpected \'?\'\' in /var/www-sandbox/storage/cms/cache/84/50/examples.htm.php:6\nStack trace:\n#0 {main}',NULL,'2017-08-16 23:44:59','2017-08-16 23:44:59'),
    (26,'error','exception \'PDOException\' with message \'SQLSTATE[42S02]: Base table or view not found: 1146 Table \'october-sandbox.jetminds_job_resumes\' doesn\'t exist\' in /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Connection.php:319\nStack trace:\n#0 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Connection.php(319): PDO->prepare(\'select count(*)...\')\n#1 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Connection.php(659): Illuminate\\Database\\Connection->Illuminate\\Database\\{closure}(Object(October\\Rain\\Database\\Connections\\MySqlConnection), \'select count(*)...\', Array)\n#2 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Connection.php(622): Illuminate\\Database\\Connection->runQueryCallback(\'select count(*)...\', Array, Object(Closure))\n#3 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Connection.php(324): Illuminate\\Database\\Connection->run(\'select count(*)...\', Array, Object(Closure))\n#4 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Query/Builder.php(1431): Illuminate\\Database\\Connection->select(\'select count(*)...\', Array, true)\n#5 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Query/Builder.php(1408): Illuminate\\Database\\Query\\Builder->runSelect()\n#6 /var/www-sandbox/vendor/october/rain/src/Database/QueryBuilder.php(110): Illuminate\\Database\\Query\\Builder->get(Array)\n#7 /var/www-sandbox/vendor/october/rain/src/Database/QueryBuilder.php(80): October\\Rain\\Database\\QueryBuilder->getDuplicateCached(Array)\n#8 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Query/Builder.php(1491): October\\Rain\\Database\\QueryBuilder->get()\n#9 /var/www-sandbox/vendor/october/rain/src/Database/Builder.php(137): Illuminate\\Database\\Query\\Builder->getCountForPagination()\n#10 /var/www-sandbox/modules/backend/Widgets/Lists.php(521): October\\Rain\\Database\\Builder->paginate(20, NULL)\n#11 /var/www-sandbox/modules/backend/Widgets/Lists.php(246): Backend\\Widgets\\Lists->getRecords()\n#12 /var/www-sandbox/modules/backend/Widgets/Lists.php(234): Backend\\Widgets\\Lists->prepareVars()\n#13 /var/www-sandbox/modules/backend/Behaviors/listcontroller/partials/_container.htm(9): Backend\\Widgets\\Lists->render()\n#14 /var/www-sandbox/modules/system/Traits/ViewMaker.php(244): include(\'/var/www-sandbo...\')\n#15 /var/www-sandbox/modules/backend/Classes/ControllerBehavior.php(142): Backend\\Classes\\Controller->makeFileContents(\'/var/www-sandbo...\', Array)\n#16 /var/www-sandbox/modules/system/Traits/ViewMaker.php(98): Backend\\Classes\\ControllerBehavior->makeFileContents(\'/var/www-sandbo...\', Array)\n#17 /var/www-sandbox/modules/backend/Behaviors/ListController.php(393): Backend\\Classes\\ControllerBehavior->makePartial(\'container\', Array)\n#18 /var/www-sandbox/modules/backend/Behaviors/ListController.php(380): Backend\\Behaviors\\ListController->listMakePartial(\'container\', Array)\n#19 [internal function]: Backend\\Behaviors\\ListController->listRender()\n#20 /var/www-sandbox/vendor/october/rain/src/Extension/ExtendableTrait.php(371): call_user_func_array(Array, Array)\n#21 /var/www-sandbox/vendor/october/rain/src/Extension/Extendable.php(42): October\\Rain\\Extension\\Extendable->extendableCall(\'listRender\', Array)\n#22 /var/www-sandbox/plugins/jetminds/job/controllers/resumes/index.htm(7): October\\Rain\\Extension\\Extendable->__call(\'listRender\', Array)\n#23 /var/www-sandbox/plugins/jetminds/job/controllers/resumes/index.htm(7): JetMinds\\Job\\Controllers\\Resumes->listRender()\n#24 /var/www-sandbox/modules/system/Traits/ViewMaker.php(244): include(\'/var/www-sandbo...\')\n#25 /var/www-sandbox/modules/system/Traits/ViewMaker.php(110): Backend\\Classes\\Controller->makeFileContents(\'/var/www-sandbo...\')\n#26 /var/www-sandbox/modules/backend/Classes/Controller.php(375): Backend\\Classes\\Controller->makeView(\'index\')\n#27 /var/www-sandbox/modules/backend/Classes/Controller.php(257): Backend\\Classes\\Controller->execPageAction(\'index\', Array)\n#28 /var/www-sandbox/modules/backend/Classes/BackendController.php(112): Backend\\Classes\\Controller->run(\'index\', Array)\n#29 [internal function]: Backend\\Classes\\BackendController->run(\'jetminds/job/re...\')\n#30 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Controller.php(256): call_user_func_array(Array, Array)\n#31 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(164): Illuminate\\Routing\\Controller->callAction(\'run\', Array)\n#32 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(112): Illuminate\\Routing\\ControllerDispatcher->call(Object(Backend\\Classes\\BackendController), Object(Illuminate\\Routing\\Route), \'run\')\n#33 [internal function]: Illuminate\\Routing\\ControllerDispatcher->Illuminate\\Routing\\{closure}(Object(Illuminate\\Http\\Request))\n#34 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(139): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#35 [internal function]: Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#36 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#37 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(114): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#38 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(69): Illuminate\\Routing\\ControllerDispatcher->callWithinStack(Object(Backend\\Classes\\BackendController), Object(Illuminate\\Routing\\Route), Object(Illuminate\\Http\\Request), \'run\')\n#39 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Route.php(203): Illuminate\\Routing\\ControllerDispatcher->dispatch(Object(Illuminate\\Routing\\Route), Object(Illuminate\\Http\\Request), \'Backend\\\\Classes...\', \'run\')\n#40 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Route.php(134): Illuminate\\Routing\\Route->runWithCustomDispatcher(Object(Illuminate\\Http\\Request))\n#41 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(708): Illuminate\\Routing\\Route->run(Object(Illuminate\\Http\\Request))\n#42 [internal function]: Illuminate\\Routing\\Router->Illuminate\\Routing\\{closure}(Object(Illuminate\\Http\\Request))\n#43 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(139): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#44 [internal function]: Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#45 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#46 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(710): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#47 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(675): Illuminate\\Routing\\Router->runRouteWithinStack(Object(Illuminate\\Routing\\Route), Object(Illuminate\\Http\\Request))\n#48 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(635): Illuminate\\Routing\\Router->dispatchToRoute(Object(Illuminate\\Http\\Request))\n#49 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(236): Illuminate\\Routing\\Router->dispatch(Object(Illuminate\\Http\\Request))\n#50 [internal function]: Illuminate\\Foundation\\Http\\Kernel->Illuminate\\Foundation\\Http\\{closure}(Object(Illuminate\\Http\\Request))\n#51 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(139): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#52 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/View/Middleware/ShareErrorsFromSession.php(49): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#53 [internal function]: Illuminate\\View\\Middleware\\ShareErrorsFromSession->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#54 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#55 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Session/Middleware/StartSession.php(62): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#56 [internal function]: Illuminate\\Session\\Middleware\\StartSession->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#57 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#58 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Cookie/Middleware/AddQueuedCookiesToResponse.php(37): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#59 [internal function]: Illuminate\\Cookie\\Middleware\\AddQueuedCookiesToResponse->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#60 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#61 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Cookie/Middleware/EncryptCookies.php(59): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#62 [internal function]: Illuminate\\Cookie\\Middleware\\EncryptCookies->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#63 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#64 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Middleware/CheckForMaintenanceMode.php(44): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#65 [internal function]: Illuminate\\Foundation\\Http\\Middleware\\CheckForMaintenanceMode->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#66 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#67 [internal function]: Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#68 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#69 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(122): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#70 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(87): Illuminate\\Foundation\\Http\\Kernel->sendRequestThroughRouter(Object(Illuminate\\Http\\Request))\n#71 /var/www-sandbox/index.php(45): Illuminate\\Foundation\\Http\\Kernel->handle(Object(Illuminate\\Http\\Request))\n#72 {main}\n\nNext exception \'Illuminate\\Database\\QueryException\' with message \'SQLSTATE[42S02]: Base table or view not found: 1146 Table \'october-sandbox.jetminds_job_resumes\' doesn\'t exist (SQL: select count(*) as aggregate from `jetminds_job_resumes`)\' in /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Connection.php:666\nStack trace:\n#0 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Connection.php(622): Illuminate\\Database\\Connection->runQueryCallback(\'select count(*)...\', Array, Object(Closure))\n#1 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Connection.php(324): Illuminate\\Database\\Connection->run(\'select count(*)...\', Array, Object(Closure))\n#2 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Query/Builder.php(1431): Illuminate\\Database\\Connection->select(\'select count(*)...\', Array, true)\n#3 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Query/Builder.php(1408): Illuminate\\Database\\Query\\Builder->runSelect()\n#4 /var/www-sandbox/vendor/october/rain/src/Database/QueryBuilder.php(110): Illuminate\\Database\\Query\\Builder->get(Array)\n#5 /var/www-sandbox/vendor/october/rain/src/Database/QueryBuilder.php(80): October\\Rain\\Database\\QueryBuilder->getDuplicateCached(Array)\n#6 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Query/Builder.php(1491): October\\Rain\\Database\\QueryBuilder->get()\n#7 /var/www-sandbox/vendor/october/rain/src/Database/Builder.php(137): Illuminate\\Database\\Query\\Builder->getCountForPagination()\n#8 /var/www-sandbox/modules/backend/Widgets/Lists.php(521): October\\Rain\\Database\\Builder->paginate(20, NULL)\n#9 /var/www-sandbox/modules/backend/Widgets/Lists.php(246): Backend\\Widgets\\Lists->getRecords()\n#10 /var/www-sandbox/modules/backend/Widgets/Lists.php(234): Backend\\Widgets\\Lists->prepareVars()\n#11 /var/www-sandbox/modules/backend/Behaviors/listcontroller/partials/_container.htm(9): Backend\\Widgets\\Lists->render()\n#12 /var/www-sandbox/modules/system/Traits/ViewMaker.php(244): include(\'/var/www-sandbo...\')\n#13 /var/www-sandbox/modules/backend/Classes/ControllerBehavior.php(142): Backend\\Classes\\Controller->makeFileContents(\'/var/www-sandbo...\', Array)\n#14 /var/www-sandbox/modules/system/Traits/ViewMaker.php(98): Backend\\Classes\\ControllerBehavior->makeFileContents(\'/var/www-sandbo...\', Array)\n#15 /var/www-sandbox/modules/backend/Behaviors/ListController.php(393): Backend\\Classes\\ControllerBehavior->makePartial(\'container\', Array)\n#16 /var/www-sandbox/modules/backend/Behaviors/ListController.php(380): Backend\\Behaviors\\ListController->listMakePartial(\'container\', Array)\n#17 [internal function]: Backend\\Behaviors\\ListController->listRender()\n#18 /var/www-sandbox/vendor/october/rain/src/Extension/ExtendableTrait.php(371): call_user_func_array(Array, Array)\n#19 /var/www-sandbox/vendor/october/rain/src/Extension/Extendable.php(42): October\\Rain\\Extension\\Extendable->extendableCall(\'listRender\', Array)\n#20 /var/www-sandbox/plugins/jetminds/job/controllers/resumes/index.htm(7): October\\Rain\\Extension\\Extendable->__call(\'listRender\', Array)\n#21 /var/www-sandbox/plugins/jetminds/job/controllers/resumes/index.htm(7): JetMinds\\Job\\Controllers\\Resumes->listRender()\n#22 /var/www-sandbox/modules/system/Traits/ViewMaker.php(244): include(\'/var/www-sandbo...\')\n#23 /var/www-sandbox/modules/system/Traits/ViewMaker.php(110): Backend\\Classes\\Controller->makeFileContents(\'/var/www-sandbo...\')\n#24 /var/www-sandbox/modules/backend/Classes/Controller.php(375): Backend\\Classes\\Controller->makeView(\'index\')\n#25 /var/www-sandbox/modules/backend/Classes/Controller.php(257): Backend\\Classes\\Controller->execPageAction(\'index\', Array)\n#26 /var/www-sandbox/modules/backend/Classes/BackendController.php(112): Backend\\Classes\\Controller->run(\'index\', Array)\n#27 [internal function]: Backend\\Classes\\BackendController->run(\'jetminds/job/re...\')\n#28 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Controller.php(256): call_user_func_array(Array, Array)\n#29 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(164): Illuminate\\Routing\\Controller->callAction(\'run\', Array)\n#30 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(112): Illuminate\\Routing\\ControllerDispatcher->call(Object(Backend\\Classes\\BackendController), Object(Illuminate\\Routing\\Route), \'run\')\n#31 [internal function]: Illuminate\\Routing\\ControllerDispatcher->Illuminate\\Routing\\{closure}(Object(Illuminate\\Http\\Request))\n#32 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(139): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#33 [internal function]: Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#34 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#35 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(114): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#36 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(69): Illuminate\\Routing\\ControllerDispatcher->callWithinStack(Object(Backend\\Classes\\BackendController), Object(Illuminate\\Routing\\Route), Object(Illuminate\\Http\\Request), \'run\')\n#37 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Route.php(203): Illuminate\\Routing\\ControllerDispatcher->dispatch(Object(Illuminate\\Routing\\Route), Object(Illuminate\\Http\\Request), \'Backend\\\\Classes...\', \'run\')\n#38 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Route.php(134): Illuminate\\Routing\\Route->runWithCustomDispatcher(Object(Illuminate\\Http\\Request))\n#39 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(708): Illuminate\\Routing\\Route->run(Object(Illuminate\\Http\\Request))\n#40 [internal function]: Illuminate\\Routing\\Router->Illuminate\\Routing\\{closure}(Object(Illuminate\\Http\\Request))\n#41 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(139): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#42 [internal function]: Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#43 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#44 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(710): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#45 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(675): Illuminate\\Routing\\Router->runRouteWithinStack(Object(Illuminate\\Routing\\Route), Object(Illuminate\\Http\\Request))\n#46 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(635): Illuminate\\Routing\\Router->dispatchToRoute(Object(Illuminate\\Http\\Request))\n#47 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(236): Illuminate\\Routing\\Router->dispatch(Object(Illuminate\\Http\\Request))\n#48 [internal function]: Illuminate\\Foundation\\Http\\Kernel->Illuminate\\Foundation\\Http\\{closure}(Object(Illuminate\\Http\\Request))\n#49 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(139): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#50 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/View/Middleware/ShareErrorsFromSession.php(49): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#51 [internal function]: Illuminate\\View\\Middleware\\ShareErrorsFromSession->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#52 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#53 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Session/Middleware/StartSession.php(62): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#54 [internal function]: Illuminate\\Session\\Middleware\\StartSession->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#55 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#56 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Cookie/Middleware/AddQueuedCookiesToResponse.php(37): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#57 [internal function]: Illuminate\\Cookie\\Middleware\\AddQueuedCookiesToResponse->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#58 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#59 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Cookie/Middleware/EncryptCookies.php(59): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#60 [internal function]: Illuminate\\Cookie\\Middleware\\EncryptCookies->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#61 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#62 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Middleware/CheckForMaintenanceMode.php(44): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#63 [internal function]: Illuminate\\Foundation\\Http\\Middleware\\CheckForMaintenanceMode->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#64 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#65 [internal function]: Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#66 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#67 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(122): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#68 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(87): Illuminate\\Foundation\\Http\\Kernel->sendRequestThroughRouter(Object(Illuminate\\Http\\Request))\n#69 /var/www-sandbox/index.php(45): Illuminate\\Foundation\\Http\\Kernel->handle(Object(Illuminate\\Http\\Request))\n#70 {main}',NULL,'2017-08-17 22:49:13','2017-08-17 22:49:13'),
    (27,'error','exception \'PDOException\' with message \'SQLSTATE[42S02]: Base table or view not found: 1146 Table \'october-sandbox.janvince_smallrecords_areas\' doesn\'t exist\' in /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Connection.php:319\nStack trace:\n#0 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Connection.php(319): PDO->prepare(\'select * from `...\')\n#1 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Connection.php(659): Illuminate\\Database\\Connection->Illuminate\\Database\\{closure}(Object(October\\Rain\\Database\\Connections\\MySqlConnection), \'select * from `...\', Array)\n#2 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Connection.php(622): Illuminate\\Database\\Connection->runQueryCallback(\'select * from `...\', Array, Object(Closure))\n#3 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Connection.php(324): Illuminate\\Database\\Connection->run(\'select * from `...\', Array, Object(Closure))\n#4 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Query/Builder.php(1431): Illuminate\\Database\\Connection->select(\'select * from `...\', Array, true)\n#5 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Query/Builder.php(1408): Illuminate\\Database\\Query\\Builder->runSelect()\n#6 /var/www-sandbox/vendor/october/rain/src/Database/QueryBuilder.php(110): Illuminate\\Database\\Query\\Builder->get(Array)\n#7 /var/www-sandbox/vendor/october/rain/src/Database/QueryBuilder.php(80): October\\Rain\\Database\\QueryBuilder->getDuplicateCached(Array)\n#8 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Builder.php(477): October\\Rain\\Database\\QueryBuilder->get(Array)\n#9 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Builder.php(234): Illuminate\\Database\\Eloquent\\Builder->getModels(Array)\n#10 [internal function]: Illuminate\\Database\\Eloquent\\Builder->get()\n#11 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Model.php(3444): call_user_func_array(Array, Array)\n#12 /var/www-sandbox/vendor/october/rain/src/Extension/ExtendableTrait.php(385): Illuminate\\Database\\Eloquent\\Model->__call(\'get\', Array)\n#13 /var/www-sandbox/vendor/october/rain/src/Database/Model.php(516): October\\Rain\\Database\\Model->extendableCall(\'get\', Array)\n#14 [internal function]: October\\Rain\\Database\\Model->__call(\'get\', Array)\n#15 [internal function]: JanVince\\SmallRecords\\Models\\Area->get()\n#16 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Model.php(3458): call_user_func_array(Array, Array)\n#17 /var/www-sandbox/plugins/janvince/smallrecords/Plugin.php(65): Illuminate\\Database\\Eloquent\\Model::__callStatic(\'get\', Array)\n#18 /var/www-sandbox/plugins/janvince/smallrecords/Plugin.php(65): JanVince\\SmallRecords\\Models\\Area::get()\n#19 /var/www-sandbox/modules/backend/Classes/NavigationManager.php(89): JanVince\\SmallRecords\\Plugin->registerNavigation()\n#20 /var/www-sandbox/modules/backend/Classes/NavigationManager.php(306): Backend\\Classes\\NavigationManager->loadItems()\n#21 /var/www-sandbox/modules/backend/Classes/NavigationManager.php(417): Backend\\Classes\\NavigationManager->listMainMenuItems()\n#22 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Support/Facades/Facade.php(213): Backend\\Classes\\NavigationManager->getActiveMainMenuItem()\n#23 /var/www-sandbox/modules/backend/layouts/_mainmenu.htm(2): Illuminate\\Support\\Facades\\Facade::__callStatic(\'getActiveMainMe...\', Array)\n#24 /var/www-sandbox/modules/backend/layouts/_mainmenu.htm(2): Backend\\Facades\\BackendMenu::getActiveMainMenuItem()\n#25 /var/www-sandbox/modules/system/Traits/ViewMaker.php(244): include(\'/var/www-sandbo...\')\n#26 /var/www-sandbox/modules/system/Traits/ViewMaker.php(158): Backend\\Classes\\Controller->makeFileContents(\'/var/www-sandbo...\', Array)\n#27 /var/www-sandbox/modules/system/Traits/ViewMaker.php(174): Backend\\Classes\\Controller->makeLayout(\'_mainmenu\', Array)\n#28 /var/www-sandbox/modules/backend/layouts/default.htm(12): Backend\\Classes\\Controller->makeLayoutPartial(\'mainmenu\')\n#29 /var/www-sandbox/modules/system/Traits/ViewMaker.php(244): include(\'/var/www-sandbo...\')\n#30 /var/www-sandbox/modules/system/Traits/ViewMaker.php(158): Backend\\Classes\\Controller->makeFileContents(\'/var/www-sandbo...\', Array)\n#31 /var/www-sandbox/modules/system/Traits/ViewMaker.php(129): Backend\\Classes\\Controller->makeLayout(NULL)\n#32 /var/www-sandbox/modules/system/Traits/ViewMaker.php(111): Backend\\Classes\\Controller->makeViewContent(\'<form method=\"P...\')\n#33 /var/www-sandbox/modules/backend/Classes/Controller.php(375): Backend\\Classes\\Controller->makeView(\'index\')\n#34 /var/www-sandbox/modules/backend/Classes/Controller.php(257): Backend\\Classes\\Controller->execPageAction(\'index\', Array)\n#35 /var/www-sandbox/modules/backend/Classes/BackendController.php(95): Backend\\Classes\\Controller->run(\'index\', Array)\n#36 [internal function]: Backend\\Classes\\BackendController->run()\n#37 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Controller.php(256): call_user_func_array(Array, Array)\n#38 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(164): Illuminate\\Routing\\Controller->callAction(\'run\', Array)\n#39 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(112): Illuminate\\Routing\\ControllerDispatcher->call(Object(Backend\\Classes\\BackendController), Object(Illuminate\\Routing\\Route), \'run\')\n#40 [internal function]: Illuminate\\Routing\\ControllerDispatcher->Illuminate\\Routing\\{closure}(Object(Illuminate\\Http\\Request))\n#41 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(139): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#42 [internal function]: Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#43 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#44 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(114): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#45 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(69): Illuminate\\Routing\\ControllerDispatcher->callWithinStack(Object(Backend\\Classes\\BackendController), Object(Illuminate\\Routing\\Route), Object(Illuminate\\Http\\Request), \'run\')\n#46 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Route.php(203): Illuminate\\Routing\\ControllerDispatcher->dispatch(Object(Illuminate\\Routing\\Route), Object(Illuminate\\Http\\Request), \'Backend\\\\Classes...\', \'run\')\n#47 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Route.php(134): Illuminate\\Routing\\Route->runWithCustomDispatcher(Object(Illuminate\\Http\\Request))\n#48 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(708): Illuminate\\Routing\\Route->run(Object(Illuminate\\Http\\Request))\n#49 [internal function]: Illuminate\\Routing\\Router->Illuminate\\Routing\\{closure}(Object(Illuminate\\Http\\Request))\n#50 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(139): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#51 [internal function]: Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#52 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#53 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(710): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#54 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(675): Illuminate\\Routing\\Router->runRouteWithinStack(Object(Illuminate\\Routing\\Route), Object(Illuminate\\Http\\Request))\n#55 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(635): Illuminate\\Routing\\Router->dispatchToRoute(Object(Illuminate\\Http\\Request))\n#56 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(236): Illuminate\\Routing\\Router->dispatch(Object(Illuminate\\Http\\Request))\n#57 [internal function]: Illuminate\\Foundation\\Http\\Kernel->Illuminate\\Foundation\\Http\\{closure}(Object(Illuminate\\Http\\Request))\n#58 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(139): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#59 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/View/Middleware/ShareErrorsFromSession.php(49): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#60 [internal function]: Illuminate\\View\\Middleware\\ShareErrorsFromSession->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#61 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#62 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Session/Middleware/StartSession.php(62): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#63 [internal function]: Illuminate\\Session\\Middleware\\StartSession->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#64 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#65 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Cookie/Middleware/AddQueuedCookiesToResponse.php(37): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#66 [internal function]: Illuminate\\Cookie\\Middleware\\AddQueuedCookiesToResponse->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#67 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#68 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Cookie/Middleware/EncryptCookies.php(59): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#69 [internal function]: Illuminate\\Cookie\\Middleware\\EncryptCookies->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#70 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#71 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Middleware/CheckForMaintenanceMode.php(44): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#72 [internal function]: Illuminate\\Foundation\\Http\\Middleware\\CheckForMaintenanceMode->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#73 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#74 [internal function]: Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#75 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#76 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(122): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#77 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(87): Illuminate\\Foundation\\Http\\Kernel->sendRequestThroughRouter(Object(Illuminate\\Http\\Request))\n#78 /var/www-sandbox/index.php(45): Illuminate\\Foundation\\Http\\Kernel->handle(Object(Illuminate\\Http\\Request))\n#79 {main}\n\nNext exception \'Illuminate\\Database\\QueryException\' with message \'SQLSTATE[42S02]: Base table or view not found: 1146 Table \'october-sandbox.janvince_smallrecords_areas\' doesn\'t exist (SQL: select * from `janvince_smallrecords_areas`)\' in /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Connection.php:666\nStack trace:\n#0 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Connection.php(622): Illuminate\\Database\\Connection->runQueryCallback(\'select * from `...\', Array, Object(Closure))\n#1 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Connection.php(324): Illuminate\\Database\\Connection->run(\'select * from `...\', Array, Object(Closure))\n#2 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Query/Builder.php(1431): Illuminate\\Database\\Connection->select(\'select * from `...\', Array, true)\n#3 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Query/Builder.php(1408): Illuminate\\Database\\Query\\Builder->runSelect()\n#4 /var/www-sandbox/vendor/october/rain/src/Database/QueryBuilder.php(110): Illuminate\\Database\\Query\\Builder->get(Array)\n#5 /var/www-sandbox/vendor/october/rain/src/Database/QueryBuilder.php(80): October\\Rain\\Database\\QueryBuilder->getDuplicateCached(Array)\n#6 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Builder.php(477): October\\Rain\\Database\\QueryBuilder->get(Array)\n#7 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Builder.php(234): Illuminate\\Database\\Eloquent\\Builder->getModels(Array)\n#8 [internal function]: Illuminate\\Database\\Eloquent\\Builder->get()\n#9 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Model.php(3444): call_user_func_array(Array, Array)\n#10 /var/www-sandbox/vendor/october/rain/src/Extension/ExtendableTrait.php(385): Illuminate\\Database\\Eloquent\\Model->__call(\'get\', Array)\n#11 /var/www-sandbox/vendor/october/rain/src/Database/Model.php(516): October\\Rain\\Database\\Model->extendableCall(\'get\', Array)\n#12 [internal function]: October\\Rain\\Database\\Model->__call(\'get\', Array)\n#13 [internal function]: JanVince\\SmallRecords\\Models\\Area->get()\n#14 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Model.php(3458): call_user_func_array(Array, Array)\n#15 /var/www-sandbox/plugins/janvince/smallrecords/Plugin.php(65): Illuminate\\Database\\Eloquent\\Model::__callStatic(\'get\', Array)\n#16 /var/www-sandbox/plugins/janvince/smallrecords/Plugin.php(65): JanVince\\SmallRecords\\Models\\Area::get()\n#17 /var/www-sandbox/modules/backend/Classes/NavigationManager.php(89): JanVince\\SmallRecords\\Plugin->registerNavigation()\n#18 /var/www-sandbox/modules/backend/Classes/NavigationManager.php(306): Backend\\Classes\\NavigationManager->loadItems()\n#19 /var/www-sandbox/modules/backend/Classes/NavigationManager.php(417): Backend\\Classes\\NavigationManager->listMainMenuItems()\n#20 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Support/Facades/Facade.php(213): Backend\\Classes\\NavigationManager->getActiveMainMenuItem()\n#21 /var/www-sandbox/modules/backend/layouts/_mainmenu.htm(2): Illuminate\\Support\\Facades\\Facade::__callStatic(\'getActiveMainMe...\', Array)\n#22 /var/www-sandbox/modules/backend/layouts/_mainmenu.htm(2): Backend\\Facades\\BackendMenu::getActiveMainMenuItem()\n#23 /var/www-sandbox/modules/system/Traits/ViewMaker.php(244): include(\'/var/www-sandbo...\')\n#24 /var/www-sandbox/modules/system/Traits/ViewMaker.php(158): Backend\\Classes\\Controller->makeFileContents(\'/var/www-sandbo...\', Array)\n#25 /var/www-sandbox/modules/system/Traits/ViewMaker.php(174): Backend\\Classes\\Controller->makeLayout(\'_mainmenu\', Array)\n#26 /var/www-sandbox/modules/backend/layouts/default.htm(12): Backend\\Classes\\Controller->makeLayoutPartial(\'mainmenu\')\n#27 /var/www-sandbox/modules/system/Traits/ViewMaker.php(244): include(\'/var/www-sandbo...\')\n#28 /var/www-sandbox/modules/system/Traits/ViewMaker.php(158): Backend\\Classes\\Controller->makeFileContents(\'/var/www-sandbo...\', Array)\n#29 /var/www-sandbox/modules/system/Traits/ViewMaker.php(129): Backend\\Classes\\Controller->makeLayout(NULL)\n#30 /var/www-sandbox/modules/system/Traits/ViewMaker.php(111): Backend\\Classes\\Controller->makeViewContent(\'<form method=\"P...\')\n#31 /var/www-sandbox/modules/backend/Classes/Controller.php(375): Backend\\Classes\\Controller->makeView(\'index\')\n#32 /var/www-sandbox/modules/backend/Classes/Controller.php(257): Backend\\Classes\\Controller->execPageAction(\'index\', Array)\n#33 /var/www-sandbox/modules/backend/Classes/BackendController.php(95): Backend\\Classes\\Controller->run(\'index\', Array)\n#34 [internal function]: Backend\\Classes\\BackendController->run()\n#35 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Controller.php(256): call_user_func_array(Array, Array)\n#36 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(164): Illuminate\\Routing\\Controller->callAction(\'run\', Array)\n#37 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(112): Illuminate\\Routing\\ControllerDispatcher->call(Object(Backend\\Classes\\BackendController), Object(Illuminate\\Routing\\Route), \'run\')\n#38 [internal function]: Illuminate\\Routing\\ControllerDispatcher->Illuminate\\Routing\\{closure}(Object(Illuminate\\Http\\Request))\n#39 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(139): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#40 [internal function]: Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#41 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#42 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(114): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#43 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(69): Illuminate\\Routing\\ControllerDispatcher->callWithinStack(Object(Backend\\Classes\\BackendController), Object(Illuminate\\Routing\\Route), Object(Illuminate\\Http\\Request), \'run\')\n#44 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Route.php(203): Illuminate\\Routing\\ControllerDispatcher->dispatch(Object(Illuminate\\Routing\\Route), Object(Illuminate\\Http\\Request), \'Backend\\\\Classes...\', \'run\')\n#45 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Route.php(134): Illuminate\\Routing\\Route->runWithCustomDispatcher(Object(Illuminate\\Http\\Request))\n#46 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(708): Illuminate\\Routing\\Route->run(Object(Illuminate\\Http\\Request))\n#47 [internal function]: Illuminate\\Routing\\Router->Illuminate\\Routing\\{closure}(Object(Illuminate\\Http\\Request))\n#48 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(139): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#49 [internal function]: Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#50 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#51 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(710): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#52 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(675): Illuminate\\Routing\\Router->runRouteWithinStack(Object(Illuminate\\Routing\\Route), Object(Illuminate\\Http\\Request))\n#53 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Routing/Router.php(635): Illuminate\\Routing\\Router->dispatchToRoute(Object(Illuminate\\Http\\Request))\n#54 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(236): Illuminate\\Routing\\Router->dispatch(Object(Illuminate\\Http\\Request))\n#55 [internal function]: Illuminate\\Foundation\\Http\\Kernel->Illuminate\\Foundation\\Http\\{closure}(Object(Illuminate\\Http\\Request))\n#56 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(139): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#57 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/View/Middleware/ShareErrorsFromSession.php(49): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#58 [internal function]: Illuminate\\View\\Middleware\\ShareErrorsFromSession->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#59 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#60 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Session/Middleware/StartSession.php(62): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#61 [internal function]: Illuminate\\Session\\Middleware\\StartSession->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#62 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#63 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Cookie/Middleware/AddQueuedCookiesToResponse.php(37): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#64 [internal function]: Illuminate\\Cookie\\Middleware\\AddQueuedCookiesToResponse->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#65 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#66 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Cookie/Middleware/EncryptCookies.php(59): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#67 [internal function]: Illuminate\\Cookie\\Middleware\\EncryptCookies->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#68 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#69 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Middleware/CheckForMaintenanceMode.php(44): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#70 [internal function]: Illuminate\\Foundation\\Http\\Middleware\\CheckForMaintenanceMode->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#71 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(124): call_user_func_array(Array, Array)\n#72 [internal function]: Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#73 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): call_user_func(Object(Closure), Object(Illuminate\\Http\\Request))\n#74 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(122): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#75 /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(87): Illuminate\\Foundation\\Http\\Kernel->sendRequestThroughRouter(Object(Illuminate\\Http\\Request))\n#76 /var/www-sandbox/index.php(45): Illuminate\\Foundation\\Http\\Kernel->handle(Object(Illuminate\\Http\\Request))\n#77 {main}',NULL,'2017-09-13 00:02:51','2017-09-13 00:02:51'),
    (28,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Laravel\\Cashier\\CashierServiceProvider\' not found\' in /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Application.php:575\nStack trace:\n#0 {main}',NULL,'2017-10-11 00:31:53','2017-10-11 00:31:53'),
    (29,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Laravel\\Cashier\\CashierServiceProvider\' not found\' in /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Application.php:575\nStack trace:\n#0 {main}',NULL,'2017-10-11 00:31:55','2017-10-11 00:31:55'),
    (30,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Laravel\\Cashier\\CashierServiceProvider\' not found\' in /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Application.php:575\nStack trace:\n#0 {main}',NULL,'2017-10-11 00:32:40','2017-10-11 00:32:40'),
    (31,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Laravel\\Cashier\\CashierServiceProvider\' not found\' in /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Application.php:575\nStack trace:\n#0 {main}',NULL,'2017-10-11 00:32:40','2017-10-11 00:32:40'),
    (32,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Laravel\\Cashier\\CashierServiceProvider\' not found\' in /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Application.php:575\nStack trace:\n#0 {main}',NULL,'2017-10-11 00:32:48','2017-10-11 00:32:48'),
    (33,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Laravel\\Cashier\\CashierServiceProvider\' not found\' in /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Application.php:575\nStack trace:\n#0 {main}',NULL,'2017-10-11 00:32:51','2017-10-11 00:32:51'),
    (34,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Laravel\\Cashier\\CashierServiceProvider\' not found\' in /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Application.php:575\nStack trace:\n#0 {main}',NULL,'2017-10-11 00:32:54','2017-10-11 00:32:54'),
    (35,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Laravel\\Cashier\\CashierServiceProvider\' not found\' in /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Application.php:575\nStack trace:\n#0 {main}',NULL,'2017-10-11 00:32:55','2017-10-11 00:32:55'),
    (36,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Laravel\\Cashier\\CashierServiceProvider\' not found\' in /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Application.php:575\nStack trace:\n#0 {main}',NULL,'2017-10-11 00:33:13','2017-10-11 00:33:13'),
    (37,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Laravel\\Cashier\\CashierServiceProvider\' not found\' in /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Application.php:575\nStack trace:\n#0 {main}',NULL,'2017-10-11 00:33:13','2017-10-11 00:33:13'),
    (38,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Laravel\\Cashier\\CashierServiceProvider\' not found\' in /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Application.php:575\nStack trace:\n#0 {main}',NULL,'2017-10-11 00:37:44','2017-10-11 00:37:44'),
    (39,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Laravel\\Cashier\\CashierServiceProvider\' not found\' in /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Application.php:575\nStack trace:\n#0 {main}',NULL,'2017-10-11 00:37:44','2017-10-11 00:37:44'),
    (40,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Laravel\\Cashier\\CashierServiceProvider\' not found\' in /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Application.php:575\nStack trace:\n#0 {main}',NULL,'2017-10-11 00:37:45','2017-10-11 00:37:45'),
    (41,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Laravel\\Cashier\\CashierServiceProvider\' not found\' in /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Application.php:575\nStack trace:\n#0 {main}',NULL,'2017-10-11 00:37:45','2017-10-11 00:37:45'),
    (42,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Laravel\\Cashier\\CashierServiceProvider\' not found\' in /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Application.php:575\nStack trace:\n#0 {main}',NULL,'2017-10-11 00:37:46','2017-10-11 00:37:46'),
    (43,'error','exception \'Symfony\\Component\\Debug\\Exception\\FatalErrorException\' with message \'Class \'Laravel\\Cashier\\CashierServiceProvider\' not found\' in /var/www-sandbox/vendor/laravel/framework/src/Illuminate/Foundation/Application.php:575\nStack trace:\n#0 {main}',NULL,'2017-10-11 00:37:46','2017-10-11 00:37:46');

/*!40000 ALTER TABLE `system_event_logs` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table system_files
# ------------------------------------------------------------

CREATE TABLE `system_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `disk_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `file_size` int(11) NOT NULL,
  `content_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `field` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attachment_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attachment_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `stefan_gallery_tags` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `system_files_field_index` (`field`),
  KEY `system_files_attachment_id_index` (`attachment_id`),
  KEY `system_files_attachment_type_index` (`attachment_type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `system_files` WRITE;
/*!40000 ALTER TABLE `system_files` DISABLE KEYS */;

INSERT INTO `system_files` (`id`, `disk_name`, `file_name`, `file_size`, `content_type`, `title`, `description`, `field`, `attachment_id`, `attachment_type`, `is_public`, `sort_order`, `created_at`, `updated_at`, `stefan_gallery_tags`)
VALUES
    (1,'595ed1850b02b618215727.png','no_image.png',14352,'image/png',NULL,NULL,'default_product_image',NULL,'Feegleweb\\Octoshop\\Models\\FrontendSettings',1,1,'2017-07-07 00:10:45','2017-07-07 00:10:45',NULL);

/*!40000 ALTER TABLE `system_files` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table system_mail_layouts
# ------------------------------------------------------------

CREATE TABLE `system_mail_layouts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content_html` text COLLATE utf8_unicode_ci,
  `content_text` text COLLATE utf8_unicode_ci,
  `content_css` text COLLATE utf8_unicode_ci,
  `is_locked` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `system_mail_layouts` WRITE;
/*!40000 ALTER TABLE `system_mail_layouts` DISABLE KEYS */;

INSERT INTO `system_mail_layouts` (`id`, `name`, `code`, `content_html`, `content_text`, `content_css`, `is_locked`, `created_at`, `updated_at`)
VALUES
    (1,'Default','default','<html>\n    <head>\n        <style type=\"text/css\" media=\"screen\">\n            {{ css|raw }}\n        </style>\n    </head>\n    <body>\n        {{ content|raw }}\n    </body>\n</html>','{{ content|raw }}','a, a:hover {\n    text-decoration: none;\n    color: #0862A2;\n    font-weight: bold;\n}\n\ntd, tr, th, table {\n    padding: 0px;\n    margin: 0px;\n}\n\np {\n    margin: 10px 0;\n}',1,'2017-06-20 23:47:43','2017-06-20 23:47:43'),
    (2,'System','system','<html>\n    <head>\n        <style type=\"text/css\" media=\"screen\">\n            {{ css|raw }}\n        </style>\n    </head>\n    <body>\n        {{ content|raw }}\n        <hr />\n        <p>This is an automatic message. Please do not reply to it.</p>\n    </body>\n</html>','{{ content|raw }}\n\n\n---\nThis is an automatic message. Please do not reply to it.','a, a:hover {\n    text-decoration: none;\n    color: #0862A2;\n    font-weight: bold;\n}\n\ntd, tr, th, table {\n    padding: 0px;\n    margin: 0px;\n}\n\np {\n    margin: 10px 0;\n}',1,'2017-06-20 23:47:43','2017-06-20 23:47:43');

/*!40000 ALTER TABLE `system_mail_layouts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table system_mail_templates
# ------------------------------------------------------------

CREATE TABLE `system_mail_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `content_html` text COLLATE utf8_unicode_ci,
  `content_text` text COLLATE utf8_unicode_ci,
  `layout_id` int(11) DEFAULT NULL,
  `is_custom` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `system_mail_templates_layout_id_index` (`layout_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table system_parameters
# ------------------------------------------------------------

CREATE TABLE `system_parameters` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `namespace` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `group` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `item` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `item_index` (`namespace`,`group`,`item`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `system_parameters` WRITE;
/*!40000 ALTER TABLE `system_parameters` DISABLE KEYS */;

INSERT INTO `system_parameters` (`id`, `namespace`, `group`, `item`, `value`)
VALUES
    (1,'system','update','count','0'),
    (2,'system','update','retry','1507769330'),
    (3,'cms','theme','active','\"ksoft-ksoft-bulma\"'),
    (4,'system','core','hash','\"386846ebe3802c4f192625743abb3f06\"'),
    (5,'system','core','build','\"419\"');

/*!40000 ALTER TABLE `system_parameters` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table system_plugin_history
# ------------------------------------------------------------

CREATE TABLE `system_plugin_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `version` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `detail` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `system_plugin_history_code_index` (`code`),
  KEY `system_plugin_history_type_index` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=805 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `system_plugin_history` WRITE;
/*!40000 ALTER TABLE `system_plugin_history` DISABLE KEYS */;

INSERT INTO `system_plugin_history` (`id`, `code`, `type`, `version`, `detail`, `created_at`)
VALUES
    (1,'October.Demo','comment','1.0.1','First version of Demo','2017-06-20 23:47:43'),
    (322,'HareShop.Catalog','script','1.0.1','create_attribute_table.php','2017-06-30 01:34:33'),
    (323,'HareShop.Catalog','script','1.0.1','create_product_table.php','2017-06-30 01:34:33'),
    (324,'HareShop.Catalog','script','1.0.1','create_order_table.php','2017-06-30 01:34:33'),
    (325,'HareShop.Catalog','script','1.0.1','create_tax_ship_table.php','2017-06-30 01:34:33'),
    (326,'HareShop.Catalog','script','1.0.1','create_setting_table.php','2017-06-30 01:34:33'),
    (327,'HareShop.Catalog','script','1.0.1','catalog_seeder.php','2017-06-30 01:34:33'),
    (328,'HareShop.Catalog','comment','1.0.1','Initialize plugin.','2017-06-30 01:34:33'),
    (329,'HareShop.Catalog','comment','1.0.2','Add Paypal payment method','2017-06-30 01:34:33'),
    (330,'HareShop.Catalog','script','1.0.3','create_field_related_product.php','2017-06-30 01:34:33'),
    (331,'HareShop.Catalog','comment','1.0.3','Add event before delete product, create related product, change status','2017-06-30 01:34:33'),
    (332,'HareShop.Catalog','comment','1.0.4','Fix bug creating related product','2017-06-30 01:34:33'),
    (333,'HareShop.Catalog','script','1.0.5','change_field_type_id.php','2017-06-30 01:34:34'),
    (334,'HareShop.Catalog','comment','1.0.5','change type_id in table \'hare_product_type\' to unique','2017-06-30 01:34:34'),
    (335,'HareShop.Catalog','comment','1.0.6','Add loading gif when creating related product','2017-06-30 01:34:34'),
    (336,'HareShop.Catalog','comment','1.0.7','fix bug when remove plugin, check status in component product, set status default enable','2017-06-30 01:34:34'),
    (337,'HareShop.Catalog','comment','1.0.8','fix bug is_homepage, is_featured_product','2017-06-30 01:34:34'),
    (338,'HareShop.Catalog','comment','1.0.9','change type of filter option, add payment method Stripe','2017-06-30 01:34:34'),
    (339,'HareShop.Catalog','comment','1.0.10','fix currency when checkout','2017-06-30 01:34:34'),
    (340,'HareShop.Catalog','comment','1.1.1','fix display product status','2017-06-30 01:34:34'),
    (341,'HareShop.Catalog','comment','1.1.2','extends component product','2017-06-30 01:34:34'),
    (342,'RainLab.User','script','1.0.1','create_users_table.php','2017-06-30 01:35:32'),
    (343,'RainLab.User','script','1.0.1','create_throttle_table.php','2017-06-30 01:35:32'),
    (344,'RainLab.User','comment','1.0.1','Initialize plugin.','2017-06-30 01:35:32'),
    (345,'RainLab.User','comment','1.0.2','Seed tables.','2017-06-30 01:35:32'),
    (346,'RainLab.User','comment','1.0.3','Translated hard-coded text to language strings.','2017-06-30 01:35:32'),
    (347,'RainLab.User','comment','1.0.4','Improvements to user-interface for Location manager.','2017-06-30 01:35:32'),
    (348,'RainLab.User','comment','1.0.5','Added contact details for users.','2017-06-30 01:35:32'),
    (349,'RainLab.User','script','1.0.6','create_mail_blockers_table.php','2017-06-30 01:35:32'),
    (350,'RainLab.User','comment','1.0.6','Added Mail Blocker utility so users can block specific mail templates.','2017-06-30 01:35:32'),
    (351,'RainLab.User','comment','1.0.7','Add back-end Settings page.','2017-06-30 01:35:32'),
    (352,'RainLab.User','comment','1.0.8','Updated the Settings page.','2017-06-30 01:35:32'),
    (353,'RainLab.User','comment','1.0.9','Adds new welcome mail message for users and administrators.','2017-06-30 01:35:32'),
    (354,'RainLab.User','comment','1.0.10','Adds administrator-only activation mode.','2017-06-30 01:35:32'),
    (355,'RainLab.User','script','1.0.11','users_add_login_column.php','2017-06-30 01:35:32'),
    (356,'RainLab.User','comment','1.0.11','Users now have an optional login field that defaults to the email field.','2017-06-30 01:35:32'),
    (357,'RainLab.User','script','1.0.12','users_rename_login_to_username.php','2017-06-30 01:35:33'),
    (358,'RainLab.User','comment','1.0.12','Create a dedicated setting for choosing the login mode.','2017-06-30 01:35:33'),
    (359,'RainLab.User','comment','1.0.13','Minor fix to the Account sign in logic.','2017-06-30 01:35:33'),
    (360,'RainLab.User','comment','1.0.14','Minor improvements to the code.','2017-06-30 01:35:33'),
    (361,'RainLab.User','script','1.0.15','users_add_surname.php','2017-06-30 01:35:33'),
    (362,'RainLab.User','comment','1.0.15','Adds last name column to users table (surname).','2017-06-30 01:35:33'),
    (363,'RainLab.User','comment','1.0.16','Require permissions for settings page too.','2017-06-30 01:35:33'),
    (364,'RainLab.User','comment','1.1.0','!!! Profile fields and Locations have been removed.','2017-06-30 01:35:33'),
    (365,'RainLab.User','script','1.1.1','create_user_groups_table.php','2017-06-30 01:35:33'),
    (366,'RainLab.User','script','1.1.1','seed_user_groups_table.php','2017-06-30 01:35:33'),
    (367,'RainLab.User','comment','1.1.1','Users can now be added to groups.','2017-06-30 01:35:33'),
    (368,'RainLab.User','comment','1.1.2','A raw URL can now be passed as the redirect property in the Account component.','2017-06-30 01:35:33'),
    (369,'RainLab.User','comment','1.1.3','Adds a super user flag to the users table, reserved for future use.','2017-06-30 01:35:33'),
    (370,'RainLab.User','comment','1.1.4','User list can be filtered by the group they belong to.','2017-06-30 01:35:33'),
    (371,'RainLab.User','comment','1.1.5','Adds a new permission to hide the User settings menu item.','2017-06-30 01:35:33'),
    (372,'RainLab.User','script','1.2.0','users_add_deleted_at.php','2017-06-30 01:35:33'),
    (373,'RainLab.User','comment','1.2.0','Users can now deactivate their own accounts.','2017-06-30 01:35:33'),
    (374,'RainLab.User','comment','1.2.1','New feature for checking if a user is recently active/online.','2017-06-30 01:35:33'),
    (375,'RainLab.User','comment','1.2.2','Add bulk action button to user list.','2017-06-30 01:35:33'),
    (376,'RainLab.User','comment','1.2.3','Included some descriptive paragraphs in the Reset Password component markup.','2017-06-30 01:35:33'),
    (377,'RainLab.User','comment','1.2.4','Added a checkbox for blocking all mail sent to the user.','2017-06-30 01:35:33'),
    (378,'RainLab.User','script','1.2.5','update_timestamp_nullable.php','2017-06-30 01:35:33'),
    (379,'RainLab.User','comment','1.2.5','Database maintenance. Updated all timestamp columns to be nullable.','2017-06-30 01:35:33'),
    (380,'RainLab.User','script','1.2.6','users_add_last_seen.php','2017-06-30 01:35:33'),
    (381,'RainLab.User','comment','1.2.6','Add a dedicated last seen column for users.','2017-06-30 01:35:33'),
    (382,'RainLab.User','comment','1.2.7','Minor fix to user timestamp attributes.','2017-06-30 01:35:33'),
    (383,'RainLab.User','comment','1.2.8','Add date range filter to users list. Introduced a logout event.','2017-06-30 01:35:33'),
    (384,'RainLab.User','comment','1.2.9','Add invitation mail for new accounts created in the back-end.','2017-06-30 01:35:33'),
    (385,'RainLab.User','script','1.3.0','users_add_guest_flag.php','2017-06-30 01:35:33'),
    (386,'RainLab.User','script','1.3.0','users_add_superuser_flag.php','2017-06-30 01:35:33'),
    (387,'RainLab.User','comment','1.3.0','Introduced guest user accounts.','2017-06-30 01:35:33'),
    (388,'RainLab.User','comment','1.3.1','User notification variables can now be extended.','2017-06-30 01:35:33'),
    (389,'RainLab.User','comment','1.3.2','Minor fix to the Auth::register method.','2017-06-30 01:35:33'),
    (390,'RainLab.User','comment','1.3.3','Allow prevention of concurrent user sessions via the user settings.','2017-06-30 01:35:33'),
    (391,'RainLab.User','comment','1.3.4','Added force secure protocol property to the account component.','2017-06-30 01:35:33'),
    (392,'HareShop.Configurable','script','1.0.1','create_config_product_table.php','2017-06-30 01:35:33'),
    (393,'HareShop.Configurable','script','1.0.1','configurable_seeder.php','2017-06-30 01:35:33'),
    (394,'HareShop.Configurable','comment','1.0.1','Initialize plugin.','2017-06-30 01:35:33'),
    (395,'RainLab.Pages','comment','1.0.1','Implemented the static pages management and the Static Page component.','2017-06-30 01:49:01'),
    (396,'RainLab.Pages','comment','1.0.2','Fixed the page preview URL.','2017-06-30 01:49:01'),
    (397,'RainLab.Pages','comment','1.0.3','Implemented menus.','2017-06-30 01:49:01'),
    (398,'RainLab.Pages','comment','1.0.4','Implemented the content block management and placeholder support.','2017-06-30 01:49:01'),
    (399,'RainLab.Pages','comment','1.0.5','Added support for the Sitemap plugin.','2017-06-30 01:49:01'),
    (400,'RainLab.Pages','comment','1.0.6','Minor updates to the internal API.','2017-06-30 01:49:01'),
    (401,'RainLab.Pages','comment','1.0.7','Added the Snippets feature.','2017-06-30 01:49:01'),
    (402,'RainLab.Pages','comment','1.0.8','Minor improvements to the code.','2017-06-30 01:49:01'),
    (403,'RainLab.Pages','comment','1.0.9','Fixes issue where Snippet tab is missing from the Partials form.','2017-06-30 01:49:01'),
    (404,'RainLab.Pages','comment','1.0.10','Add translations for various locales.','2017-06-30 01:49:01'),
    (405,'RainLab.Pages','comment','1.0.11','Fixes issue where placeholders tabs were missing from Page form.','2017-06-30 01:49:01'),
    (406,'RainLab.Pages','comment','1.0.12','Implement Media Manager support.','2017-06-30 01:49:01'),
    (407,'RainLab.Pages','script','1.1.0','snippets_rename_viewbag_properties.php','2017-06-30 01:49:02'),
    (408,'RainLab.Pages','comment','1.1.0','Adds meta title and description to pages. Adds |staticPage filter.','2017-06-30 01:49:02'),
    (409,'RainLab.Pages','comment','1.1.1','Add support for Syntax Fields.','2017-06-30 01:49:02'),
    (410,'RainLab.Pages','comment','1.1.2','Static Breadcrumbs component now respects the hide from navigation setting.','2017-06-30 01:49:02'),
    (411,'RainLab.Pages','comment','1.1.3','Minor back-end styling fix.','2017-06-30 01:49:02'),
    (412,'RainLab.Pages','comment','1.1.4','Minor fix to the StaticPage component API.','2017-06-30 01:49:02'),
    (413,'RainLab.Pages','comment','1.1.5','Fixes bug when using syntax fields.','2017-06-30 01:49:02'),
    (414,'RainLab.Pages','comment','1.1.6','Minor styling fix to the back-end UI.','2017-06-30 01:49:02'),
    (415,'RainLab.Pages','comment','1.1.7','Improved menu item form to include CSS class, open in a new window and hidden flag.','2017-06-30 01:49:02'),
    (416,'RainLab.Pages','comment','1.1.8','Improved the output of snippet partials when saved.','2017-06-30 01:49:02'),
    (417,'RainLab.Pages','comment','1.1.9','Minor update to snippet inspector internal API.','2017-06-30 01:49:02'),
    (418,'RainLab.Pages','comment','1.1.10','Fixes a bug where selecting a layout causes permanent unsaved changes.','2017-06-30 01:49:02'),
    (419,'RainLab.Pages','comment','1.1.11','Add support for repeater syntax field.','2017-06-30 01:49:02'),
    (420,'RainLab.Pages','comment','1.2.0','Added support for translations, UI updates.','2017-06-30 01:49:02'),
    (421,'RainLab.Pages','comment','1.2.1','Use nice titles when listing the content files.','2017-06-30 01:49:02'),
    (422,'RainLab.Pages','comment','1.2.2','Minor styling update.','2017-06-30 01:49:02'),
    (423,'RainLab.Pages','comment','1.2.3','Snippets can now be moved by dragging them.','2017-06-30 01:49:02'),
    (424,'RainLab.Pages','comment','1.2.4','Fixes a bug where the cursor is misplaced when editing text files.','2017-06-30 01:49:02'),
    (425,'RainLab.Pages','comment','1.2.5','Fixes a bug where the parent page is lost upon changing a page layout.','2017-06-30 01:49:02'),
    (426,'RainLab.Pages','comment','1.2.6','Shared view variables are now passed to static pages.','2017-06-30 01:49:02'),
    (427,'RainLab.Pages','comment','1.2.7','Fixes issue with duplicating properties when adding multiple snippets on the same page.','2017-06-30 01:49:02'),
    (428,'RainLab.Pages','comment','1.2.8','Fixes a bug where creating a content block without extension doesn\'t save the contents to file.','2017-06-30 01:49:02'),
    (429,'RainLab.Pages','comment','1.2.9','Add conditional support for translating page URLs.','2017-06-30 01:49:02'),
    (430,'RainLab.Pages','comment','1.2.10','Streamline generation of URLs to use the new Cms::url helper.','2017-06-30 01:49:02'),
    (431,'RainLab.Pages','comment','1.2.11','Implements repeater usage with translate plugin.','2017-06-30 01:49:02'),
    (432,'RainLab.Pages','comment','1.2.12','Fixes minor issue when using snippets and switching the application locale.','2017-06-30 01:49:02'),
    (433,'RainLab.Pages','comment','1.2.13','Fixes bug when AJAX is used on a page that does not yet exist.','2017-06-30 01:49:02'),
    (434,'RainLab.Pages','comment','1.2.14','Add theme logging support for changes made to menus.','2017-06-30 01:49:02'),
    (435,'RainLab.Pages','comment','1.2.15','Back-end navigation sort order updated.','2017-06-30 01:49:02'),
    (436,'RainLab.Pages','comment','1.2.16','Fixes a bug when saving a template that has been modified outside of the CMS (mtime mismatch).','2017-06-30 01:49:02'),
    (437,'Vannut.Donate','comment','1.0.1','Initial Commit','2017-07-04 02:39:27'),
    (438,'Vannut.Donate','script','1.0.2','create_tables.php','2017-07-04 02:39:27'),
    (439,'Vannut.Donate','comment','1.0.2','created Basic Tables','2017-07-04 02:39:27'),
    (440,'Alexis.Watermark','comment','1.0.1','Initialize plugin.','2017-07-05 23:57:00'),
    (441,'Alexis.Watermark','comment','1.0.2','Implement settings','2017-07-05 23:57:00'),
    (442,'Alexis.Watermark','comment','1.0.3','Bug fixes','2017-07-05 23:57:00'),
    (443,'Viral.ShopReviews','script','1.0.0','create_viral_shopreviews_orders_slugs.php','2017-07-07 00:10:14'),
    (444,'Viral.ShopReviews','script','1.0.0','create_viral_shopreviews_products_ratings.php','2017-07-07 00:10:14'),
    (445,'Viral.ShopReviews','script','1.0.0','create_viral_shopreviews_reviews_table.php','2017-07-07 00:10:14'),
    (446,'Viral.ShopReviews','comment','1.0.0','First version of ProductReviews','2017-07-07 00:10:14'),
    (447,'Feegleweb.Octoshop','script','1.0.0','create_categories_table.php','2017-07-07 00:10:44'),
    (448,'Feegleweb.Octoshop','script','1.0.0','create_products_table.php','2017-07-07 00:10:44'),
    (449,'Feegleweb.Octoshop','script','1.0.0','create_prod_cat_table.php','2017-07-07 00:10:44'),
    (450,'Feegleweb.Octoshop','script','1.0.0','create_orders_table.php','2017-07-07 00:10:44'),
    (451,'Feegleweb.Octoshop','comment','1.0.0','First release','2017-07-07 00:10:44'),
    (452,'Feegleweb.Octoshop','comment','1.0.1','Strict mode fixes','2017-07-07 00:10:44'),
    (453,'Feegleweb.Octoshop','comment','1.0.2','Add backend list filters','2017-07-07 00:10:44'),
    (454,'Feegleweb.Octoshop','comment','1.1.0','October release candidate support','2017-07-07 00:10:44'),
    (455,'Feegleweb.Octoshop','comment','1.1.1','Fix unavailable products in category counts and adjust schema','2017-07-07 00:10:44'),
    (456,'Feegleweb.Octoshop','script','1.1.2','change_category_description.php','2017-07-07 00:10:44'),
    (457,'Feegleweb.Octoshop','comment','1.1.2','Revert original migration files and add new ones','2017-07-07 00:10:44'),
    (458,'Feegleweb.Octoshop','comment','1.1.3','Update default category item partial to show new product count','2017-07-07 00:10:44'),
    (459,'Feegleweb.Octoshop','comment','1.1.4','Fix issues where only one product image would show in lists','2017-07-07 00:10:44'),
    (460,'Feegleweb.Octoshop','script','1.2.0','rename_title_on_categories_table.php','2017-07-07 00:10:44'),
    (461,'Feegleweb.Octoshop','script','1.2.0','add_enabled_and_visible_to_categories_table.php','2017-07-07 00:10:44'),
    (462,'Feegleweb.Octoshop','script','1.2.0','add_parent_id_to_categories_table.php','2017-07-07 00:10:44'),
    (463,'Feegleweb.Octoshop','comment','1.2.0','Major category overhaul with support for subcategories','2017-07-07 00:10:44'),
    (464,'Feegleweb.Octoshop','comment','1.2.1','Fix new root categories added as subcategory of first one','2017-07-07 00:10:44'),
    (465,'Feegleweb.Octoshop','script','1.2.2','make_order_fields_nullable.php','2017-07-07 00:10:44'),
    (466,'Feegleweb.Octoshop','comment','1.2.2','Various fixes for components, Stripe and backend Orders','2017-07-07 00:10:44'),
    (467,'Feegleweb.Octoshop','comment','1.2.3','Fix class name in previous update\'s order migration','2017-07-07 00:10:44'),
    (468,'Feegleweb.Octoshop','comment','1.2.4','Late coding is bad for the brain. Fixes the down migration.','2017-07-07 00:10:44'),
    (469,'Feegleweb.Octoshop','comment','1.2.5','Update dependencies to avoid breaking media manager','2017-07-07 00:10:44'),
    (470,'Feegleweb.Octoshop','script','1.3.0','move_stripe_settings.php','2017-07-07 00:10:44'),
    (471,'Feegleweb.Octoshop','script','1.3.0','add_default_settings.php','2017-07-07 00:10:45'),
    (472,'Feegleweb.Octoshop','script','1.3.0','rename_products_enabled_field.php','2017-07-07 00:10:45'),
    (473,'Feegleweb.Octoshop','comment','1.3.0','Introduce some 2.x features early and fix subcategory issues','2017-07-07 00:10:45'),
    (474,'Feegleweb.Octoshop','comment','1.3.1','Fixed \"No results found\" in basket component\'s checkout page dropdown','2017-07-07 00:10:45'),
    (475,'Feegleweb.Octoshop','comment','1.3.2','Forked cart repo to remove illuminate/support dependency','2017-07-07 00:10:45'),
    (476,'Feegleweb.Octoshop','comment','1.3.3','Fixed editing new categories immediately after saving','2017-07-07 00:10:45'),
    (477,'Feegleweb.Octoshop','comment','1.3.4','Fixed available product filter and other minor issues','2017-07-07 00:10:45'),
    (478,'Feegleweb.Octoshop','comment','1.3.5','Made categories sortable in backend','2017-07-07 00:10:45'),
    (479,'Feegleweb.Octoshop','comment','1.3.6','Fixes potential issue with component variables not getting set','2017-07-07 00:10:45'),
    (480,'Feegleweb.Octoshop','script','1.3.7','cleanup_lite_version.php','2017-07-07 00:10:45'),
    (481,'Feegleweb.Octoshop','comment','1.3.7','Fix some edge-case issues and improve upgrade experience','2017-07-07 00:10:45'),
    (482,'Feegleweb.Octoshop','script','1.3.8','change_product_price.php','2017-07-07 00:10:45'),
    (483,'Feegleweb.Octoshop','comment','1.3.8','Fix some minor currency issues','2017-07-07 00:10:45'),
    (484,'Feegleweb.Octoshop','comment','1.3.9','Fix minor typo','2017-07-07 00:10:45'),
    (485,'Feegleweb.Octoshop','comment','1.3.10','Fix thousands separator not being applied in currency helper','2017-07-07 00:10:45'),
    (486,'Feegleweb.Octoshop','comment','1.3.11','Make basket data (items/count/total) available directly','2017-07-07 00:10:45'),
    (487,'Feegleweb.Octoshop','comment','1.3.12','Patch bug introduced in 1.3.11','2017-07-07 00:10:45'),
    (488,'Feegleweb.Octoshop','comment','1.3.13','Fix bug that sometimes prevents customer mails being sent','2017-07-07 00:10:45'),
    (489,'Feegleweb.Octoshop','comment','1.3.14','Fix subcategory bug and typo in default product partial','2017-07-07 00:10:45'),
    (490,'Feegleweb.Octoshop','comment','1.3.15','Enable setting URL for products in the basket','2017-07-07 00:10:45'),
    (491,'Feegleweb.Octoshop','comment','1.3.16','Fix issue displaying products with many categories when column is enabled in backend','2017-07-07 00:10:45'),
    (492,'Feegleweb.Octoshop','comment','1.3.17','Fix issue with Collection class that only affects PHP5.6','2017-07-07 00:10:45'),
    (493,'Feegleweb.Octoshop','comment','1.3.18','Enable hooking into checkout to add special basket rows','2017-07-07 00:10:45'),
    (494,'Feegleweb.Octoshop','script','1.3.19','oc_stable_timestamp_fix.php','2017-07-07 00:10:45'),
    (495,'Feegleweb.Octoshop','comment','1.3.19','Update for October Stable release','2017-07-07 00:10:45'),
    (496,'Feegleweb.Octoshop','comment','1.3.20','Security tweak to help prevent malicious uploads','2017-07-07 00:10:45'),
    (497,'Marin.SteamAuth','comment','1.0.1','First version of SteamAuth','2017-07-07 00:16:08'),
    (498,'Taema.Youtubegallery','script','1.0.1','create_videos_table.php','2017-07-11 23:56:53'),
    (499,'Taema.Youtubegallery','script','1.0.1','create_playlists_table.php','2017-07-11 23:56:53'),
    (500,'Taema.Youtubegallery','script','1.0.1','create_playlist_video_table.php','2017-07-11 23:56:53'),
    (501,'Taema.Youtubegallery','comment','1.0.1','First version of youtubegallery','2017-07-11 23:56:53'),
    (502,'Gouzi.Video','comment','1.0.1','First version of Video','2017-07-19 00:04:27'),
    (503,'Gouzi.Video','script','1.0.2','create_gouzi_video_codes_table.php','2017-07-19 00:04:27'),
    (504,'Gouzi.Video','comment','1.0.2','Created table create_gouzi_video_codes_table','2017-07-19 00:04:27'),
    (505,'Gouzi.Video','script','1.0.3','create_gouzi_video_director_images_table.php','2017-07-19 00:04:27'),
    (506,'Gouzi.Video','comment','1.0.3','Created table create_gouzi_video_director_images_table','2017-07-19 00:04:27'),
    (507,'Gouzi.Video','script','1.0.4','create_gouzi_video_director_translations_table.php','2017-07-19 00:04:27'),
    (508,'Gouzi.Video','comment','1.0.4','Created table create_gouzi_video_director_translations_table','2017-07-19 00:04:27'),
    (509,'Gouzi.Video','script','1.0.5','create_gouzi_video_directors_table.php','2017-07-19 00:04:27'),
    (510,'Gouzi.Video','comment','1.0.5','Created table create_gouzi_video_directors_table','2017-07-19 00:04:27'),
    (511,'Gouzi.Video','script','1.0.6','create_gouzi_video_downloads_table.php','2017-07-19 00:04:27'),
    (512,'Gouzi.Video','comment','1.0.6','Created table create_gouzi_video_downloads_table','2017-07-19 00:04:27'),
    (513,'Gouzi.Video','script','1.0.7','create_gouzi_video_persons_table.php','2017-07-19 00:04:27'),
    (514,'Gouzi.Video','comment','1.0.7','Created table create_gouzi_video_persons_table','2017-07-19 00:04:27'),
    (515,'Gouzi.Video','script','1.0.8','create_gouzi_video_person_translations_table.php','2017-07-19 00:04:27'),
    (516,'Gouzi.Video','comment','1.0.8','Created table create_gouzi_video_person_translations_table','2017-07-19 00:04:27'),
    (517,'Gouzi.Video','script','1.0.9','create_gouzi_video_person_images_table.php','2017-07-19 00:04:27'),
    (518,'Gouzi.Video','comment','1.0.9','Created table create_gouzi_video_person_images_table','2017-07-19 00:04:27'),
    (519,'Gouzi.Video','script','1.0.10','create_gouzi_video_platform_images_table.php','2017-07-19 00:04:27'),
    (520,'Gouzi.Video','comment','1.0.10','Created table create_gouzi_video_platform_images_table','2017-07-19 00:04:27'),
    (521,'Gouzi.Video','script','1.0.11','create_gouzi_video_platform_translations_table.php','2017-07-19 00:04:27'),
    (522,'Gouzi.Video','comment','1.0.11','Created table create_gouzi_video_platform_translations_table','2017-07-19 00:04:27'),
    (523,'Gouzi.Video','script','1.0.12','create_gouzi_video_platforms_table.php','2017-07-19 00:04:27'),
    (524,'Gouzi.Video','comment','1.0.12','Created table create_gouzi_video_platforms_table','2017-07-19 00:04:27'),
    (525,'Gouzi.Video','script','1.0.13','create_gouzi_video_qualities_table.php','2017-07-19 00:04:27'),
    (526,'Gouzi.Video','comment','1.0.13','Created table create_gouzi_video_qualities_table','2017-07-19 00:04:27'),
    (527,'Gouzi.Video','script','1.0.14','create_gouzi_video_quality_images_table.php','2017-07-19 00:04:27'),
    (528,'Gouzi.Video','comment','1.0.14','Created table create_gouzi_video_quality_images_table','2017-07-19 00:04:27'),
    (529,'Gouzi.Video','script','1.0.15','create_gouzi_video_quality_translations_table.php','2017-07-19 00:04:27'),
    (530,'Gouzi.Video','comment','1.0.15','Created table create_gouzi_video_quality_translations_table','2017-07-19 00:04:27'),
    (531,'Gouzi.Video','script','1.0.16','create_gouzi_video_series_table.php','2017-07-19 00:04:27'),
    (532,'Gouzi.Video','comment','1.0.16','Created table create_gouzi_video_series_table','2017-07-19 00:04:27'),
    (533,'Gouzi.Video','script','1.0.17','create_gouzi_video_serie_translations_table.php','2017-07-19 00:04:27'),
    (534,'Gouzi.Video','comment','1.0.17','Created table create_gouzi_video_serie_translations_table','2017-07-19 00:04:27'),
    (535,'Gouzi.Video','script','1.0.18','create_gouzi_video_serie_translation_images_table.php','2017-07-19 00:04:27'),
    (536,'Gouzi.Video','comment','1.0.18','Created table create_gouzi_video_serie_translation_images_table','2017-07-19 00:04:27'),
    (537,'Gouzi.Video','script','1.0.19','create_gouzi_video_seasons_table.php','2017-07-19 00:04:27'),
    (538,'Gouzi.Video','comment','1.0.19','Created table create_gouzi_video_seasons_table','2017-07-19 00:04:27'),
    (539,'Gouzi.Video','script','1.0.20','create_gouzi_video_season_translations_table.php','2017-07-19 00:04:27'),
    (540,'Gouzi.Video','comment','1.0.20','Created table create_gouzi_video_season_translations_table','2017-07-19 00:04:27'),
    (541,'Gouzi.Video','script','1.0.21','create_gouzi_video_season_translation_images_table.php','2017-07-19 00:04:27'),
    (542,'Gouzi.Video','comment','1.0.21','Created table create_gouzi_video_season_translation_images_table','2017-07-19 00:04:27'),
    (543,'Gouzi.Video','script','1.0.22','create_gouzi_video_video_translation_images_table.php','2017-07-19 00:04:27'),
    (544,'Gouzi.Video','comment','1.0.22','Created table create_gouzi_video_video_translation_images_table','2017-07-19 00:04:27'),
    (545,'Gouzi.Video','script','1.0.23','create_gouzi_video_video_translations_table.php','2017-07-19 00:04:27'),
    (546,'Gouzi.Video','comment','1.0.23','Created table create_gouzi_video_video_translations_table','2017-07-19 00:04:27'),
    (547,'Gouzi.Video','script','1.0.24','create_gouzi_video_videos_countries.php','2017-07-19 00:04:27'),
    (548,'Gouzi.Video','comment','1.0.24','Created table create_gouzi_video_videos_countries','2017-07-19 00:04:27'),
    (549,'Gouzi.Video','script','1.0.25','create_gouzi_video_videos_directors.php','2017-07-19 00:04:27'),
    (550,'Gouzi.Video','comment','1.0.25','Created table create_gouzi_video_videos_directors','2017-07-19 00:04:27'),
    (551,'Gouzi.Video','script','1.0.26','create_gouzi_video_videos_persons.php','2017-07-19 00:04:27'),
    (552,'Gouzi.Video','comment','1.0.26','Created table create_gouzi_video_videos_persons','2017-07-19 00:04:27'),
    (553,'Gouzi.Video','script','1.0.27','create_gouzi_video_videos_table.php','2017-07-19 00:04:27'),
    (554,'Gouzi.Video','comment','1.0.27','Created table create_gouzi_video_videos_table','2017-07-19 00:04:27'),
    (555,'Gouzi.Video','script','1.0.28','create_gouzi_video_videos_taxons.php','2017-07-19 00:04:27'),
    (556,'Gouzi.Video','comment','1.0.28','Created table create_gouzi_video_videos_taxons','2017-07-19 00:04:27'),
    (557,'Gouzi.Video','script','1.0.29','create_gouzi_taxonomy_taxon_movie_images_table.php','2017-07-19 00:04:27'),
    (558,'Gouzi.Video','comment','1.0.29','Created table create_gouzi_taxonomy_taxon_movie_images_table','2017-07-19 00:04:27'),
    (559,'Gouzi.Video','script','1.0.30','create_gouzi_taxonomy_taxon_movie_translations_table.php','2017-07-19 00:04:27'),
    (560,'Gouzi.Video','comment','1.0.30','Created table create_gouzi_taxonomy_taxon_movie_translations_table','2017-07-19 00:04:27'),
    (561,'Gouzi.Video','script','1.0.31','create_gouzi_taxonomy_taxon_movies_table.php','2017-07-19 00:04:27'),
    (562,'Gouzi.Video','comment','1.0.31','Created table create_gouzi_taxonomy_taxon_movies_table','2017-07-19 00:04:27'),
    (563,'Gouzi.Video','script','1.0.32','create_gouzi_taxonomy_taxonomy_movie_images_table.php','2017-07-19 00:04:27'),
    (564,'Gouzi.Video','comment','1.0.32','Created table create_gouzi_taxonomy_taxonomy_movie_images_table','2017-07-19 00:04:27'),
    (565,'Gouzi.Video','script','1.0.33','create_gouzi_taxonomy_taxonomy_movie_translations_table.php','2017-07-19 00:04:27'),
    (566,'Gouzi.Video','comment','1.0.33','Created table create_gouzi_taxonomy_taxonomy_movie_translations_table','2017-07-19 00:04:27'),
    (567,'Gouzi.Video','script','1.0.34','create_gouzi_taxonomy_taxonomy_movies_table.php','2017-07-19 00:04:27'),
    (568,'Gouzi.Video','comment','1.0.34','Created table create_gouzi_taxonomy_taxonomy_movies_table','2017-07-19 00:04:27'),
    (569,'Gouzi.Video','script','1.0.35','create_gouzi_video_video_movies_table.php','2017-07-19 00:04:27'),
    (570,'Gouzi.Video','comment','1.0.35','Created table create_gouzi_video_video_movies_table','2017-07-19 00:04:27'),
    (571,'Gouzi.Video','script','1.0.36','create_gouzi_video_video_movie_translations_table.php','2017-07-19 00:04:27'),
    (572,'Gouzi.Video','comment','1.0.36','Created table create_gouzi_video_video_movie_translations_table','2017-07-19 00:04:27'),
    (573,'Gouzi.Video','script','1.0.37','create_gouzi_video_video_movie_translation_images_table.php','2017-07-19 00:04:27'),
    (574,'Gouzi.Video','comment','1.0.37','Created table create_gouzi_video_video_movie_translation_images_table','2017-07-19 00:04:27'),
    (575,'Gouzi.Video','script','1.0.38','create_gouzi_video_video_movies_countries.php','2017-07-19 00:04:27'),
    (576,'Gouzi.Video','comment','1.0.38','Created table create_gouzi_video_video_movies_countries','2017-07-19 00:04:27'),
    (577,'Gouzi.Video','script','1.0.39','create_gouzi_video_video_movies_directors.php','2017-07-19 00:04:27'),
    (578,'Gouzi.Video','comment','1.0.39','Created table create_gouzi_video_video_movies_directors','2017-07-19 00:04:27'),
    (579,'Gouzi.Video','script','1.0.40','create_gouzi_video_video_movies_persons.php','2017-07-19 00:04:27'),
    (580,'Gouzi.Video','comment','1.0.40','Created table create_gouzi_video_video_movies_persons','2017-07-19 00:04:27'),
    (581,'Gouzi.Video','script','1.0.41','create_gouzi_video_video_movies_taxon_movies.php','2017-07-19 00:04:27'),
    (582,'Gouzi.Video','comment','1.0.41','Created table create_gouzi_video_video_movies_taxon_movies','2017-07-19 00:04:27'),
    (583,'Gouzi.Video','script','1.0.42','create_gouzi_video_code_movies_table.php','2017-07-19 00:04:27'),
    (584,'Gouzi.Video','comment','1.0.42','Created table create_gouzi_video_code_movies_table','2017-07-19 00:04:27'),
    (585,'Gouzi.Video','script','1.0.43','create_gouzi_video_download_movies_table.php','2017-07-19 00:04:27'),
    (586,'Gouzi.Video','comment','1.0.43','Created table create_gouzi_video_download_movies_table','2017-07-19 00:04:27'),
    (587,'Gouzi.Video','script','1.0.44','create_gouzi_taxonomy_taxon_serie_images_table.php','2017-07-19 00:04:27'),
    (588,'Gouzi.Video','comment','1.0.44','Created table create_gouzi_taxonomy_taxon_serie_images_table','2017-07-19 00:04:27'),
    (589,'Gouzi.Video','script','1.0.45','create_gouzi_taxonomy_taxon_serie_translations_table.php','2017-07-19 00:04:27'),
    (590,'Gouzi.Video','comment','1.0.45','Created table create_gouzi_taxonomy_taxon_serie_translations_table','2017-07-19 00:04:27'),
    (591,'Gouzi.Video','script','1.0.46','create_gouzi_taxonomy_taxon_series_table.php','2017-07-19 00:04:27'),
    (592,'Gouzi.Video','comment','1.0.46','Created table create_gouzi_taxonomy_taxon_series_table','2017-07-19 00:04:27'),
    (593,'Gouzi.Video','script','1.0.47','create_gouzi_taxonomy_taxonomy_serie_images_table.php','2017-07-19 00:04:27'),
    (594,'Gouzi.Video','comment','1.0.47','Created table create_gouzi_taxonomy_taxonomy_serie_images_table','2017-07-19 00:04:27'),
    (595,'Gouzi.Video','script','1.0.48','create_gouzi_taxonomy_taxonomy_serie_translations_table.php','2017-07-19 00:04:27'),
    (596,'Gouzi.Video','comment','1.0.48','Created table create_gouzi_taxonomy_taxonomy_serie_translations_table','2017-07-19 00:04:27'),
    (597,'Gouzi.Video','script','1.0.49','create_gouzi_taxonomy_taxonomy_series_table.php','2017-07-19 00:04:27'),
    (598,'Gouzi.Video','comment','1.0.49','Created table create_gouzi_taxonomy_taxonomy_series_table','2017-07-19 00:04:27'),
    (599,'Gouzi.Video','script','1.0.50','create_gouzi_video_code_series_table.php','2017-07-19 00:04:27'),
    (600,'Gouzi.Video','comment','1.0.50','Created table create_gouzi_video_code_series_table','2017-07-19 00:04:27'),
    (601,'Gouzi.Video','script','1.0.51','create_gouzi_video_download_series_table.php','2017-07-19 00:04:27'),
    (602,'Gouzi.Video','comment','1.0.51','Created table create_gouzi_video_download_series_table','2017-07-19 00:04:27'),
    (603,'Gouzi.Video','script','1.0.52','create_gouzi_video_video_series_table.php','2017-07-19 00:04:27'),
    (604,'Gouzi.Video','comment','1.0.52','Created table create_gouzi_video_video_series_table','2017-07-19 00:04:27'),
    (605,'Gouzi.Video','script','1.0.53','create_gouzi_video_video_serie_translations_table.php','2017-07-19 00:04:27'),
    (606,'Gouzi.Video','comment','1.0.53','Created table create_gouzi_video_video_serie_translations_table','2017-07-19 00:04:27'),
    (607,'Gouzi.Video','script','1.0.54','create_gouzi_video_video_serie_translation_images_table.php','2017-07-19 00:04:27'),
    (608,'Gouzi.Video','comment','1.0.54','Created table create_gouzi_video_video_serie_translation_images_table','2017-07-19 00:04:27'),
    (609,'Gouzi.Video','script','1.0.55','create_gouzi_video_video_serie_images_table.php','2017-07-19 00:04:27'),
    (610,'Gouzi.Video','comment','1.0.55','Created table create_gouzi_video_video_serie_images_table','2017-07-19 00:04:27'),
    (611,'Gouzi.Video','script','1.0.56','create_gouzi_video_video_series_countries.php','2017-07-19 00:04:27'),
    (612,'Gouzi.Video','comment','1.0.56','Created table create_gouzi_video_video_series_countries','2017-07-19 00:04:27'),
    (613,'Gouzi.Video','script','1.0.57','create_gouzi_video_video_series_directors.php','2017-07-19 00:04:27'),
    (614,'Gouzi.Video','comment','1.0.57','Created table create_gouzi_video_video_series_directors','2017-07-19 00:04:27'),
    (615,'Gouzi.Video','script','1.0.58','create_gouzi_video_video_series_persons.php','2017-07-19 00:04:27'),
    (616,'Gouzi.Video','comment','1.0.58','Created table create_gouzi_video_video_series_persons','2017-07-19 00:04:27'),
    (617,'Gouzi.Video','script','1.0.59','create_gouzi_video_video_series_taxon_series.php','2017-07-19 00:04:27'),
    (618,'Gouzi.Video','comment','1.0.59','Created table create_gouzi_video_video_series_taxon_series','2017-07-19 00:04:27'),
    (619,'Gouzi.Video','script','1.0.60','create_gouzi_comment_comment_video_movies_table.php','2017-07-19 00:04:27'),
    (620,'Gouzi.Video','comment','1.0.60','Created table create_gouzi_comment_comment_video_movies_table','2017-07-19 00:04:27'),
    (621,'Gouzi.Video','script','1.0.61','create_gouzi_comment_comment_video_series_table.php','2017-07-19 00:04:27'),
    (622,'Gouzi.Video','comment','1.0.61','Created table create_gouzi_comment_comment_video_series_table','2017-07-19 00:04:27'),
    (623,'Gouzi.Video','script','1.0.62','create_gouzi_comment_thread_video_movies_table.php','2017-07-19 00:04:27'),
    (624,'Gouzi.Video','comment','1.0.62','Created table create_gouzi_comment_thread_video_movies_table','2017-07-19 00:04:27'),
    (625,'Gouzi.Video','script','1.0.63','create_gouzi_comment_thread_video_series_table.php','2017-07-19 00:04:27'),
    (626,'Gouzi.Video','comment','1.0.63','Created table create_gouzi_comment_thread_video_series_table','2017-07-19 00:04:27'),
    (627,'Gouzi.Video','script','1.0.64','create_gouzi_rate_rate_video_movies_table.php','2017-07-19 00:04:27'),
    (628,'Gouzi.Video','comment','1.0.64','Created table create_gouzi_rate_rate_video_movies_table','2017-07-19 00:04:27'),
    (629,'Gouzi.Video','script','1.0.65','create_gouzi_rate_rate_video_series_table.php','2017-07-19 00:04:27'),
    (630,'Gouzi.Video','comment','1.0.65','Created table create_gouzi_rate_rate_video_series_table','2017-07-19 00:04:27'),
    (631,'Gouzi.Video','script','1.0.66','create_gouzi_rate_vote_video_movies_table.php','2017-07-19 00:04:27'),
    (632,'Gouzi.Video','comment','1.0.66','Created table create_gouzi_rate_vote_video_movies_table','2017-07-19 00:04:27'),
    (633,'Gouzi.Video','script','1.0.67','create_gouzi_rate_vote_video_series_table.php','2017-07-19 00:04:27'),
    (634,'Gouzi.Video','comment','1.0.67','Created table create_gouzi_rate_vote_video_series_table','2017-07-19 00:04:27'),
    (635,'Gouzi.Video','script','1.0.68','create_gouzi_video_series_taxon_series.php','2017-07-19 00:04:27'),
    (636,'Gouzi.Video','comment','1.0.68','Created table create_gouzi_video_series_taxon_series','2017-07-19 00:04:27'),
    (637,'Gouzi.Video','script','1.0.69','create_gouzi_video_series_countries.php','2017-07-19 00:04:27'),
    (638,'Gouzi.Video','comment','1.0.69','Created table create_gouzi_video_series_countries','2017-07-19 00:04:27'),
    (639,'Gouzi.Video','script','1.0.70','create_gouzi_video_series_directors.php','2017-07-19 00:04:27'),
    (640,'Gouzi.Video','comment','1.0.70','Created table create_gouzi_video_series_directors','2017-07-19 00:04:27'),
    (641,'Gouzi.Video','script','1.0.71','create_gouzi_video_series_persons.php','2017-07-19 00:04:27'),
    (642,'Gouzi.Video','comment','1.0.71','Created table create_gouzi_video_series_persons','2017-07-19 00:04:27'),
    (643,'Gouzi.Video','script','1.0.72','create_gouzi_video_video_movies_crews.php','2017-07-19 00:04:27'),
    (644,'Gouzi.Video','comment','1.0.72','Created table create_gouzi_video_video_movies_crews','2017-07-19 00:04:27'),
    (645,'Gouzi.Video','script','1.0.73','create_gouzi_video_video_movie_production_companies.php','2017-07-19 00:04:27'),
    (646,'Gouzi.Video','comment','1.0.73','Created table create_gouzi_video_video_movie_production_companies','2017-07-19 00:04:27'),
    (647,'Gouzi.Video','script','1.0.74','create_gouzi_video_video_movie_spoken_languages.php','2017-07-19 00:04:27'),
    (648,'Gouzi.Video','comment','1.0.74','Created table create_gouzi_video_video_movie_spoken_languages','2017-07-19 00:04:27'),
    (649,'Gouzi.Video','script','1.0.75','create_gouzi_video_series_languages.php','2017-07-19 00:04:27'),
    (650,'Gouzi.Video','comment','1.0.75','Created table create_gouzi_video_series_languages','2017-07-19 00:04:27'),
    (651,'Gouzi.Video','script','1.0.76','create_gouzi_video_series_production_companies.php','2017-07-19 00:04:28'),
    (652,'Gouzi.Video','comment','1.0.76','Created table create_gouzi_video_series_production_companies','2017-07-19 00:04:28'),
    (653,'Gouzi.Video','script','1.0.77','create_gouzi_video_series_networks.php','2017-07-19 00:04:28'),
    (654,'Gouzi.Video','comment','1.0.77','Created table create_gouzi_video_series_networks','2017-07-19 00:04:28'),
    (655,'Gouzi.Video','script','1.0.78','create_gouzi_video_series_crews.php','2017-07-19 00:04:28'),
    (656,'Gouzi.Video','comment','1.0.78','Created table create_gouzi_video_series_crews','2017-07-19 00:04:28'),
    (657,'Gouzi.Video','script','1.0.79','create_gouzi_video_seasons_persons.php','2017-07-19 00:04:28'),
    (658,'Gouzi.Video','comment','1.0.79','Created table create_gouzi_video_seasons_persons','2017-07-19 00:04:28'),
    (659,'Gouzi.Video','script','1.0.80','create_gouzi_video_seasons_crews.php','2017-07-19 00:04:28'),
    (660,'Gouzi.Video','comment','1.0.80','Created table create_gouzi_video_seasons_crews','2017-07-19 00:04:28'),
    (661,'Gouzi.Video','script','1.0.81','create_gouzi_video_video_series_crews.php','2017-07-19 00:04:28'),
    (662,'Gouzi.Video','comment','1.0.81','Created table create_gouzi_video_video_series_crews','2017-07-19 00:04:28'),
    (663,'Gouzi.Video','script','1.0.82','create_gouzi_video_video_series_guests.php','2017-07-19 00:04:28'),
    (664,'Gouzi.Video','comment','1.0.82','Created table create_gouzi_video_video_series_guests','2017-07-19 00:04:28'),
    (665,'Mavitm.Estate','comment','1.0.1','Initialize plugin.','2017-08-09 02:07:06'),
    (666,'Mavitm.Estate','script','1.0.2','builder_table_create_mavitm_estate_realty.php','2017-08-09 02:07:06'),
    (667,'Mavitm.Estate','comment','1.0.2','Created table mavitm_estate_realty','2017-08-09 02:07:06'),
    (668,'Mavitm.Estate','script','1.0.3','builder_table_create_mavitm_estate_tags.php','2017-08-09 02:07:06'),
    (669,'Mavitm.Estate','comment','1.0.3','Created table mavitm_estate_tags','2017-08-09 02:07:06'),
    (670,'Mavitm.Estate','script','1.0.4','builder_table_create_mavitm_estate_categories.php','2017-08-09 02:07:06'),
    (671,'Mavitm.Estate','comment','1.0.4','Created table mavitm_estate_categories','2017-08-09 02:07:06'),
    (672,'Mavitm.Estate','script','1.0.5','builder_table_create_mavitm_estate_realty_tag.php','2017-08-09 02:07:06'),
    (673,'Mavitm.Estate','comment','1.0.5','Created table mavitm_estate_realty_tag','2017-08-09 02:07:06'),
    (674,'Mavitm.Estate','script','1.0.6','builder_table_create_mavitm_estate_realty_properties.php','2017-08-09 02:07:06'),
    (675,'Mavitm.Estate','comment','1.0.6','Created table mavitm_estate_realty_properties','2017-08-09 02:07:06'),
    (676,'RainLab.Translate','script','1.0.1','create_messages_table.php','2017-08-09 02:07:06'),
    (677,'RainLab.Translate','script','1.0.1','create_attributes_table.php','2017-08-09 02:07:06'),
    (678,'RainLab.Translate','script','1.0.1','create_locales_table.php','2017-08-09 02:07:07'),
    (679,'RainLab.Translate','script','1.0.1','seed_all_tables.php','2017-08-09 02:07:07'),
    (680,'RainLab.Translate','comment','1.0.1','First version of Translate','2017-08-09 02:07:07'),
    (681,'RainLab.Translate','comment','1.0.2','Languages and Messages can now be deleted.','2017-08-09 02:07:07'),
    (682,'RainLab.Translate','comment','1.0.3','Minor updates for latest October release.','2017-08-09 02:07:07'),
    (683,'RainLab.Translate','comment','1.0.4','Locale cache will clear when updating a language.','2017-08-09 02:07:07'),
    (684,'RainLab.Translate','comment','1.0.5','Add Spanish language and fix plugin config.','2017-08-09 02:07:07'),
    (685,'RainLab.Translate','comment','1.0.6','Minor improvements to the code.','2017-08-09 02:07:07'),
    (686,'RainLab.Translate','comment','1.0.7','Fixes major bug where translations are skipped entirely!','2017-08-09 02:07:07'),
    (687,'RainLab.Translate','comment','1.0.8','Minor bug fixes.','2017-08-09 02:07:07'),
    (688,'RainLab.Translate','comment','1.0.9','Fixes an issue where newly created models lose their translated values.','2017-08-09 02:07:07'),
    (689,'RainLab.Translate','comment','1.0.10','Minor fix for latest build.','2017-08-09 02:07:07'),
    (690,'RainLab.Translate','comment','1.0.11','Fix multilingual rich editor when used in stretch mode.','2017-08-09 02:07:07'),
    (691,'RainLab.Translate','comment','1.1.0','Introduce compatibility with RainLab.Pages plugin.','2017-08-09 02:07:07'),
    (692,'RainLab.Translate','comment','1.1.1','Minor UI fix to the language picker.','2017-08-09 02:07:07'),
    (693,'RainLab.Translate','comment','1.1.2','Add support for translating Static Content files.','2017-08-09 02:07:07'),
    (694,'RainLab.Translate','comment','1.1.3','Improved support for the multilingual rich editor.','2017-08-09 02:07:07'),
    (695,'RainLab.Translate','comment','1.1.4','Adds new multilingual markdown editor.','2017-08-09 02:07:07'),
    (696,'RainLab.Translate','comment','1.1.5','Minor update to the multilingual control API.','2017-08-09 02:07:07'),
    (697,'RainLab.Translate','comment','1.1.6','Minor improvements in the message editor.','2017-08-09 02:07:07'),
    (698,'RainLab.Translate','comment','1.1.7','Fixes bug not showing content when first loading multilingual textarea controls.','2017-08-09 02:07:07'),
    (699,'RainLab.Translate','comment','1.2.0','CMS pages now support translating the URL.','2017-08-09 02:07:07'),
    (700,'RainLab.Translate','comment','1.2.1','Minor update in the rich editor and code editor language control position.','2017-08-09 02:07:07'),
    (701,'RainLab.Translate','comment','1.2.2','Static Pages now support translating the URL.','2017-08-09 02:07:07'),
    (702,'RainLab.Translate','comment','1.2.3','Fixes Rich Editor when inserting a page link.','2017-08-09 02:07:07'),
    (703,'RainLab.Translate','script','1.2.4','create_indexes_table.php','2017-08-09 02:07:07'),
    (704,'RainLab.Translate','comment','1.2.4','Translatable attributes can now be declared as indexes.','2017-08-09 02:07:07'),
    (705,'RainLab.Translate','comment','1.2.5','Adds new multilingual repeater form widget.','2017-08-09 02:07:07'),
    (706,'RainLab.Translate','comment','1.2.6','Fixes repeater usage with static pages plugin.','2017-08-09 02:07:07'),
    (707,'RainLab.Translate','comment','1.2.7','Fixes placeholder usage with static pages plugin.','2017-08-09 02:07:07'),
    (708,'Raideer.Thumbnail','comment','1.0.1','First version of raideer.thumbnail','2017-08-09 02:31:43'),
    (709,'Ksoft.Links','script','1.0.1','create_categories_table.php','2017-08-09 02:47:47'),
    (710,'Ksoft.Links','comment','1.0.1','Create Categories Table','2017-08-09 02:47:47'),
    (711,'Ksoft.Links','script','1.0.2','create_items_table.php','2017-08-09 02:47:47'),
    (712,'Ksoft.Links','comment','1.0.2','Create Link Items','2017-08-09 02:47:47'),
    (713,'Ksoft.Links','script','1.0.3','builder_table_update_ksoft_links_categories.php','2017-08-09 02:47:47'),
    (714,'Ksoft.Links','comment','1.0.3','Updated table ksoft_links_categories','2017-08-09 02:47:47'),
    (715,'VojtaSvoboda.ErrorLogger','comment','1.0.1','First version of Error Logger with Mailer handler, Slack handler and Syslog handler.','2017-08-09 02:50:56'),
    (716,'VojtaSvoboda.ErrorLogger','comment','1.0.2','Manage plugin permissions','2017-08-09 02:50:56'),
    (717,'VojtaSvoboda.ErrorLogger','comment','1.0.3','Add New Relic handler','2017-08-09 02:50:56'),
    (718,'VojtaSvoboda.ErrorLogger','comment','1.0.4','Add RU locale (thanks to Alexander Romanov)','2017-08-09 02:50:56'),
    (719,'VojtaSvoboda.ErrorLogger','comment','1.0.5','Add DE locale (thanks to Tobias Kündig)','2017-08-09 02:50:56'),
    (720,'VojtaSvoboda.ErrorLogger','comment','1.0.6','Add ES locale (thanks to Salvador Pasquier)','2017-08-09 02:50:56'),
    (721,'Maercky.Rollbar','comment','1.0.1','Rollbar integration with Vojta Svoboda\'s Error Logger','2017-08-09 02:50:56'),
    (722,'JetMinds.Job','script','1.0.1','create_resumes_table.php','2017-08-17 22:49:22'),
    (723,'JetMinds.Job','script','1.0.1','create_vacancies_table.php','2017-08-17 22:49:22'),
    (724,'JetMinds.Job','comment','1.0.1','Initialize Job','2017-08-17 22:49:22'),
    (725,'Klyp.PageBuilder','comment','1.0.1','First version of PageBuilder','2017-08-22 23:28:01'),
    (726,'ToughDeveloper.ImageResizer','comment','1.0.1','First version of ImageResizer','2017-08-24 00:06:53'),
    (727,'ToughDeveloper.ImageResizer','comment','1.0.2','Fixes bug where url set in config/app.php affecting rendering of image.','2017-08-24 00:06:53'),
    (728,'ToughDeveloper.ImageResizer','comment','1.0.3','Adds Hungarian translation - thanks to Szabó Gergő','2017-08-24 00:06:53'),
    (729,'ToughDeveloper.ImageResizer','comment','1.1.0','Adds default settings to admin - thanks to Szabó Gergő','2017-08-24 00:06:53'),
    (730,'ToughDeveloper.ImageResizer','comment','1.2.0','Adds optional PNG compression support via Tiny PNG','2017-08-24 00:06:53'),
    (731,'ToughDeveloper.ImageResizer','comment','1.2.1','Updates translations and allows jpg files to be compressed with Tiny PNG','2017-08-24 00:06:53'),
    (732,'ToughDeveloper.ImageResizer','comment','1.2.2','Ensures false can be passed to auto width/height. Also improves URL parsing so different formats of app.url work as expected. Thanks to Emerge.','2017-08-24 00:06:53'),
    (733,'ToughDeveloper.ImageResizer','comment','1.3.0','Adds TinyPNG API key validation, TinyPNG usage statistics and provides thumb backend list column type','2017-08-24 00:06:53'),
    (734,'ToughDeveloper.ImageResizer','comment','1.3.1','Ensures plugin works as expected when October is installed to a sub-directory.','2017-08-24 00:06:53'),
    (735,'ToughDeveloper.ImageResizer','comment','1.3.2','Adds option to skip compression of certain images, helpful to save credits.','2017-08-24 00:06:53'),
    (736,'ToughDeveloper.ImageResizer','comment','1.3.3','Updates Hungarian translations - thanks to Szabó Gergő','2017-08-24 00:06:53'),
    (737,'ToughDeveloper.ImageResizer','comment','1.3.4','Adds German translation - thanks to Christoph (emptynick)','2017-08-24 00:06:53'),
    (738,'ToughDeveloper.PropertyManagement','script','1.0.1','create_properties_table.php','2017-08-24 00:06:53'),
    (739,'ToughDeveloper.PropertyManagement','script','1.0.1','create_areas_table.php','2017-08-24 00:06:53'),
    (740,'ToughDeveloper.PropertyManagement','script','1.0.1','create_categories_table.php','2017-08-24 00:06:53'),
    (741,'ToughDeveloper.PropertyManagement','script','1.0.1','create_enquiries_table.php','2017-08-24 00:06:53'),
    (742,'ToughDeveloper.PropertyManagement','script','1.0.1','create_user_property_table.php','2017-08-24 00:06:53'),
    (743,'ToughDeveloper.PropertyManagement','comment','1.0.1','First version of Property Management','2017-08-24 00:06:53'),
    (744,'Samuell.ContentEditor','comment','1.0.1','First version of ContentEditor','2017-09-06 00:12:46'),
    (745,'Samuell.ContentEditor','comment','1.0.2','Support for translate plugin','2017-09-06 00:12:46'),
    (746,'Samuell.ContentEditor','script','1.0.3','Autocreate file if not exists','2017-09-06 00:12:46'),
    (747,'Samuell.ContentEditor','script','1.0.3','Get actual component name to request','2017-09-06 00:12:46'),
    (748,'Samuell.ContentEditor','script','1.0.3','Settings in backend','2017-09-06 00:12:46'),
    (749,'Samuell.ContentEditor','comment','1.0.3','Image upload to MediaLibrary','2017-09-06 00:12:46'),
    (750,'Samuell.ContentEditor','script','1.0.4','Fixed some bugs','2017-09-06 00:12:46'),
    (751,'Samuell.ContentEditor','comment','1.0.4','Enabled taglist input for selecting tags','2017-09-06 00:12:46'),
    (752,'Samuell.ContentEditor','script','1.0.5','Added tools property','2017-09-06 00:12:46'),
    (753,'Samuell.ContentEditor','script','1.0.5','Added Slovak translation','2017-09-06 00:12:46'),
    (754,'Samuell.ContentEditor','comment','1.0.5','Added fixture property','2017-09-06 00:12:46'),
    (755,'Samuell.ContentEditor','comment','1.0.6','Fix for autocreating files for translation','2017-09-06 00:12:46'),
    (756,'Samuell.ContentEditor','script','1.0.7','Added compatibility with StaticPages','2017-09-06 00:12:46'),
    (757,'Samuell.ContentEditor','script','1.0.7','Enhanced fixture compatibility via data-ce-tag','2017-09-06 00:12:46'),
    (758,'Samuell.ContentEditor','script','1.0.7','Updated ContentEditor to 1.3.2','2017-09-06 00:12:46'),
    (759,'Samuell.ContentEditor','script','1.0.7','Fix empty content file, repeating styles, subdirectory urls, polluting next instances','2017-09-06 00:12:46'),
    (760,'Samuell.ContentEditor','comment','1.0.7','Added additional styles','2017-09-06 00:12:46'),
    (761,'KurtJensen.Passage','script','1.0.1','create_tables.php','2017-09-06 00:12:46'),
    (762,'KurtJensen.Passage','comment','1.0.1','Initialize plugin.','2017-09-06 00:12:46'),
    (763,'KurtJensen.Passage','comment','1.0.2','Added replacement twig tag for hasRole() called inGroup(). This checks to see if user belongs to RainLab\\User\\Models\\UserGroup.','2017-09-06 00:12:46'),
    (764,'KurtJensen.Passage','comment','1.0.3','Fixed error caused by inGroup($group) on non-logged in user.','2017-09-06 00:12:46'),
    (765,'KurtJensen.Passage','comment','1.0.4','Added messageURL() to enable Author Notices','2017-09-06 00:12:46'),
    (766,'KurtJensen.Passage','comment','1.0.5','!!! This is an important update that contains breaking changes. Changed inGroup to use code instead of name and added methods.','2017-09-06 00:12:46'),
    (767,'KurtJensen.Passage','comment','1.0.6','Fixes error at plugin.php line 152','2017-09-06 00:12:46'),
    (768,'KurtJensen.Passage','comment','1.0.7','Fixes dumb mistake at plugin.php line 150 and caches groups better','2017-09-06 00:12:46'),
    (769,'KurtJensen.Passage','comment','1.0.8','Added model UsersGroups (from Rainlab) to make easier to get users of a permission key','2017-09-06 00:12:46'),
    (770,'KurtJensen.Passage','comment','1.0.9','Prevents unactivated users from having any permissions','2017-09-06 00:12:46'),
    (771,'KurtJensen.Passage','comment','1.0.10','Fixed nullpointer when no user is logged in ( Thanks jhendess )','2017-09-06 00:12:46'),
    (772,'Wizkidweb.ContentEditorPassageExtension','comment','1.0.1','First version of ContentEditorPassageExtension','2017-09-06 00:12:46'),
    (773,'Raccoon.GeoLocation','script','1.0.1','create_ip_info_locations_table.php','2017-09-07 00:50:23'),
    (774,'Raccoon.GeoLocation','comment','1.0.1','First version of GeoLocation','2017-09-07 00:50:23'),
    (775,'Shajid.Videoplayer','comment','1.0.1','Initialize plugin.','2017-09-12 00:13:42'),
    (776,'Shajid.Videoplayer','script','1.0.2','builder_table_create_shajid_videoplayer_.php','2017-09-12 00:13:42'),
    (777,'Shajid.Videoplayer','comment','1.0.2','Created table shajid_videoplayer_','2017-09-12 00:13:42'),
    (778,'JanVince.SmallRecords','script','1.0.0','sr_tables.php','2017-09-13 00:05:44'),
    (779,'JanVince.SmallRecords','comment','1.0.0','Initial version','2017-09-13 00:05:44'),
    (780,'Inetis.CloudwaysDeploy','script','1.0.1','generate_token.php','2017-09-13 23:17:55'),
    (781,'Inetis.CloudwaysDeploy','comment','1.0.1','First version of CloudwaysDeploy','2017-09-13 23:17:55'),
    (782,'Initbiz.Selenium2tests','comment','1.0.1','Initialize plugin.','2017-09-21 00:33:56'),
    (783,'Initbiz.Selenium2tests','comment','1.0.2','Beta, some features might not work, but hey, you can contribute :)','2017-09-21 00:33:56'),
    (784,'Axmit.Storage','comment','1.0.1','First version of Storage','2017-09-29 22:28:04'),
    (785,'Axmit.Storage','script','1.1.0','create_cms_content_table.php','2017-09-29 22:28:04'),
    (786,'Axmit.Storage','comment','1.1.0','CMS content DB table created','2017-09-29 22:28:04'),
    (787,'Inetis.ListSwitch','comment','1.0.1','First version of listSwitch','2017-10-03 22:41:52'),
    (788,'Inetis.ListSwitch','script','1.0.2','Add Hungarian translation','2017-10-03 22:41:52'),
    (789,'Inetis.ListSwitch','comment','1.0.2','Display correctly the column label','2017-10-03 22:41:52'),
    (790,'Stefan.Gallery','comment','1.0.1','Initialize plugin.','2017-10-03 22:41:52'),
    (791,'Stefan.Gallery','script','1.0.2','builder_table_create_stefan_gallery_galleries.php','2017-10-03 22:41:52'),
    (792,'Stefan.Gallery','comment','1.0.2','Created table stefan_gallery_galleries','2017-10-03 22:41:52'),
    (793,'Stefan.Gallery','script','1.0.3','builder_table_create_stefan_gallery_tags.php','2017-10-03 22:41:52'),
    (794,'Stefan.Gallery','comment','1.0.3','Created table stefan_gallery_tags','2017-10-03 22:41:52'),
    (795,'Stefan.Gallery','script','1.0.4','migration104.php','2017-10-03 22:41:52'),
    (796,'Stefan.Gallery','comment','1.0.4','Add column tags to system_files','2017-10-03 22:41:52'),
    (797,'Stefan.Gallery','script','1.0.5','builder_table_update_stefan_gallery_galleries.php','2017-10-03 22:41:52'),
    (798,'Stefan.Gallery','comment','1.0.5','Updated table stefan_gallery_galleries','2017-10-03 22:41:52'),
    (799,'OFFLINE.Cashier','script','1.0.1','install_cashier_tables.php','2017-10-11 00:32:54'),
    (800,'OFFLINE.Cashier','comment','1.0.1','Initial release','2017-10-11 00:32:54'),
    (801,'RainLab.Translate','comment','1.2.8','Improvements to code for latest October build compatibility.','2017-10-11 00:35:50'),
    (802,'RainLab.Translate','comment','1.2.9','Fixes context for translated strings when used with Static Pages.','2017-10-11 00:35:50'),
    (803,'RainLab.Translate','comment','1.2.10','Minor UI fix to the multilingual repeater.','2017-10-11 00:35:50'),
    (804,'RainLab.Translate','comment','1.2.11','Fixes translation not working with partials loaded via AJAX','2017-10-11 00:35:50');

/*!40000 ALTER TABLE `system_plugin_history` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table system_plugin_versions
# ------------------------------------------------------------

CREATE TABLE `system_plugin_versions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `version` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_frozen` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `system_plugin_versions_code_index` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `system_plugin_versions` WRITE;
/*!40000 ALTER TABLE `system_plugin_versions` DISABLE KEYS */;

INSERT INTO `system_plugin_versions` (`id`, `code`, `version`, `created_at`, `is_disabled`, `is_frozen`)
VALUES
    (1,'October.Demo','1.0.1','2017-06-20 23:47:43',0,0),
    (9,'RainLab.User','1.3.4','2017-06-30 01:35:33',0,0),
    (11,'RainLab.Pages','1.2.16','2017-06-30 01:49:02',0,0),
    (20,'RainLab.Translate','1.2.11','2017-10-11 00:35:50',0,0),
    (40,'OFFLINE.Cashier','1.0.1','2017-10-11 00:32:54',0,0);

/*!40000 ALTER TABLE `system_plugin_versions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table system_request_logs
# ------------------------------------------------------------

CREATE TABLE `system_request_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status_code` int(11) DEFAULT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `referer` text COLLATE utf8_unicode_ci,
  `count` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table system_revisions
# ------------------------------------------------------------

CREATE TABLE `system_revisions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `field` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cast` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `old_value` text COLLATE utf8_unicode_ci,
  `new_value` text COLLATE utf8_unicode_ci,
  `revisionable_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `revisionable_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `system_revisions_revisionable_id_revisionable_type_index` (`revisionable_id`,`revisionable_type`),
  KEY `system_revisions_user_id_index` (`user_id`),
  KEY `system_revisions_field_index` (`field`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table system_settings
# ------------------------------------------------------------

CREATE TABLE `system_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` mediumtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `system_settings_item_index` (`item`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table taema_youtubegallery_playlist_video
# ------------------------------------------------------------

CREATE TABLE `taema_youtubegallery_playlist_video` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `playlist_id` int(10) unsigned NOT NULL,
  `video_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table taema_youtubegallery_playlists
# ------------------------------------------------------------

CREATE TABLE `taema_youtubegallery_playlists` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table taema_youtubegallery_videos
# ------------------------------------------------------------

CREATE TABLE `taema_youtubegallery_videos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `yt_watch` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `published` tinyint(1) NOT NULL,
  `order` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table toughdeveloper_properties
# ------------------------------------------------------------

CREATE TABLE `toughdeveloper_properties` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `address_line_one` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `address_line_two` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `address_line_three` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `area_id` int(11) NOT NULL,
  `postcode` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  `bedrooms` int(10) unsigned DEFAULT NULL,
  `bathrooms` int(10) unsigned DEFAULT NULL,
  `reception_rooms` int(10) unsigned DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cost` decimal(11,2) NOT NULL,
  `cost_label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `is_for_sale` tinyint(1) NOT NULL DEFAULT '0',
  `is_for_rental` tinyint(1) NOT NULL DEFAULT '0',
  `is_featured` tinyint(1) NOT NULL,
  `is_live` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table toughdeveloper_properties_areas
# ------------------------------------------------------------

CREATE TABLE `toughdeveloper_properties_areas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `toughdeveloper_properties_areas_parent_id_index` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table toughdeveloper_properties_categories
# ------------------------------------------------------------

CREATE TABLE `toughdeveloper_properties_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table toughdeveloper_properties_property_categories
# ------------------------------------------------------------

CREATE TABLE `toughdeveloper_properties_property_categories` (
  `property_id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`property_id`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table toughdeveloper_property_enquiries
# ------------------------------------------------------------

CREATE TABLE `toughdeveloper_property_enquiries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `property_id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `telephone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `message` text COLLATE utf8_unicode_ci,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `toughdeveloper_property_enquiries_property_id_index` (`property_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table toughdeveloper_user_properties
# ------------------------------------------------------------

CREATE TABLE `toughdeveloper_user_properties` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `property_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `toughdeveloper_user_properties_user_id_index` (`user_id`),
  KEY `toughdeveloper_user_properties_property_id_index` (`property_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table user_groups
# ------------------------------------------------------------

CREATE TABLE `user_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_groups_code_index` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `user_groups` WRITE;
/*!40000 ALTER TABLE `user_groups` DISABLE KEYS */;

INSERT INTO `user_groups` (`id`, `name`, `code`, `description`, `created_at`, `updated_at`)
VALUES
    (1,'Guest','guest','Default group for guest users.','2017-06-30 01:35:33','2017-06-30 01:35:33'),
    (2,'Registered','registered','Default group for registered users.','2017-06-30 01:35:33','2017-06-30 01:35:33');

/*!40000 ALTER TABLE `user_groups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user_throttle
# ------------------------------------------------------------

CREATE TABLE `user_throttle` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `ip_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attempts` int(11) NOT NULL DEFAULT '0',
  `last_attempt_at` timestamp NULL DEFAULT NULL,
  `is_suspended` tinyint(1) NOT NULL DEFAULT '0',
  `suspended_at` timestamp NULL DEFAULT NULL,
  `is_banned` tinyint(1) NOT NULL DEFAULT '0',
  `banned_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_throttle_user_id_index` (`user_id`),
  KEY `user_throttle_ip_address_index` (`ip_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table users
# ------------------------------------------------------------

CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `activation_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `persist_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `permissions` text COLLATE utf8_unicode_ci,
  `is_activated` tinyint(1) NOT NULL DEFAULT '0',
  `activated_at` timestamp NULL DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `surname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `last_seen` timestamp NULL DEFAULT NULL,
  `is_guest` tinyint(1) NOT NULL DEFAULT '0',
  `is_superuser` tinyint(1) NOT NULL DEFAULT '0',
  `offline_cashier_stripe_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `offline_cashier_card_brand` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `offline_cashier_card_last_four` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `offline_cashier_trial_ends_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_login_unique` (`username`),
  KEY `users_activation_code_index` (`activation_code`),
  KEY `users_reset_password_code_index` (`reset_password_code`),
  KEY `users_login_index` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table users_groups
# ------------------------------------------------------------

CREATE TABLE `users_groups` (
  `user_id` int(10) unsigned NOT NULL,
  `user_group_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`user_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table vannut_donation
# ------------------------------------------------------------

CREATE TABLE `vannut_donation` (
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `trid` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table vannut_donation_status
# ------------------------------------------------------------

CREATE TABLE `vannut_donation_status` (
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `trid` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table viral_shopreviews_orders_slugs
# ------------------------------------------------------------

CREATE TABLE `viral_shopreviews_orders_slugs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `order_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `viral_shopreviews_orders_slugs_slug_unique` (`slug`),
  UNIQUE KEY `viral_shopreviews_orders_slugs_ou_key` (`order_id`,`order_type`),
  KEY `viral_shopreviews_orders_slugs_order_id_index` (`order_id`),
  KEY `viral_shopreviews_orders_slugs_order_type_index` (`order_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table viral_shopreviews_products_ratings
# ------------------------------------------------------------

CREATE TABLE `viral_shopreviews_products_ratings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `product_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rating` double(5,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `viral_shopreviews_products_ratings_pu_key` (`product_id`,`product_type`),
  KEY `viral_shopreviews_products_ratings_product_id_index` (`product_id`),
  KEY `viral_shopreviews_products_ratings_product_type_index` (`product_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table viral_shopreviews_reviews
# ------------------------------------------------------------

CREATE TABLE `viral_shopreviews_reviews` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `is_purchase_verified` tinyint(1) NOT NULL DEFAULT '0',
  `product_id` int(10) unsigned NOT NULL,
  `product_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `order_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `user_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rating` double(5,2) DEFAULT NULL,
  `comment` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `viral_shopreviews_reviews_product_id_index` (`product_id`),
  KEY `viral_shopreviews_reviews_product_type_index` (`product_type`),
  KEY `viral_shopreviews_reviews_order_id_index` (`order_id`),
  KEY `viral_shopreviews_reviews_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
