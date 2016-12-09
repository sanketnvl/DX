CREATE TABLE `document` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `envelopeid` varchar(255) DEFAULT NULL,
  `name` varchar(250) NOT NULL,
  `original` mediumblob,
  `electronic` mediumblob,
  `digital` mediumblob,
  `status` tinyint(1) NOT NULL COMMENT '''1''=>''complete'',''0''=>''incomplete''',
  `file_type` char(1) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` longtext,
  `sign_type` char(1) DEFAULT NULL COMMENT 'S=>SelfSign, G=>GroupSign',
  `upload_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `complete_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ;



CREATE TABLE `document_sign_email` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `signer_id` int(11) DEFAULT NULL,
  `document_id` int(11) DEFAULT NULL,
  `priority` int(50) DEFAULT NULL,
  `sent_email_count` int(50) DEFAULT NULL,
  `token` varchar(250) DEFAULT NULL,
  `status` tinyint(1) NOT NULL COMMENT '''1''=>''Active'',''0''=>''Inactive''',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ;


CREATE TABLE `document_sign_field` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `signer_id` int(11) DEFAULT NULL,
  `document_id` int(11) DEFAULT NULL,
  `page_number` int(50) DEFAULT NULL,
  `priority` int(50) DEFAULT NULL,
  `position_left` varchar(50) DEFAULT NULL,
  `position_top` varchar(50) DEFAULT NULL,
  `height` varchar(50) DEFAULT NULL,
  `width` varchar(50) DEFAULT NULL,
  `field_value` longtext,
  `field_name` varchar(50) DEFAULT NULL,
  `field_type` varchar(50) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ;


CREATE TABLE `signature` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `signature_data` longtext,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ;

CREATE TABLE `signer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `email` varchar(250) NOT NULL,
  `user_type` tinyint(1) NOT NULL COMMENT '''0''=>''Application Signer'',''1''=>''Application Originator'',''2''=>''Company Admin''',
  `status` tinyint(1) NOT NULL COMMENT '''1''=>''Active'',''0''=>''Inactive''',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ;


CREATE TABLE `token_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `token` varchar(250) NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '''0''=>''Inactive'',''1''=>''Active''',
  `valid_from` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `valid_to` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(250) NOT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `email` varchar(250) NOT NULL,
  `phone` varchar(250) DEFAULT NULL,
  `country` varchar(250) DEFAULT NULL,
  `state` varchar(250) DEFAULT NULL,
  `pincode` varchar(250) DEFAULT NULL,
  `password` varchar(250) DEFAULT NULL,
  `company_name` varchar(250) DEFAULT NULL,
  `job_title` varchar(250) DEFAULT NULL,
  `client_id` varchar(250) DEFAULT NULL,
  `client_secret` varchar(250) DEFAULT NULL,
  `email_verification_token` varchar(250) DEFAULT NULL,
  `user_type` tinyint(1) NOT NULL COMMENT '''0''=>''Application Signer'',''1''=>''Application Originator'',''2''=>''Company Admin''',
  `status` tinyint(1) NOT NULL COMMENT '''1''=>''Active'',''0''=>''Inactive''',
  `role` varchar(250) DEFAULT NULL,
  `is_company` varchar(5) DEFAULT 'No',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `project_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ;


CREATE TABLE `user_forgot_password` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `token` varchar(250) DEFAULT NULL,
  `status` tinyint(1) NOT NULL COMMENT '''1''=>''Active'',''0''=>''Inactive''',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ;



