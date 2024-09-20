--Q.1)
--Find the total number of orders placed by each customer.
--Table: Orders (OrderID, CustomerID, OrderDate)
--Table: Customers (CustomerID, Name, Email)

	SELECT 
	c.CustomerID, 
	c.Name,
	COUNT(o.OrderID) AS TotalOrders
	FROM 
	Customers c
	JOIN
	Orders o ON c.CustomerID = o.CustomerID
	GROUP BY
	c.CustomerID, c.Name;

--Q.2)
--Retrieve the names of products that have never been ordered.
--Table: Products (ProductID, Name, Price)
--Table: OrderDetails (OrderID, ProductID, Quantity)



	SELECT
		p.productid,
		p.name
	FROM 
		products AS p
	JOIN
		orderdetails AS od
	ON 
		p.productid = od.productid
	WHERE 
		od.productid IS NULL

-- Q.3:
--Find the average order value for each month in 2022.
--Table: Orders (OrderID, CustomerID, OrderDate, TotalAmount)


 
SELECT AVG(TOTALAMOUNT)
FROM (
  SELECT
    SUM(pd.price * od.quantity) AS TOTALAMOUNT,
    EXTRACT(MONTH FROM o.orderdate) AS each_month,
    EXTRACT(YEAR FROM o.orderdate) AS each_year
  FROM orders AS o
  JOIN orderdetails AS od ON o.orderid = od.orderid
  JOIN products AS pd ON od.productid = pd.productid
  WHERE EXTRACT(YEAR FROM o.orderdate) = 2022
  GROUP BY each_month, each_year
) AS SUB;

--Question 4:
--Get the top 3 customers with the highest total order value.
--Table: Orders (OrderID, CustomerID, OrderDate, TotalAmount)
--Table: Customers (CustomerID, Name, Email)

SELECT 
	cu.name,
	SUM(pd.price * od.quantity) AS TOTALAMOUNT
FROM customers AS cu
JOIN orders AS o ON cu.customerid = o.customerid
JOIN orderdetails AS od ON o.orderid = od.orderid
JOIN products AS pd ON od.productid = pd.productid
GROUP BY cu.name
ORDER BY TOTALAMOUNT DESC
LIMIT 3;

--Alternative Using Window Function

SELECT 
	name, TOTALAMOUNT
FROM (
	SELECT 
		cu.name,
		SUM(pd.price * od.quantity) AS TOTALAMOUNT,
		RANK() OVER (ORDER BY SUM(pd.price * od.quantity) DESC) AS rank
	FROM customers AS cu
	JOIN orders AS o ON cu.customerid = o.customerid
	JOIN orderdetails AS od ON o.orderid = od.orderid
	JOIN products AS pd ON od.productid = pd.productid
	GROUP BY cu.name
) AS subquery
WHERE rank <= 3;
	
		


	
	