-- In which month of which year did Walmart spend the most on gloss paper in terms of dollars?
-- I want to filter to one row.
-- I want to select the month and year from that row; I can concatenate, or I can just leave them together
-- We need to group by the year and month
-- Join accounts to filter to account.name Walmart
SELECT DATE_TRUNC('month', o.occurred_at),
    SUM(o.gloss_amt_usd)
FROM orders o
    JOIN accounts a ON o.account_id = a.id
WHERE a.name = 'Walmart'
GROUP BY DATE_TRUNC('month', o.occurred_at),
    o.gloss_amt_usd
ORDER BY o.gloss_amt_usd DESC
LIMIT 1;
-- Answer: I missed the order date alias and total spent alias
-- JOIN was correct
-- WHERE clause correct
-- group by included 2 columns, but only need the 1st; including the second actually makes the answer wrong
-- I used gloss_amt_usd instead of SUM(gloss_amt_usd) to order by.
SELECT DATE_TRUNC('month', o.occurred_at) ord_date,
    SUM(o.gloss_amt_usd) tot_spent
FROM orders o
    JOIN accounts a ON a.id = o.account_id
WHERE a.name = 'Walmart'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;