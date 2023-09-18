-- What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.
SELECT a.name,
    MAX(o.total_amt_usd)
FROM accounts a
    JOIN orders o ON o.account_id = a.id
GROUP BY 1
ORDER BY 2 ASC;
SELECT a.name,
    MIN(total_amt_usd) smallest_order
FROM accounts a
    JOIN orders o ON a.id = o.account_id
GROUP BY a.name
ORDER BY smallest_order;
-- Their Answer: ≈
SELECT a.name,
    MIN(total_amt_usd) smallest_order
FROM accounts a
    JOIN orders o ON a.id = o.account_id
GROUP BY a.name
ORDER BY smallest_order;