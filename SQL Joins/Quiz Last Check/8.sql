SELECT o.occurred_at,
    a.name account,
    o.total,
    o.total_amt_usd
FROM orders o
    JOIN accounts a ON o.account_id = a.id
WHERE date_trunc('year', o.occurred_at) = 2015;
-- Use date trunc to check if a date was in 2015
;
-- Their answer:
SELECT o.occurred_at,
    a.name,
    o.total,
    o.total_amt_usd
FROM accounts a
    JOIN orders o ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY o.occurred_at DESC;