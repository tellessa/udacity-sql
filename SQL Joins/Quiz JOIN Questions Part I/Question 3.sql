-- Name of each region for every order
-- Need to connect regions to orders by way of sales reps and accounts
SELECT r.name region,
    a.name account,
    o.total_amt_usd / (o.total + 0.01) unit_price -- total_amt_usd / total as unit_price
FROM sales_reps s -- Following this join
    JOIN accounts a ON s.id = a.sales_rep_id
    JOIN orders o ON a.id = o.account_id
    JOIN region r ON s.region_id = r.id;
-- Got the right columns back
-- Didn't actually select anything from the sales reps columns, but still used it's PK and FK as a bridge from region to accounts to orders.
-- Go from order
-- From order I need to divide total_amt_usd by total + 0.01
-- Their answer:
SELECT r.name region,
    a.name account,
    o.total_amt_usd /(o.total + 0.01) unit_price
FROM region r
    -- matches
    JOIN sales_reps s ON s.region_id = r.id
    -- matches
    JOIN accounts a ON a.sales_rep_id = s.id
    -- matches
    JOIN orders o ON o.account_id = a.id;
-- Conclusion: they started from region for some reason