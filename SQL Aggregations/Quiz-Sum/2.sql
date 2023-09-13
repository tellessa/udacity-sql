SELECT SUM(standard_qty)
FROM orders;
-- Their solution
SELECT SUM(standard_qty) AS total_standard_sales
FROM orders;