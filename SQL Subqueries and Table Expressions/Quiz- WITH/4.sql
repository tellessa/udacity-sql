WITH inner_table AS (
    SELECT a.id,
        a.name,
        SUM(o.total_amt_usd) tot_spent
    FROM orders o
        JOIN accounts a ON a.id = o.account_id
    GROUP BY a.id,
        a.name
    ORDER BY 3 DESC
    LIMIT 1
)
SELECT a.name,
    w.channel,
    COUNT(*)
FROM accounts a
    JOIN web_events w ON a.id = w.account_id
    AND a.id = (
        SELECT id
        FROM inner_table
    )
GROUP BY 1,
    2
ORDER BY 3 DESC;
-- Answer:
WITH t1 AS (
    SELECT a.id,
        a.name,
        SUM(o.total_amt_usd) tot_spent
    FROM orders o
        JOIN accounts a ON a.id = o.account_id
    GROUP BY a.id,
        a.name
    ORDER BY 3 DESC
    LIMIT 1
)
SELECT a.name,
    w.channel,
    COUNT(*)
FROM accounts a
    JOIN web_events w ON a.id = w.account_id
    AND a.id = (
        SELECT id
        FROM t1
    )
GROUP BY 1,
    2
ORDER BY 3 DESC;