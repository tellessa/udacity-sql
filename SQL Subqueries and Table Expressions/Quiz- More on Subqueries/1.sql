SELECT id,
    occurred_at,
    DATE_TRUNC('month', occurred_at) order_month
FROM orders
ORDER BY occurred_at ASC;
-- answer: No need for a group by with the MIN() function because there are no non-aggregated columns being selected
SELECT DATE_TRUNC('month', MIN(occurred_at))
FROM orders;