---------------------------------------Assignment DAY1------------------------------------------------

---Creating table categories

CREATE TABLE categories (
	categoryID INTEGER PRIMARY KEY, 
	categoryName VARCHAR(100),
	description VARCHAR(250)	
);

SELECT * FROM categories;

-- PRIMARY KEY on categoryID ensures each category is uniquely identified and prevents duplicates.
-- VARCHAR(100) for categoryName allows flexible text up to 100 characters.
-- VARCHAR(250) for description gives space for detailed info without wasting storage.
----------------------------------------------------------------------------------------------------------
---Creating table employees

CREATE TABLE employees(
	employeeID INTEGER PRIMARY KEY,
	employeeName VARCHAR(100),
	title VARCHAR(100),
	city VARCHAR(100),
	country VARCHAR(100),
	reportsTo INTEGER
);

SELECT * FROM employees;

-- PRIMARY KEY on employeeID ensures each employee is uniquely identified.
-- VARCHAR fields allow flexible storage for name, title, city, and country (up to 100 characters each).
-- reportsTo is an INTEGER used for self-referencing to indicate a reporting manager (employeeID).
-----------------------------------------------------------------------------------------------------------------
----Creating table shippers

CREATE TABLE shippers(
	shipperID INTEGER PRIMARY KEY,
	companyName VARCHAR(100)
);
SELECT * FROM shippers;

-- PRIMARY KEY on shipperID uniquely identifies each shipper.
-- companyName uses VARCHAR(100) to store shipper company names flexibly up to 100 characters.
-----------------------------------------------------------------------------------------------------------------
----Creating table order_details

CREATE TABLE order_details(
	orderID INTEGER,
	productID INTEGER,
	unitPrice NUMERIC,
	quantity INTEGER,
	discount NUMERIC,
	PRIMARY KEY (orderID, productID)
);

SELECT * FROM order_details;

-- Composite PRIMARY KEY (orderID, productID) ensures each product in an order is unique.
-- unitPrice and discount use NUMERIC for accurate currency/decimal values.
-- quantity is INTEGER to represent item count.
--------------------------------------------------------------------------------------------------------------
----Creating table orders

CREATE TABLE orders(
	orderID INTEGER PRIMARY KEY,
	customerID VARCHAR(100),
	employeeID INTEGER,
	orderDate DATE,
	requiredDate DATE,
	shippedDate DATE,
	shipperID INTEGER,
	freight NUMERIC	
);

SELECT * FROM orders ;

-- PRIMARY KEY on orderID uniquely identifies each order.
-- customerID and employeeID link to related tables, stored as VARCHAR and INTEGER.
-- orderDate, requiredDate, and shippedDate use DATE type for accurate date tracking.
-- shipperID references the shipper; freight uses NUMERIC for precise cost values.
----------------------------------------------------------------------------------------------------------
----Creating table customers

CREATE TABLE customers(
	customerID VARCHAR (100) PRIMARY KEY,
	companyName VARCHAR (100),
	contactName VARCHAR (100),
	contactTitle VARCHAR (100),
	city VARCHAR (100),
	country VARCHAR (100)
);

SELECT * FROM customers ;

-- PRIMARY KEY on customerID ensures each customer is uniquely identified.
-- VARCHAR(100) used for company, contact, title, city, and country to store flexible-length text.

-------------------------------------------------------------------------------------------------------------
----Creating table products

CREATE TABLE products(
	productID INTEGER PRIMARY KEY,
	productName VARCHAR (100),
	quantityPerUnit VARCHAR (500),
	unitPrice NUMERIC,
	discontinued BOOLEAN,
	categoryID INTEGER
);
SELECT * FROM products ;

-- PRIMARY KEY on productID uniquely identifies each product.
-- productName and quantityPerUnit use VARCHAR for descriptive text (name & packaging).
-- unitPrice is NUMERIC for accurate pricing, discontinued is BOOLEAN (true/false), categoryID links to categories.

