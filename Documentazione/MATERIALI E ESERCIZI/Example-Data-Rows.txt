*** SQL statements to Insert Example Data Rows ***

####################################################################################################

USE school;

---------------------------------------------------------------------------

INSERT INTO students (firstname, lastname, class, age) VALUES
('John', 'Doe', 'First', 5),
('Mary', 'Smith', 'Third', 7),
('James', 'Brown', 'First', 5),
('Mike', 'Walker', 'Second', 6),
('Linda', 'Jones', 'Third', 7),
('John', 'Doe', 'Third', 7),
('James', 'Smith', 'First', 6),
('John', 'Brown', 'Second', 6),
('Daniel', 'Jones', 'First', 7),
('Paul', 'Anderson', 'Third', 5),
('Mark', 'Davis', 'Second', 6),
('Steven', 'Thomas', 'First', 7),
('Brian', 'King', 'Second', 5),
('Kevin', 'Hall', 'First', 6),
('Jason', 'Lee', 'Third', 5),
('Jose', 'Young', 'First', 6),
('Frank', 'Smith', 'First', 7),
('Eric', 'Jones', 'Second', 7),
('Jerry', 'Martin', 'Third', 5),
('Peter', 'King', 'First', 6),
('Henry', 'Clark', 'Second', 7),
('Carl', 'White', 'Second', 5),
('Joe', 'Thomas', 'First', 7),
('Jack', 'Smith', 'Third', 6),
('Roy', 'King', 'Second', 5),
('Adam', 'Hall', 'First', 6),
('Bobby', 'White', 'Second', 7),
('Johnny', 'Davis', 'First', 6),
('Jimmy', 'Jones', 'Third', 5),
('Emma', 'Walker', 'First', 5),
('Sophia', 'Walker', 'Third', 6),
('Ava', 'Jones', 'First', 7),
('Mia', 'Smith', 'Second', 6),
('Emily', 'Walker', 'Second', 5),
('Grace', 'King', 'First', 5),
('Lillian', 'Jones', 'Third', 7),
('Lily', 'King', 'Third', 6),
('Layla', 'Young', 'First', 5),
('Zoe', 'Thomas', 'Second', 7),
('Anna', 'Jones', 'Second', 5),
('Leah', 'Brown', 'Third', 6),
('Camila', 'Hall', 'First', 5),
('Riley', 'Martin', 'Third', 6),
('Nora', 'Smith', 'Second', 7),
('Hailey', 'Clark', 'Second', 7),
('Ellie', 'King', 'Third', 5),
('Lucy', 'Jones', 'Third', 6),
('Stella', 'White', 'First', 5),
('Bella', 'White', 'Second', 7),
('Mila', 'Smith', 'Third', 6),
('Maya', 'Brown', 'First', 5),
('Faith', 'Thomas', 'Third', 5),
('Eva', 'Brown', 'Second', 7),
('Julia', 'King', 'Third', 6),
('Ashley', 'Davis', 'First', 5),
('Ruby', 'Young', 'Third', 7),
('Alice', 'Jones', 'Second', 6),
('Jasmine', 'Hall', 'Third', 7);

---------------------------------------------------------------------------

SELECT * FROM students;

---------------------------------------------------------------------------

INSERT INTO teachers (name, phone) VALUES
('John Doe', '1234567890'),
('Caroline Smith', '0987654321'),
('Jason King', '1234512345'),
('Stella Brown', '0987612345'),
('Eric Hall', '0987609876');

SELECT * FROM teachers;

---------------------------------------------------------------------------

INSERT INTO subjects (title) VALUES ('English'), ('Mathematics'), ('Science'), ('Computer'), ('History'), ('Geography');

---------------------------------------------------------------------------

SELECT * FROM subjects;
 
####################################################################################################

USE company;

---------------------------------------------------------------------------

INSERT INTO employees (name, jobtitle, salary) VALUES
('John Doe', 'Web Developer', 3500.00),
('Mary Smith', 'Web Developer', 3500.00),
('James Brown', 'Web Developer', 3500.00),
('Mike Walker', 'Web Developer', 3500.00),
('Linda Jones', 'Web Developer', 3500.00),
('John Doe', 'Systems Administrator', 3400.00),
('James Smith', 'Systems Administrator', 3400.00),
('John Brown', 'Systems Administrator', 3400.00),
('Daniel Jones', 'Systems Administrator', 3400.00),
('Paul Anderson', 'Systems Administrator', 3400.00),
('Mark Davis', 'IT Support Manager', 3200.00),
('Steven Thomas', 'IT Support Manager', 3200.00),
('Brian King', 'IT Support Manager', 3200.00),
('Kevin Hall', 'IT Support Manager', 3200.00),
('Jason Lee', 'IT Support Manager', 3200.00),
('Jose Young', 'Database Administrator', 3700.00),
('Frank Smith', 'Database Administrator', 3700.00),
('Eric Jones', 'Database Administrator', 3700.00),
('Jerry Martin', 'Database Administrator', 3700.00),
('Peter King', 'Database Administrator', 3700.00),
('Henry Clark', 'Application Developer', 3800.00),
('Carl White', 'Application Developer', 3800.00),
('Joe Thomas', 'Application Developer', 3800.00),
('Jack Smith', 'Application Developer', 3800.00),
('Roy King', 'Application Developer', 3800.00);

---------------------------------------------------------------------------

SELECT * FROM employees;

---------------------------------------------------------------------------

INSERT INTO clients (name, phone, address) VALUES
('Jimmy Jones', '1234567890', 'Victoria Pavilion, Las Vegas, NV'),
('Henry Clark', '0987654321', '4125 Sydney Place, Miami, FL'),
('Ruby Young', '1234512345', '6170 Peshwar Place, Washington, DC'),
('Julia King', '0987612345', 'MountainView Hospital, Victoria, TX');

---------------------------------------------------------------------------

SELECT * FROM clients;

---------------------------------------------------------------------------

INSERT INTO projects ( title, clientid, employeeid, startdate, enddate) VALUES 
('Develop ecommerse website from scratch', 1, 3, NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY)),
('WordPress website for our company', 1, 2, NOW(), DATE_ADD(NOW(), INTERVAL 45 DAY)),
('Manage our company servers', 2, 7, NOW(), DATE_ADD(NOW(), INTERVAL 45 DAY)),
('Hosting account is not working', 3, 9, NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY)),
('MySQL database from my desktop application', 4, 17, NOW(), DATE_ADD(NOW(), INTERVAL 15 DAY)),
('Develop new WordPress plugin for my business website', 2, NULL, NOW(), DATE_ADD(NOW(), INTERVAL 10 DAY)),
('Migrate web application and database to new server', 2, NULL, NOW(), DATE_ADD(NOW(), INTERVAL 5 DAY)),
('Android Application development', 4, 23, NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY));

---------------------------------------------------------------------------

SELECT * FROM projects;

---------------------------------------------------------------------------

####################################################################################################

USE onlineshop;

---------------------------------------------------------------------------

INSERT INTO categories (title, status) VALUES ('Electronics', 1), ('Books', 1), ('Cloths', 1);

---------------------------------------------------------------------------

SELECT * FROM categories;

---------------------------------------------------------------------------

INSERT INTO items (categoryid, name, price) VALUES
(1, 'Android Mobile Phone', 250.00),
(1, 'i7 processor, 8GB RAM Laptop', 1000.00),
(2, 'How to train your cat', 25.00),
(2, 'Healthy dog food recipes', 19.00),
(2, 'Learn how to meditate for mental health', 30.00),
(3, 'Beautiful Black T-Shirts', 99.00),
(3, 'Blue Colored Jeans', 150.00);

---------------------------------------------------------------------------

SELECT * FROM items;

---------------------------------------------------------------------------

INSERT INTO customers (name, phone, address) VALUES
('Jimmy Jones', '1234567890', 'Victoria Pavilion, Las Vegas, NV'),
('Henry Clark', '0987654321', '4125 Sydney Place, Miami, FL'),
('Ruby Young', '1234512345', '6170 Peshwar Place, Washington, DC'),
('Julia King', '0987612345', 'MountainView Hospital, Victoria, TX'),
('Anna Jones', '0987609876', '1234 Obere Street, Miami, FL');

---------------------------------------------------------------------------

SELECT * FROM customers;

---------------------------------------------------------------------------

INSERT INTO orders (userid, items, total, orderdate) VALUES
(2, 'i7 processor, 8GB RAM Laptop', 1000.00, NOW()),
(1, 'Healthy dog food recipes', 19.00, NOW()),
(25, 'Healthy dog food recipes', 19.00, NOW()),
(1, 'How to train your cat', 25.00, NOW()),
(3, 'Blue Colored Jeans', 150.00, NOW()),
(15, 'Beautiful Black T-Shirts', 99.00, NOW()),
(4, 'Beautiful Black T-Shirts', 99.00, NOW());

---------------------------------------------------------------------------

SELECT * FROM orders;

---------------------------------------------------------------------------