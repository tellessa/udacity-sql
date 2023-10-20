with double_accounts AS (
    SELECT *
    FROM accounts a1
    UNION ALL
    SELECT *
    FROM accounts a2
)
SELECT COUNT(name)
FROM double_accounts;
-- Answer: I forgot that GROUP BY was a way to start a count over for each unique value in a column
WITH double_accounts AS (
    SELECT *
    FROM accounts
    UNION ALL
    SELECT *
    FROM accounts
)
SELECT name,
    COUNT(*) AS name_count
FROM double_accounts
GROUP BY 1
ORDER BY 2 DESC