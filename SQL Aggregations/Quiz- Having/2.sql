SELECT a.id,
    a.name,
    COUNT(*) num_orders
FROM accounts a
    JOIN orders o ON o.account_id = a.id
GROUP BY a.id,
    a.name
HAVING COUNT(*) > 20
ORDER BY num_orders;
-- answer: exact match with mine
SELECT a.id,
    a.name,
    COUNT(*) num_orders
FROM accounts a
    JOIN orders o ON a.id = o.account_id
GROUP BY a.id,
    a.name
HAVING COUNT(*) > 20
ORDER BY num_orders;