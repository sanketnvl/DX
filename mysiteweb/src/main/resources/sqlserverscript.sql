CREATE TABLE document (
  id int IDENTITY(1,1),
  user_id int NOT NULL,
  envelopeid varchar(255) DEFAULT NULL,
  name varchar(250) NOT NULL,
  original varbinary(Max) ,
  electronic varbinary(Max) ,
  digital varbinary (Max),
  status tinyint NOT NULL,
  file_type char(1) DEFAULT NULL,
  subject varchar(255) DEFAULT NULL,
  message text,
  sign_type char(1) DEFAULT NULL,
  upload_date datetime DEFAULT NULL,
  complete_date datetime DEFAULT NULL,
  PRIMARY KEY (id)
) ;

CREATE TABLE document_sign_email (
  id int IDENTITY(1,1),
  signer_id int DEFAULT NULL,
  document_id int DEFAULT NULL,
  priority int DEFAULT NULL,
  sent_email_count int DEFAULT NULL,
  token varchar(255) DEFAULT NULL,
  status tinyint NOT NULL,
  created_date datetime NOT NULL,
  PRIMARY KEY (id)
) ;

CREATE TABLE document_sign_field (
  id int IDENTITY(1,1),
  signer_id int DEFAULT NULL,
  document_id int DEFAULT NULL,
  page_number int DEFAULT NULL,
  priority int DEFAULT NULL,
  position_left varchar(50) DEFAULT NULL,
  position_top varchar(50) DEFAULT NULL,
  height varchar(50) DEFAULT NULL,
  width varchar(50) DEFAULT NULL,
  field_value varchar(max),
  field_name varchar(50) DEFAULT NULL,
  field_type varchar(50) DEFAULT NULL,
  created_date datetime NOT NULL,
  PRIMARY KEY (id)
) ;


CREATE TABLE signature (
  id int IDENTITY(1,1),
  user_id int ,
  signature_data VARCHAR(MAX),
  created_date datetime,
  PRIMARY KEY (id)
) ;


CREATE TABLE signer (
  id int IDENTITY(1,1),
  name varchar(250) NOT NULL,
  email varchar(250) NOT NULL,
  user_type tinyint NOT NULL ,
  status tinyint NOT NULL,
  created_on datetime,
  updated_on datetime ,
  PRIMARY KEY (id)
) ;



CREATE TABLE token_details (
  id int IDENTITY(1,1),
  user_id int NOT NULL,
  token varchar(250) NOT NULL,
  status tinyint NOT NULL,
  valid_from datetime NOT NULL,
  valid_to datetime NOT NULL,
  PRIMARY KEY (id)
) ;

CREATE TABLE users (
  id int IDENTITY(1,1),
  firstname varchar(250) NOT NULL,
  lastname varchar(255) DEFAULT NULL,
  photo varchar(255) DEFAULT NULL,
  email varchar(250) NOT NULL,
  phone varchar(250) DEFAULT NULL,
  country varchar(250) DEFAULT NULL,
  state varchar(250) DEFAULT NULL,
  pincode varchar(250) DEFAULT NULL,
  password varchar(250) DEFAULT NULL,
  company_name varchar(250) DEFAULT NULL,
  job_title varchar(250) DEFAULT NULL,
  client_id varchar(250) DEFAULT NULL,
  client_secret varchar(250) DEFAULT NULL,
  email_verification_token varchar(250) DEFAULT NULL,
  user_type tinyint NOT NULL,
  status tinyint NOT NULL,
  role varchar(250) DEFAULT NULL,
  is_company varchar(5) DEFAULT 'No',
  created_on datetime NOT NULL,
  updated_on datetime DEFAULT NULL ,
  project_name varchar(50) DEFAULT NULL,
  PRIMARY KEY (id)
) ;

CREATE TABLE user_forgot_password (
  id int IDENTITY(1,1),
  user_id int NOT NULL,
  token varchar(250) DEFAULT NULL,
  status tinyint NOT NULL,
  date datetime NOT NULL,
  PRIMARY KEY (id)
) ;


CREATE TABLE token_details (
  id int NOT NULL IDENTITY(1,1),
  user_id int NOT NULL,
  token varchar(250) NOT NULL,
  status tinyint NOT NULL,
  valid_from datetime NOT NULL,
  valid_to datetime NOT NULL,
  PRIMARY KEY (id)
) ;


ALTER TABLE users
ADD theme varchar(20)

ALTER TABLE users
ADD drysignlink varchar(10)

ALTER TABLE users
ADD deviceversion varchar(10)

ALTER TABLE users ALTER COLUMN firstname varchar(255)  NULL

CREATE TABLE audit (
  id int IDENTITY(1,1),
  userid int FOREIGN KEY REFERENCES users(id),
  ip_address varchar(250) NOT NULL,
  web_request nvarchar(max) NOT NULL ,
  web_response nvarchar(max) NOT NULL,
  method_name varchar(255) NOT NULL,
  status varchar(250) NOT NULL,
  created_on datetime NOT NULL,
  updated_on datetime
  PRIMARY KEY (id)
) ;


/**CRETAE ROLE ADMIN SCRIPT **/
INSERT INTO users(
firstname,
lastname,
email,
phone,
country,
state,
pincode,
email_verification_token,
user_type,
status,
role,
created_on,
password
)
values(
'admin',
'dryadmin',
'admin@drysign.me',
'9819230987',
'India',
'Maharashtra',
'411016',
'78588e7f-80e7-4578-b2ff-2d8fe307c56d',
3,
1,
'ROLE_ADMIN',
getdate(),
'$2a$10$vN8pxQtcU5mCP7Zr1mYlqe/37FmZDZXOMA6qm9n/afo6dO4sXSjnu'
);




ALTER TABLE document
ADD client_ip_address varchar(50)


/*start subscription schema*/

CREATE TABLE subscription_plan (
  plan_id int IDENTITY(1,1),
  currency varchar(50),
  amount varchar(50),
  plan_name varchar(255),
  no_of_days varchar(255) DEFAULT NULL,
  no_of_documents varchar(250) NOT NULL,
  status tinyint NOT NULL,
  content text,
  date datetime DEFAULT NULL,
  PRIMARY KEY (plan_id)
) ;

CREATE TABLE subscription (
  subscription_id int IDENTITY(1,1),
  user_id int,
  plan_id int,
  status tinyint ,
  subscription_start_date datetime DEFAULT NULL,
  subscription_end_date datetime DEFAULT NULL,
  PRIMARY KEY (subscription_id)
) ;

CREATE TABLE purchase (
  purchase_id int IDENTITY(1,1),
  subscription_id int,
  payment_method varchar(250),
  price varchar(250),
  status tinyint,
  date datetime DEFAULT NULL,
  PRIMARY KEY (purchase_id)
) ;

/*end subscription schema*/

