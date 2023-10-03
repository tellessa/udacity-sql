WITH t1 AS (
    SELECT o.account_id,
        AVG(o.total_amt_usd) avg_amt
    FROM orders o
    GROUP BY 1
    HAVING AVG(o.total_amt_usd) > (
            SELECT AVG(o.total_amt_usd) avg_all
            FROM orders o
        )
)
SELECT AVG(avg_amt)
FROM t1;
-- Answer:
-- yields same result as mine, but he joined accounts to orders in his innermost table for some reason, even though he didn't do that in his answer to the same question in the subquery mania quiz
WITH t1 AS (
    SELECT AVG(o.total_amt_usd) avg_all
    FROM orders o
        JOIN accounts a ON a.id = o.account_id
),
t2 AS (
    SELECT o.account_id,
        AVG(o.total_amt_usd) avg_amt
    FROM orders o
    GROUP BY 1
    HAVING AVG(o.total_amt_usd) > (
            SELECT *
            FROM t1
        )
)
SELECT AVG(avg_amt)
FROM t2;