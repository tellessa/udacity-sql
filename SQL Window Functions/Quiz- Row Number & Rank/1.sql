-- Example
SELECT id,
    account_id,
    DATE_TRUNC('month', occurred_at) AS month,
    RANK() OVER (
        PARTITION BY account_id
        ORDER BY DATE_TRUNC('month', occurred_at)
    ) AS row_num
FROM orders