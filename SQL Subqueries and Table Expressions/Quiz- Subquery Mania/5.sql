-- What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?
-- A lifetime average amount spent is different than a total spent.
-- Average is the avg across an entire column called total amt usd
-- To find top 10 total spending accounts requires LIMIT 10
-- Before LIMIT 10, we need to find out the total spent by account
-- 1. Find total spent by account
--     a. JOIN orders and accounts
-- This query will give us the 10 accounts we care about in the top level query
-- Maybe we can filter using a having clause?
SELECT a.name,
    SUM(o.total) lifetime_total
FROM accounts a
    JOIN orders o ON a.id = o.account_id
GROUP BY 1
ORDER BY 2 DESC;
-- next
SELECT a.name,
    SUM(o.total) lifetime_total,
    AVG(o.total) avg_amt_spent
FROM accounts a
    JOIN orders o ON a.id = o.account_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;
-- Answer:
SELECT AVG(tot_spent)
FROM (
        SELECT a.id,
            a.name,
            SUM(o.total_amt_usd) tot_spent
        FROM orders o
            JOIN accounts a ON a.id = o.account_id
        GROUP BY a.id,
            a.name
        ORDER BY 3 DESC
        LIMIT 10
    ) temp;
-- The question sounded like it wanted one average per each of the top 10
-- They actually wanted one average of the total of the top 10