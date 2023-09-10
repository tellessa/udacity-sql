-- [x] JOINs: Need to join regions, orders and accounts
-- Can only join regions by way of sales_reps
-- [] WHERE: Filter out any rows where standard order quantity <= 100 AND
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
WHERE o.standard_qty > 100
    AND o.poster_qty > 50
ORDER BY 3;
-- initially forgot to specify the source table of poster_qty, but correct first try otherwise