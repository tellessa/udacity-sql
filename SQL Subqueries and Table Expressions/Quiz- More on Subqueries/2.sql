-- 1. find only the orders that took place in the same month and year as the first order.
-- 2. Pull the average for each type of paper.
SELECT DATE_TRUNC('month', occurred_at),
    AVG(standard_qty) avg_std_qty,
    AVG(gloss_qty) avg_gloss_qty,
    AVG(poster_qty) avg_post_qty,
    SUM(total_amt_usd)
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = (
        SELECT DATE_TRUNC('month', occurred_at) order_month
        FROM orders
        ORDER BY occurred_at ASC
        LIMIT 1
    )
GROUP BY 1;
-- answer: Same idea but in 2 queries and with a more succinct subquery
SELECT AVG(standard_qty) avg_std,
    AVG(gloss_qty) avg_gls,
    AVG(poster_qty) avg_pst
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = (
        SELECT DATE_TRUNC('month', MIN(occurred_at))
        FROM orders
    );
SELECT SUM(total_amt_usd)
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = (
        SELECT DATE_TRUNC('month', MIN(occurred_at))
        FROM orders
    );