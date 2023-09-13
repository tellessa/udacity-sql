SELECT SUM(poster_qty)
FROM orders;
-- Their solution:
SELECT SUM(poster_qty) AS total_poster_sales
FROM orders;