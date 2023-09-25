-- Write a query to display the number of orders in each of three categories, based on the total number of items in each order. The three categories are: 'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'.
SELECT total,
    CASE
        WHEN total < 1000 THEN 'Less than 1000'
        WHEN total BETWEEN 1000 AND 2000 THEN 'Between 1000 and 2000' -- Could have been an ELSE
        WHEN total >= 2000 THEN 'At Least 2000'
    END AS order_level
FROM orders;
-- Answer: Each order has a total, so we need to group by the category we create, then count how many fell into each category
SELECT CASE
        WHEN total >= 2000 THEN 'At Least 2000'
        WHEN total >= 1000
        AND total < 2000 THEN 'Between 1000 and 2000'
        ELSE 'Less than 1000'
    END AS order_category,
    COUNT(*) AS order_count
FROM orders
GROUP BY 1;