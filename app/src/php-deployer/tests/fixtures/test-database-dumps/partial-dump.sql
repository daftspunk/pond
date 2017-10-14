/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table backend_access_log
# ------------------------------------------------------------

CREATE TABLE `backend_access_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `ip_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `backend_users` WRITE;
/*!40000 ALTER TABLE `backend_users` DISABLE KEYS */;

INSERT INTO `backend_users` (`id`, `first_name`, `last_name`, `login`, `email`, `password`, `activation_code`, `persist_code`, `reset_password_code`, `permissions`, `is_activated`, `activated_at`, `last_login`, `created_at`, `updated_at`, `is_superuser`)
VALUES
    (1,'Admin','Person','admin','admin@domain.tld','$2y$10$BQ9MkxjwbpCwdM.Yk0mIEO9U.ILoaFMy2C3I.mvJNpUquaOXTWWVy',NULL,'$2y$10$abDX0gUj41Q6zPQLiRI7G.QT.do/PwLOYyIkXF5WOndZQr8p8y8Tm',NULL,'',1,NULL,'2017-10-11 00:49:09','2017-06-20 23:47:43','2017-10-11 00:49:09',1);

/*!40000 ALTER TABLE `backend_users` ENABLE KEYS */;
UNLOCK TABLES;


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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



# Dump of table sessions
# ------------------------------------------------------------

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `payload` text COLLATE utf8_unicode_ci,
  `last_activity` int(11) DEFAULT NULL,
  UNIQUE KEY `sessions_id_unique` (`id`)
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
