-- We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders. Create a table with the sales rep name, the total number of orders, and a column with top or not depending on if they have more than 200 orders. Place the top sales people first in your final table.
SELECT s.name,
    COUNT(*) num_orders,
    CASE
        WHEN COUNT(*) > 200 THEN 'top'
        ELSE 'not'
    END AS performance
FROM orders o
    JOIN accounts a ON o.account_id = a.id
    JOIN sales_reps s ON a.sales_rep_id = s.id
GROUP BY 1
ORDER BY 2 DESC;
-- answer: pretty much an exact match, except alias names and other minor details
-- His note: It is worth mentioning that this assumes each name is unique - which has been done a few times. We otherwise would want to break by the name and the id of the table. (I think he means "break things down by" or "group by").
SELECT s.name,
    COUNT(*) num_ords,
    CASE
        WHEN COUNT(*) > 200 THEN 'top'
        ELSE 'not'
    END AS sales_rep_level
FROM orders o
    JOIN accounts a ON o.account_id = a.id
    JOIN sales_reps s ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY 2 DESC;