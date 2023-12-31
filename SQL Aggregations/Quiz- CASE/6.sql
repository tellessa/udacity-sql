-- The previous didn't account for the middle, nor the dollar amount associated with the sales. Management decides they want to see these characteristics represented as well. We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders or more than 750000 in total sales. The middle group has any rep with more than 150 orders or 500000 in sales. Create a table with the sales rep name, the total number of orders, total sales across all orders, and a column with top, middle, or low depending on this criteria. Place the top sales people based on dollar amount of sales first in your final table.
SELECT s.name,
    COUNT(*) num_ords,
    SUM(total_amt_usd) total_sales,
    CASE
        WHEN COUNT(*) > 200
        OR SUM(total_amt_usd) > 750000 THEN 'top'
        WHEN COUNT(*) > 150
        OR SUM(total_amt_usd) > 500000 THEN 'middle'
        ELSE 'low'
    END AS sales_rep_level
FROM orders o
    JOIN accounts a ON o.account_id = a.id
    JOIN sales_reps s ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY 3 DESC;
-- answer: Looks the exact same except for aliases
SELECT s.name,
    COUNT(*),
    SUM(o.total_amt_usd) total_spent,
    CASE
        WHEN COUNT(*) > 200
        OR SUM(o.total_amt_usd) > 750000 THEN 'top'
        WHEN COUNT(*) > 150
        OR SUM(o.total_amt_usd) > 500000 THEN 'middle'
        ELSE 'low'
    END AS sales_rep_level
FROM orders o
    JOIN accounts a ON o.account_id = a.id
    JOIN sales_reps s ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY 3 DESC;