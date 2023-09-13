SELECT SUM(total_amt_usd)
FROM orders;
-- Their solution
SELECT SUM(total_amt_usd) total_dollar_sales
FROM orders;