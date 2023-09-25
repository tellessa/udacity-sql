-- Write a query to display for each order, the account ID, total amount of the order, and the level of the order - ‘Large’ or ’Small’ - depending on if the order is $3000 or more, or smaller than $3000.
SELECT a.id,
    o.total_amt_usd,
    CASE
        WHEN o.total_amt_usd > 3000 THEN 'Large'
        ELSE 'Small'
    END AS order_level
FROM accounts a
    JOIN orders o ON o.account_id = a.id
ORDER BY 2 DESC;
-- answer: join wasn't required, because account id could be taken directly from orders table. ORDER BY was optional.
SELECT account_id,
    total_amt_usd,
    CASE
        WHEN total_amt_usd > 3000 THEN 'Large'
        ELSE 'Small'
    END AS order_level
FROM orders;