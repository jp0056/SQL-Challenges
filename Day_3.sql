-- IBM Data Analyst SQL Question
-- Q.1
-- Customer Segmentation Problem:
-- You have two tables: customers and orders.

-- customers table has columns: 
  -- customer_id, customer_name, age, gender.
-- orders table has columns: 
-- order_id, customer_id, order_date, total_amount.


-- Write an SQL query to find the average order amount 
-- for male and female customers separately
-- return the results with 2 DECIMAL.


-- ----------------------------------------------
-- My solution
-- ----------------------------------------------

SELECT * FROM customers
SELECT * FROM orders

-- avg spent
-- by gender
-- join both table

SELECT 
	c.gender,
	ROUND(AVG(o.total_amount),2) AS avg_spend
from customers AS c
JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY 1
	
	



