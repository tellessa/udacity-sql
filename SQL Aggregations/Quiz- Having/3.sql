-- Which account has the most orders?
SELECT a.id,
    a.name,
    COUNT(*) num_orders
FROM accounts a
    JOIN orders o ON o.account_id = a.id
GROUP BY a.id,
    a.name
ORDER BY num_orders DESC
LIMIT 1;
-- answer: another perfect match
SELECT a.id,
    a.name,
    COUNT(*) num_orders
FROM accounts a
    JOIN orders o ON a.id = o.account_id
GROUP BY a.id,
    a.name
ORDER BY num_orders DESC
LIMIT 1;