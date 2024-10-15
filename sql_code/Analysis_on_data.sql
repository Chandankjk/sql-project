-- Analysis based on 
	-- 1. Aggregation and Grouping
    -- 2. Joins and Relationships
    -- 3. Subqueries and CTEs
    -- 4. Advanced SQL Functions
-- Q . Find the customer who placed order more  than average number of orders , also return the name of the customers and their order count
use zomato_db;

SELECT c.customer_name, n.customer_id, n.total_orders
FROM customers AS c
INNER JOIN (
    SELECT customer_id, COUNT(order_id) AS total_orders -- subquery to find the customer_id and more than average orders of total number of orders
    FROM Orders
    GROUP BY customer_id
    HAVING COUNT(order_id) > (
        SELECT AVG(order_count) 
        FROM (
            SELECT COUNT(order_id) AS order_count
            FROM Orders
            GROUP BY customer_id
        ) AS customer_orders
    )
) AS n ON c.customer_id = n.customer_id;
-- average number of order is 416.66 , these custoners order more number of times than average of all the cutomers 


-- Q . Find the customer who spent  more  than 2 lakh in total , also return the name of the customers and their total spending

SELECT c.customer_name, c.customer_id, SUM(o.total_amount) AS total_spent
FROM customers AS c
INNER JOIN orders AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING total_spent > 200000;
