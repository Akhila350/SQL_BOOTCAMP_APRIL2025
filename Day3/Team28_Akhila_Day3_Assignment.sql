------------------------------------------Assignment Day 3--------------------------------------------
---1)Update the categoryName From “Beverages” to "Drinks" in the categories table.

UPDATE categories
SET categoryName = 'Drinks'
WHERE categoryName = 'Beverages';

SELECT *
FROM categories
WHERE categoryName = 'Drinks';
---------------------------------------------------------------------------------------------------------
----2)Insert into shipper new record (give any values) Delete that new record from shippers table.

SELECT * FROM shippers;

INSERT INTO shippers (shipperID, companyName)
VALUES (4, 'Garudavega');

DELETE FROM shippers
WHERE shipperID = 4;

-----------------------------------------------------------------------------------------------------------
----3)Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too.
/*Display the both category and products table to show the cascade*/

ALTER TABLE products
DROP CONSTRAINT IF EXISTS products_pkey;

-- Add new foreign key with CASCADE options
ALTER TABLE products
ADD CONSTRAINT products_category_id_fkey
FOREIGN KEY (categoryID)
REFERENCES categories(categoryID)
ON UPDATE CASCADE
ON DELETE CASCADE;

UPDATE categories
SET categoryID=1001 
WHERE categoryID=1;

SELECT * 
FROM products;

SELECT * 
FROM categories;

DELETE FROM categories
WHERE categoryID = 3;

-- Confirm category is deleted
SELECT * FROM categories WHERE category_id = 3;

-- Confirm related products are also deleted
SELECT * FROM products WHERE category_id = 3;

----------------------------------------------------------------------------------------------------------------------
---4)Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null 
/*(HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)*/

ALTER TABLE orders
DROP CONSTRAINT IF EXISTS orders_customerID_fkey;

ALTER TABLE orders
ADD CONSTRAINT orders_customerID_fkey
FOREIGN KEY(customerID)
REFERENCES customers(customerID)
ON DELETE SET NULL;

DELETE FROM customers 
WHERE customerid='VINET';

SELECT * 
FROM customers
WHERE customerid ='VINET';


SELECT * 
FROM orders 
WHERE customerid IS NULL;
--------------------------------------------------------------------------------------------------------------------------------
---5)Insert the following data to Products using UPSERT:
---product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=3
---product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=3
---product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=3

/*again inserted categoryID 3 values as we deleted in the previous question*/

SELECT * FROM categories WHERE categoryid = 3;


INSERT INTO categories (categoryid, categoryname, description)
VALUES (3, 'Confections', 'Desserts, candies, and sweet breads');


INSERT INTO products(productID, productName, quantityperunit, unitprice, discontinued, categoryID)
VALUES (100, 'Wheat bread', '1', 13, 'False', 3)
ON CONFLICT (productID)
DO UPDATE SET
    productName = EXCLUDED.productName,
    quantityperunit = EXCLUDED.quantityperunit,
    unitprice = EXCLUDED.unitprice,
    discontinued = EXCLUDED.discontinued,
    categoryID = EXCLUDED.categoryID;

INSERT INTO products(productID, productName, quantityperunit, unitprice, discontinued, categoryID)
VALUES (101, 'White bread', '5 boxes', 13, 'False', 3)
ON CONFLICT (productID)
DO UPDATE SET
    productName = EXCLUDED.productName,
    quantityperunit = EXCLUDED.quantityperunit,
    unitprice = EXCLUDED.unitprice,
    discontinued = EXCLUDED.discontinued,
    categoryID = EXCLUDED.categoryID;
	
INSERT INTO products(productID, productName, quantityperunit, unitprice, discontinued, categoryID)
VALUES (100, 'Wheat bread', '10 boxes', 13, 'False', 3)
ON CONFLICT (productID)
DO UPDATE SET
    productName = EXCLUDED.productName,
    quantityperunit = EXCLUDED.quantityperunit,
    unitprice = EXCLUDED.unitprice,
    discontinued = EXCLUDED.discontinued,
    categoryID = EXCLUDED.categoryID;

SELECT * FROM products
WHERE categoryID=3;
--------------------------------------------------------------------------------------------------------------
-----6)      Write a MERGE query:
---Create temp table with name:  ‘updated_products’ and insert values as below:

CREATE TABLE updated_products (
	productID INTEGER,
    productName VARCHAR(100),
    quantityPerUnit VARCHAR(50),
    unitPrice DECIMAL(10,2),
    discontinued Boolean,
    categoryID INTEGER
);

/*Got an error when trying to insert or update a product with categoryid = 1, 
--but there’s no corresponding record in the categories table with categoryid = 1 
---and hence i inserted category 1*/

INSERT INTO categories (categoryid, categoryname)
VALUES(1, 'Beverages'),
      (2, 'Condiments'),
      (3, 'Confections')
ON CONFLICT (categoryid) DO NOTHING;



INSERT INTO updated_products (productID, productName, quantityPerUnit, unitPrice, discontinued, categoryID)
VALUES(100, 'Wheat bread', '10', 20, 'True', 3),
      (101, 'White bread', '5 boxes', 19.99, 'False', 3),
      (102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, 'False', 1),
      (103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, 'False', 2);

SELECT * FROM updated_products	  


MERGE INTO products AS P
USING updated_products AS UP
ON P.productID = UP.productID

WHEN MATCHED AND UP.discontinued = 'False' THEN 
    UPDATE SET unitPrice = UP.unitPrice,
             discontinued = UP.discontinued

WHEN MATCHED AND UP.discontinued = 'True' THEN 
    DELETE

WHEN NOT MATCHED AND UP.discontinued = 'False' THEN
    INSERT VALUES (UP.productID, UP.productName, UP.quantityPerUnit, UP.unitPrice, UP.discontinued, UP.categoryID);

SELECT * FROM categories;

SELECT * FROM updated_products
WHERE productID IN (100,101,102,103);

SELECT * FROM products
WHERE productID IN (100,101,102,103);

----------------------------------------------------------------------------------------------------------------------------
---USE NEW Northwind DB:
 
-----7)List all orders with employee full names. (Inner join)

SELECT o.order_id,o.order_date,o.customer_id,e.employee_id,
    e.first_name || ' ' || e.last_name AS employee_name
FROM orders o
INNER JOIN employees e ON o.employee_id = e.employee_id;
