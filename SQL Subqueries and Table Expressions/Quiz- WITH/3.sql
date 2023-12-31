WITH inner_tab AS (
    SELECT a.name act_name,
        SUM(o.standard_qty) tot_std,
        SUM(o.total) total
    FROM accounts a
        JOIN orders o ON o.account_id = a.id
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 1
), counter_tab AS (
    SELECT a.name
    FROM orders o
        JOIN accounts a ON a.id = o.account_id
    GROUP BY 1
    HAVING SUM(o.total) > (
            SELECT total
            FROM inner_tab
        )
    SELECT COUNT(*)
    FROM counter_tab;
) -- answer: matches except table aliases
WITH t1 AS (
    SELECT a.name account_name,
        SUM(o.standard_qty) total_std,
        SUM(o.total) total
    FROM accounts a
        JOIN orders o ON o.account_id = a.id
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 1
), t2 AS (
    SELECT a.name
    FROM orders o
        JOIN accounts a ON a.id = o.account_id
    GROUP BY 1
    HAVING SUM(o.total) > (
            SELECT total
            FROM t1
        )
)
SELECT COUNT(*)
FROM t2;