-- Which account has spent the least with us?
-- Same as 6 but ordered ascending
SELECT a.id,
    a.name,
    SUM(o.total_amt_usd) total_spent
FROM accounts a
    JOIN orders o ON a.id = o.account_id
GROUP BY a.id,
    a.name
ORDER BY total_spent
LIMIT 1;