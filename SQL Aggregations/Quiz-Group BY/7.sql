-- Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from fewest reps to most reps.
SELECT r.name region,
    COUNT(s.id) qty_sales_reps
FROM sales_reps s
    JOIN region r ON s.region_id = r.id
GROUP BY 1
ORDER BY 2;
-- Their answer:
SELECT r.name,
    COUNT(*) num_reps
FROM region r
    JOIN sales_reps s ON r.id = s.region_id
GROUP BY r.name
ORDER BY num_reps;
-- Same except for aliases and using count of par