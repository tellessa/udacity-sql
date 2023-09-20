-- Which account has spent the most with us?
-- we want to sum the total spent, then limit to the first ordered DESC
-- We first need to join accounts to orders
-- A lot like #3, where we used aggregation and group by, but no HAVING.
SELECT a.id,
    a.name,
    SUM(o.total_amt_usd) total_spent
FROM accounts a
    JOIN orders o ON a.id = o.account_id
GROUP BY a.id,
    a.name
ORDER BY total_spent DESC
LIMIT 1;
-- Answer: perfect match
SELECT a.id,
    a.name,
    SUM(o.total_amt_usd) total_spent
FROM accounts a
    JOIN orders o ON a.id = o.account_id
GROUP BY a.id,
    a.name
ORDER BY total_spent DESC
LIMIT 1;