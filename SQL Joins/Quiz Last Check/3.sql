SELECT r.name region,
    s.name rep,
    a.name account
FROM sales_reps s
    JOIN region r ON r.id = s.region_id
    JOIN accounts a ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest'
    AND s.name LIKE '% K%'
ORDER BY 3;
-- Didn't realize I could do '% K%' to show that I am looking for a K after the first name. Was stuck on that part but otherwise knew the right answer.