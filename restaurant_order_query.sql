USE restaurant_db;

## EXPLORE THE MENU ITEMS TABLE ##

-- 1. View the menu_items table.
SELECT 
    *
FROM
    menu_items;

-- 2. Find the number of items on the menu.
SELECT 
    COUNT(*) AS num_of_items
FROM
    menu_items; 
    
# there are 32 items on the menu
    
-- 3. What are the least and most expensive items on the menu?
SELECT 
    *
FROM
    menu_items
ORDER BY price ASC;

# the cheapest: Edamame, the most expensive Shrimp Scampi
-- 4. How many Italian dishes are on the menu?

SELECT
	COUNT(*) AS num_of_item
FROM
	menu_items
WHERE
	category = 'Italian';
# there are 9 Italian dishes on the menu

-- 5. What are the least and most expensive Italian dishes on the menu?
SELECT 
    item_name, price
FROM
    menu_items
WHERE
    category = 'Italian'
ORDER BY price;
# Spaghetti is the cheapest while the most expensive one is Shrimp Scampi 

-- 6. How many dishes are in each category?
SELECT
	category,
    COUNT(*) AS num_of_dishes
FROM
	menu_items
GROUP BY
category;

-- 7. What is the average dish price within each category?

SELECT
	category,
    ROUND(AVG(price),2) AS avg_price
FROM
	menu_items
GROUP BY
category;

## EXPLORE THE ORDERS TABLE ## 

-- 1. View the order details table.
SELECT
	*
FROM
	order_details;

-- 2. What is the date range of the table?
SELECT 
    MIN(order_date) AS min_order_date, MAX(order_date) AS max_order_date
FROM
    order_details;
    
# the date range of the table is from 2023-01-01 - 2023-03-31

-- 3. How many orders were made within this date range?
SELECT
	COUNT(DISTINCT(order_id)) AS num_of_order
FROM
	order_details;
# there are 5370 orders 

## ANALYZE CUSTOMER BEHAVIOR ##

-- 1. Combine the menu_items and order_details tab into a Single tab
SELECT
	*
FROM
	order_details o LEFT JOIN menu_items m  ON o.item_id = m.menu_item_id
ORDER BY
order_id ASC;

-- 2. What were the least and most ordered items? what categories were they in?
SELECT
	o.item_id,
    m.item_name,
    m.category,
	COUNT(o.item_id) AS num_of_order
FROM
	order_details o LEFT JOIN menu_items m  ON o.item_id = m.menu_item_id
GROUP BY
	o.item_id
ORDER BY
	num_of_order ASC;
# Chicken tacos were the least ordered with 123 orders and it is Mexican, the most ordered is Hamburger with 622 orders and it is American

-- 3. What is the busiest hour of the day?
SELECT
	HOUR(order_time) AS time_of_day,
    COUNT(*) AS num_orders
FROM
	order_details
GROUP BY
	time_of_day
ORDER BY
	time_of_day;
    
# the busiest hour of the day is at 12 where people usually get lunch

-- 4.  What is the busiest day of the week?
SELECT
	DAYNAME(order_date) AS day_of_week,
    COUNT(*) num_of_orders
FROM
	order_details
GROUP BY
	day_of_week
ORDER BY 
    FIELD(day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');
