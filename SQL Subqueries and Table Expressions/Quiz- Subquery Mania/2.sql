-- For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed?
-- Find the region with the largest sum of sales in usd
-- Get the total count of orders for that region
-- Sum the sales for all regions, by running a sum() function on 4 sets of rows which are grouped by region
-- I ran this query and got Northeast as the max just looking visually.
-- If there is a group by, we won't get just the max
-- However, if we group by and order by with a limit 1, we'll keep the region and get the max.
-- Way 1
SELECT region_name,
    MAX(total_amt) total_amt
FROM (
        SELECT r.name region_name,
            SUM(o.total_amt_usd) total_amt
        FROM sales_reps s
            JOIN accounts a ON s.id = a.sales_rep_id
            JOIN region r ON r.id = s.region_id
            JOIN orders o ON o.account_id = a.id
        GROUP BY 1
    ) t1
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;
-- Way 2
SELECT r.name region_name,
    SUM(o.total_amt_usd) total_amt
FROM sales_reps s
    JOIN accounts a ON s.id = a.sales_rep_id
    JOIN region r ON r.id = s.region_id
    JOIN orders o ON o.account_id = a.id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;
-- I easily have two methods of knowing the region with the largest sum of sales
-- Now I need to merge that with a count of how many orders were placed in that region.
SELECT r.name region_name,
    COUNT(*)
FROM sales_reps s
    JOIN accounts a ON s.id = a.sales_rep_id
    JOIN region r ON r.id = s.region_id
    JOIN orders o ON o.account_id = a.id
GROUP BY 1;
-- Again, by running the subquery I can see the northeast has 2357 orders. No need to order though, rather, join it to my other subqueries results, on the region.
-- I'll select total_amt, region, and count of orders from my merged table
-- I'll inner join on the region name
SELECT t2.region_name,
    t1.total_amt,
    t2.total_count
FROM (
        -- SELECT r.name region_name,
        --     SUM(o.total_amt_usd) total_amt
        -- FROM sales_reps s
        --     JOIN accounts a ON s.id = a.sales_rep_id
        --     JOIN region r ON r.id = s.region_id
        --     JOIN orders o ON o.account_id = a.id
        -- GROUP BY 1
        -- ORDER BY 2 DESC
        -- LIMIT 1
        SELECT region_name,
            MAX(total_amt) total_amt
        FROM (
                SELECT r.name region_name,
                    SUM(o.total_amt_usd) total_amt
                FROM sales_reps s
                    JOIN accounts a ON s.id = a.sales_rep_id
                    JOIN region r ON r.id = s.region_id
                    JOIN orders o ON o.account_id = a.id
                GROUP BY 1
            ) t1
        GROUP BY 1
        ORDER BY 2 DESC
        LIMIT 1
    ) t1
    JOIN (
        SELECT r.name region_name,
            COUNT(*) total_count
        FROM sales_reps s
            JOIN accounts a ON s.id = a.sales_rep_id
            JOIN region r ON r.id = s.region_id
            JOIN orders o ON o.account_id = a.id
        GROUP BY 1
    ) t2 ON t2.region_name = t1.region_name;