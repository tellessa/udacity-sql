WITH t1 AS (
    SELECT r.name region_name,
        SUM(o.total_amt_usd) total_amt
    FROM sales_reps s
        JOIN accounts a ON a.sales_rep_id = s.id
        JOIN orders o ON o.account_id = a.id
        JOIN region r ON r.id = s.region_id
    GROUP BY r.name
)
SELECT r.name,
    COUNT(o.total) total_orders
FROM sales_reps s
    JOIN accounts a ON a.sales_rep_id = s.id
    JOIN orders o ON o.account_id = a.id
    JOIN region r ON r.id = s.region_id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (
        SELECT MAX(total_amt)
        FROM t1
    );