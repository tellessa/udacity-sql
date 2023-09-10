SELECT r.name region,
    s.name rep,
    a.name account
FROM sales_reps s
    JOIN region r ON r.id = s.region_id
    JOIN accounts a ON a.sales_rep_id = s.id
WHERE s.name LIKE 'S%'
    AND r.name = 'Midwest'
ORDER BY 3;
-- Query at least succeeded on first try!
-- Matches theirs with a few small stylistic differences!