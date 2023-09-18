-- Need total_sales_usd and name
-- There are several sales for each account
SELECT a.name,
    SUM(total_amt_usd) total_sales_usd
FROM orders o
    JOIN accounts a ON a.id = o.account_id
GROUP BY a.name
ORDER BY 1;
-- Their solution; they omitted order by, which is fine because the question didn't ask for it.
-- Otherwise it's an exact match.
SELECT a.name,
    SUM(total_amt_usd) total_sales
FROM orders o
    JOIN accounts a ON a.id = o.account_id
GROUP BY a.name;