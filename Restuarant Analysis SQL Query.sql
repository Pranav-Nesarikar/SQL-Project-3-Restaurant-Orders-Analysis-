-- - OBJECTIVE - 1 - ---

-- 1. View the menu_items table.?
SELECT * FROM menu_items;

-- 2. Find the number of Items in the Menu.?
SELECT count(*) FROM menu_items;

-- 3. What are the least and Most Expensive item in the Menu ?
SELECT * FROM menu_items
ORDER BY price;

SELECT * FROM menu_items
ORDER BY price DESC;

-- 4. How many Italian Dishes are on the Menu.?
SELECT COUNT(*) FROM menu_items 
WHERE category = "Italian";

-- 5. What are the least and Most Expensive Italian dishes on the Menu ?
SELECT * FROM menu_items 
WHERE category = "Italian"
ORDER BY price;

SELECT * FROM menu_items 
WHERE category = "Italian"
ORDER BY price DESC;

-- 6. How many dishes are in each category ?
SELECT category , COUNT(item_name) as num_Dishes FROM menu_items 
GROUP BY category;

-- 7. What is the Average dish price within each category ?
SELECT category , COUNT(item_name) as num_Dishes , avg(price) as avg_price FROM menu_items 
GROUP BY category;

-- - OBJECTIVE - 2 ----

-- 1. View the Order details Table ?
SELECT * FROM order_details;

-- 2. What is the date range of the table ?
SELECT MIN(order_date) , MAX(order_date) FROM order_details;

select monthname(order_date) , year(order_date) from order_details 
group by monthname(order_date) , year(order_date) ;

-- 3. How many orders were made within this date range ?
SELECT count(distinct(order_id)) FROM order_details;

-- 4. How many items were ordered within this date range ?
SELECT count(*) FROM order_details;

-- 5. Which orders had the most number of Items ?
SELECT order_id , count(item_id) as item_count FROM order_details
group by order_id 
order by item_count desc ;

-- 6. How many orders had more than 12 Items ?
SELECT count(*) FROM
(SELECT order_id , count(item_id) as item_count FROM order_details
group by order_id 
having item_count > 12) as num_orders;

-- - OBJECTIVE - 3 ---

-- 1. Combine the menu_items and order_details tables into single table ?
SELECT * FROM menu_items;
SELECT * FROM order_details;

SELECT * FROM order_details od 
LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id;	

-- 2. What were the least and most ordered items ? What categories were they in ?
SELECT od.item_id , item_name , count(item_name) as count, category FROM order_details od 
LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
    group by od.item_id , item_name , category
    order by count ;
	
SELECT od.item_id , item_name , count(item_name) as count, category FROM order_details od 
LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
    group by od.item_id , item_name , category
    order by count desc;	
    
-- 3. What were the top 5 orders that spent the most money ?
SELECT order_id , sum(price) as total_spend FROM order_details od 
LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
    group by order_id	
order by total_spend desc 
limit 5;

-- 4. View the details of the highest spend order ? What insights can you gather from this ?
SELECT * FROM order_details od 
LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
   where order_id = 440;

SELECT category , count(item_id) FROM order_details od 
LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
   where order_id = 440
   group by category;
-- 5. View the details of the top 5 highest spend order ? What insights can you gather from this ?
SELECT order_id  ,category , count(item_id) FROM order_details od 
LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
   where order_id in (440 ,2075 , 1957 , 330 , 2675)
   group by order_id , category;
   
   
 