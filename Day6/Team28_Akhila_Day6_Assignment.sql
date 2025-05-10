---------------------------------------------------------Assignment Day6---------------------------------------------------------
--1)Categorize products by stock status(Display product_name, a new column stock_status whose values are based on 
--below condition units_in_stock = 0  is 'Out of Stock' , units_in_stock < 20  is 'Low Stock')

SELECT product_name,
CASE 
	WHEN units_in_stock = 0 THEN 'Out of Stock'
	WHEN  units_in_stock < 20 THEN 'Low Stock'
	ELSE 'In Stock'
	END AS Stock_Status
FROM products
ORDER BY product_name;
--------------------------------------------------------------------------------------------------------------------------
--2)Find All Products in Beverages Category (Subquery, Display product_name,unitprice)

SELECT product_name,unit_price
FROM products
WHERE 
	category_id = (
		SELECT category_id
		FROM categories
		WHERE category_name = 'Beverages'
  )
ORDER BY 
	product_name;

---------------------------------------------------------------------------------------------------------------------------
---3) Find Orders by Employee with Most Sales (Display order_id,   order_date,  freight, employee_id.
---Employee with Most Sales=Get the total no.of of orders for each employee then order by DESC and limit 1. Use Subquery)

SELECT order_id,order_date,freight,employee_id
FROM orders
WHERE employee_id =(
				SELECT employee_id
                FROM orders
               GROUP BY employee_id
        ORDER BY COUNT(order_id) DESC
        LIMIT 1
    )
ORDER BY 
    order_date;
-------------------------------------------------------------------------------------------------------------------------------
---4)  Find orders  where for country!= ‘USA’ with freight costs higher than any order from USA. 
------(Subquery, Try with ANY, ALL operators)

SELECT order_id, order_date, freight, ship_country
FROM 
    orders
WHERE 
    ship_country != 'USA'
    AND freight > ANY (
        SELECT freight
        FROM orders
        WHERE ship_country = 'USA'
    )
ORDER BY 
    freight DESC;

SELECT order_id, order_date, freight, ship_country
FROM 
    orders
WHERE 
    ship_country != 'USA'
    AND freight > ALL (
        SELECT freight
        FROM orders
        WHERE ship_country = 'USA'
    )
ORDER BY 
    freight DESC;








 


