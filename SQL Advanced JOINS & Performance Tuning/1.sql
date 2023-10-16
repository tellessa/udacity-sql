SELECT *
FROM accounts a
    FULL OUTER JOIN orders o ON a.id = o.account_id;
-- Answer:
SELECT *
FROM accounts
    FULL JOIN sales_reps ON accounts.sales_rep_id = sales_reps.id -- If unmatched rows existed (they don't for this query), you could isolate them by adding the following line to the end of the query:
SELECT *
FROM accounts
    FULL JOIN sales_reps ON accounts.sales_rep_id = sales_reps.id
WHERE accounts.sales_rep_id IS NULL
    OR sales_reps.id IS NULL