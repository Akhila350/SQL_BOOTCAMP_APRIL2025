---------------------------------------------------------Assignment Day5---------------------------------------------------------
--1)GROUP BY with WHERE - Orders by Year and QuarterDisplay, order year, quarter, order count, avg freight cost only 
----for those orders where freight cost > 100

SELECT 
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(QUARTER FROM order_date) AS order_quarter,
    COUNT(order_id) AS order_count,
    AVG(freight) AS avg_freight
FROM 
    orders
WHERE 
    freight > 100
GROUP BY 
    EXTRACT(YEAR FROM order_date),
    EXTRACT(QUARTER FROM order_date)
ORDER BY 
    order_year,
    order_quarter;
------------------------------------------------------------------------------------------------------------------------
---2)GROUP BY with HAVING - High Volume Ship Regions Display, ship region, no of orders in each region, 
---min and max freight cost Filter regions where no of orders >= 5	

SELECT 
    ship_region,
    COUNT(order_id) AS no_of_orders,
    MIN(freight) AS min_freight,
    MAX(freight) AS max_freight
FROM 
    orders
GROUP BY 
    ship_region
HAVING 
    COUNT(order_id) >= 5
ORDER BY 
    no_of_orders DESC;
------------------------------------------------------------------------------------------------------------------------
---3)Get all title designations across employees and customers ( Try UNION & UNION ALL)
--Union
SELECT 
    title
FROM 
    employees

UNION

SELECT 
    contact_title
FROM 
    customers
ORDER BY 
    title;

---Unionall

SELECT 
    title
FROM 
    employees

UNION ALL

SELECT 
    contact_title
FROM 
    customers
ORDER BY 
    title;
------------------------------------------------------------------------------------------------------------------------
---4)Find categories that have both discontinued and in-stock products(Display category id, 
----instock means units in stock > 0, Intersect)

SELECT 
    category_id,product_name
FROM 
    products
WHERE 
    discontinued = 1

INTERSECT

SELECT 
    category_id,product_name
FROM 
    products
WHERE 
    units_in_stock > 0
ORDER BY 
    category_id;
--------------------------------------------------------------------------------------------------------------------------------
---5)Find orders that have no discounted items (Display order. id, EXCEPT)
---all orders
SELECT order_id
FROM orders
EXCEPT
SELECT DISTINCT order_id
FROM 
    order_details
WHERE 
    discount > 0
ORDER BY 
    order_id;


