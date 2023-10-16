-- Their example:
SELECT standard_qty,
    DATE_TRUNC('month', occurred_at) AS month,
    SUM(standard_qty) OVER (
        PARTITION BY DATE_TRUNC('month', occurred_at)
        ORDER BY occurred_at
    ) AS running_total
FROM orders;
-- My answer:
SELECT standard_amt_usd,
    SUM(standard_amt_usd) OVER (
        ORDER BY occurred_at
    ) AS running_total
FROM orders;
-- Their answer:
SELECT standard_amt_usd,
    SUM(standard_amt_usd) OVER (
        ORDER BY occurred_at
    ) AS running_total
FROM orders -- Notes:
    -- Ordering by occurred_at ensures that it's a running total over time.
    -- After all, the sum(x) window function can only work with the order you tell it to.
    -- It doesn't know you want chronological order unless you pass in an ordered list.