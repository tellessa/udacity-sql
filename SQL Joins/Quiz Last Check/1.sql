SELECT -- In their last example, they made region the initial from, as opposed to my intuition to start with sales_rep.
SELECT r.name region,
    s.name rep,
    a.name account
FROM region r
    JOIN sales_reps s ON r.id = s.region_id
    AND r.name = "Midwest" -- Need to only join the Midwest region
    JOIN accounts a ON s.id = a.sales_rep_id
ORDER BY 3;
-- The AND should have been a WHERE
-- Next I tried this but it told me s is missing
SELECT r.name region,
    s.name rep,
    a.name account
FROM region r
    JOIN accounts a ON s.id = a.sales_rep_id
    JOIN sales_reps s ON r.id = s.region_id
WHERE r.name = "Midwest"
ORDER BY 3;
-- Now it's reversed: they're using s as the primary from table, whereas last time they used r.
SELECT r.name region,
    s.name rep,
    a.name account
FROM sales_reps s
    JOIN accounts a ON s.id = a.sales_rep_id
    JOIN region r ON r.id = s.region_id
WHERE r.name = "Midwest"
ORDER BY 3;
-- My double quotes around Midwest were being misinterpreted.
SELECT r.name region,
    s.name rep,
    a.name account
FROM sales_reps s
    JOIN region r ON s.region_id = r.id
    JOIN accounts a ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest'
ORDER BY a.name;
-- Their answer
SELECT r.name region,
    s.name rep,
    a.name account
FROM sales_reps s
    JOIN region r ON r.id = s.region_id
    JOIN accounts a ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest'
ORDER BY 3;