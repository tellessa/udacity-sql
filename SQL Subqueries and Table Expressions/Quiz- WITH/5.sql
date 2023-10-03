WITH temp AS (
    SELECT a.id,
        a.name,
        SUM(o.total_amt_usd) tot_spent
    FROM orders o
        JOIN accounts a ON a.id = o.account_id
    GROUP BY a.id,
        a.name
    ORDER BY 3 DESC
    LIMIT 10
)
SELECT AVG(tot_spent)
FROM temp;
-- answer:
WITH t1 AS (
    SELECT a.id,
        a.name,
        SUM(o.total_amt_usd) tot_spent
    FROM orders o
        JOIN accounts a ON a.id = o.account_id
    GROUP BY a.id,
        a.name
    ORDER BY 3 DESC
    LIMIT 10
)
SELECT AVG(tot_spent)
FROM t1;