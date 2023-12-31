SELECT r.name region,
    a.name account,
    o.total_amt_usd /(o.total + 0.01) unit_price
FROM region r
    JOIN sales_reps s ON s.region_id = r.id
    JOIN accounts a ON a.sales_rep_id = s.id
    JOIN orders o ON o.account_id = a.id
WHERE o.standard_qty > 100
    AND o.poster_qty > 50
ORDER BY 3 DESC;