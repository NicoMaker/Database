*** SQL statements to Create Example Databases & Tables ***

####################################################################################################

* CREATE DATABASE school;
---------------------------------------------------------------------------
* CREATE DATABASE company;
---------------------------------------------------------------------------
* CREATE DATABASE onlineshop;
---------------------------------------------------------------------------
* SHOW DATABASES;

####################################################################################################

* USE school;

---------------------------------------------------------------------------

* Table: students

CREATE TABLE students (
studentid INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
firstname VARCHAR(40) NOT NULL,
lastname VARCHAR(40) NOT NULL,
class VARCHAR(20),
age INT(3)
);

---------------------------------------------------------------------------

* Table: teachers

CREATE TABLE teachers (
teacherid INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(80) NOT NULL,
phone VARCHAR(10)
);

---------------------------------------------------------------------------

* Table: subjects

CREATE TABLE subjects (
subjectid INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(50) NOT NULL
);

---------------------------------------------------------------------------

* SHOW TABLES;

####################################################################################################

* USE company;

---------------------------------------------------------------------------

* Table: employees

CREATE TABLE employees (
employeeid INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(80) NOT NULL,
jobtitle VARCHAR(50) NOT NULL,
salary FLOAT
);

---------------------------------------------------------------------------

* Table: clients

CREATE TABLE clients (
clientid INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(80) NOT NULL,
phone VARCHAR(15),
address VARCHAR(150)
);

---------------------------------------------------------------------------

* Table: projects

CREATE TABLE projects (
projectid INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(200) NOT NULL,
clientid INT,
employeeid INT,
startdate DATETIME,
enddate DATETIME
);

---------------------------------------------------------------------------

* SHOW TABLES;

####################################################################################################

* USE onlineshop;

---------------------------------------------------------------------------

* Table: items

CREATE TABLE items (
itemid INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
categoryid INT,
name VARCHAR(100) NOT NULL,
price FLOAT
);

---------------------------------------------------------------------------

* Table: categories

CREATE TABLE categories (
categoryid INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(50) NOT NULL,
status TINYINT(1) NOT NULL
);

---------------------------------------------------------------------------

* Table: customers

CREATE TABLE customers (
userid INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(80) NOT NULL,
phone VARCHAR(15),
address VARCHAR(150)
);

---------------------------------------------------------------------------

* Table: orders

CREATE TABLE orders (
orderid INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
userid INT,
items TEXT,
total FLOAT,
orderdate DATETIME
);

---------------------------------------------------------------------------

* SHOW TABLES;

####################################################################################################