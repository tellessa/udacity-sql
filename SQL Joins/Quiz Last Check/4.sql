SELECT r.name region,
    a.name account,
    o.total_amt_usd / (o.total + 0.01) unit_price
FROM orders o
    JOIN accounts a ON o.account_id = a.id
    JOIN sales_reps s ON a.sales_rep_id = s.id
    JOIN region r ON r.id = s.region_id
WHERE o.standard_qty > 100
ORDER BY 3 DESC;
-- [x] JOINs: Need to join regions, orders and accounts
-- Can only join regions by way of sales_reps
-- [] WHERE: Filter out any rows where standard order quantity <= 100
-- Transformations: Need to add 0.01 to denominator to
-- Ran correctly on first test! 4509 results
-- Their answer:
SELECT r.name region,
    a.name account,
    o.total_amt_usd /(o.total + 0.01) unit_price
FROM region r
    JOIN sales_reps s ON s.region_id = r.id
    JOIN accounts a ON a.sales_rep_id = s.id
    JOIN orders o ON o.account_id = a.id
WHERE o.standard_qty > 100;
-- I joined the sales reps table by matching the account's sales_rep id to the sales_reps' id, but they joined it by matching the region id to the region's id
-- Looks like they return the same thing.