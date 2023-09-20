-- Combining data, lining it up, then checking how certain values intersect/align, sometimes doing some math
-- Which accounts spent more than 30,000 usd total across all orders?
-- Starting to click that agg functions and group by clauses go hand in hand.
SELECT a.id,
    a.name,
    SUM(o.total_amt_usd)
FROM accounts a
    JOIN orders o ON a.id = o.account_id
GROUP BY a.id,
    a.name
HAVING SUM(total_amt_usd) > 30000
ORDER BY 3 DESC;
-- answer: our order bys were in opposite order and they aliased the total amount, but same otherwise
SELECT a.id,
    a.name,
    SUM(o.total_amt_usd) total_spent
FROM accounts a
    JOIN orders o ON a.id = o.account_id
GROUP BY a.id,
    a.name
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY total_spent;