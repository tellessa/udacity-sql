-- Example
SELECT id,
    account_id,
    DATE_TRUNC('month', occurred_at) AS month,
    RANK() OVER (
        PARTITION BY account_id
        ORDER BY DATE_TRUNC('month', occurred_at)
    ) AS row_num
FROM orders -- Select the id, account_id, and total variable from the orders table, then create a column called total_rank that ranks this total amount of paper ordered (from highest to lowest) for each account using a partition. Your final table should have these four columns.
    -- My answer:
SELECT o.id,
    o.account_id,
    o.total,
    RANK() OVER (
        PARTITION BY account_id
        ORDER BY total DESC
    ) AS total_rank
FROM orders o
    JOIN accounts a ON o.account_id = a.id;
-- Answer:
SELECT id,
    account_id,
    total,
    RANK() OVER (
        PARTITION BY account_id
        ORDER BY total DESC
    ) AS total_rank
FROM orders;