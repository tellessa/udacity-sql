-- We would like to understand 3 different levels of customers based on the amount associated with their purchases. The top level includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. The second level is between 200,000 and 100,000 usd. The lowest level is anyone under 100,000 usd. Provide a table that includes the level associated with each account. You should provide the account name, the total sales of all orders for the customer, and the level. Order with the top spending customers listed first.
SELECT a.name,
    SUM(o.total_amt_usd) "Lifetime Value",
    CASE
        WHEN SUM(o.total_amt_usd) > 200000 THEN 1
        WHEN SUM(o.total_amt_usd) <= 200000
        AND SUM(o.total_amt_usd) >= 100000 THEN 2
        ELSE 3
    END AS order_level
FROM accounts a
    JOIN orders o ON a.id = o.account_id
GROUP BY 1
ORDER BY 2 DESC;
-- answer: mine was mostly the same; different alias for column 2; different cutoff points (>=, <= instead of > and <) and he didn't use the AND because it was already implied that the sum was less than 200000.
SELECT a.name,
    SUM(total_amt_usd) total_spent,
    CASE
        WHEN SUM(total_amt_usd) > 200000 THEN 'top'
        WHEN SUM(total_amt_usd) > 100000 THEN 'middle'
        ELSE 'low'
    END AS customer_level
FROM orders o
    JOIN accounts a ON o.account_id = a.id
GROUP BY a.name
ORDER BY 2 DESC;