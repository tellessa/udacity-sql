-- Use DISTINCT to test if there are any accounts associated with more than sales rep.
SELECT DISTINCT a.name account,
    r.name region
FROM accounts a
    JOIN sales_reps s ON s.id = a.sales_rep_id
    JOIN region r ON r.id = s.region_id;
-- second query
SELECT DISTINCT id,
    name
FROM accounts;
-- Their answer:
-- Actually all of the sales reps have worked on more than one account. The fewest number of accounts any sales rep works on is 3. There are 50 sales reps, and they all have more than one account. Using DISTINCT in the second query assures that all of the sales reps are accounted for in the first query.
-- The number of unique groups of sales rep / name combinations
SELECT s.id,
    s.name,
    COUNT(*) num_accounts
FROM accounts a
    JOIN sales_reps s ON s.id = a.sales_rep_id
GROUP BY s.id,
    s.name
ORDER BY num_accounts;