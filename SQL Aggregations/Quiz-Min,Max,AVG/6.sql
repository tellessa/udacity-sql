-- My best guess based on googling
SELECT percentile_cont(0.5) WITHIN GROUP (
        ORDER BY total_amt_usd
    ) median_usd
FROM orders;
-- Their answer, which they say is a rough solution
SELECT *
FROM (
        SELECT total_amt_usd
        FROM orders
        ORDER BY total_amt_usd
        LIMIT 3457
    ) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;