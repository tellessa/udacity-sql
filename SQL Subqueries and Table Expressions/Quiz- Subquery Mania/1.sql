-- Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
-- subquery:
-- Join the sales reps to the region
-- Join the sales rep to the orders through accounts
-- We need 1 sales rep per region
-- group by r.name
-- Can't do max and sum at the same time.
-- So far this query only gives us the sums, but now we want to filter down to only the top one per region
SELECT region,
    sales_rep,
    MAX(sum_total_sales_usd)
FROM (
        SELECT r.name region,
            s.name sales_rep,
            SUM(o.total_amt_usd) sum_total_sales_usd
        FROM sales_reps s
            JOIN accounts a ON s.id = a.sales_rep_id
            JOIN region r ON r.id = s.region_id
            JOIN orders o ON o.account_id = a.id
        GROUP BY 1,
            2
    ) sub
GROUP BY 1,
    2
ORDER BY 3 DESC
LIMIT 4;
-- Can't know the max without first knowing the sum
-- Problem: When I group by the region alone, I get 4 rows as desired, but it's lacking the sales rep column
-- But when I include and group by the sales rep column, I get 50 rows back, regardless of which column is placed first in the outer group by clause
-- Answer: He grouped by rep first, then region; I did the opposite, but to me the results look similar if not identical.
-- He ends up using 2 subqueries at the second level;
-- not only that but one of them (t2) has its own subquery (t1), which mostly matches the third subquery (t3), except t3 has an order by clause.;
-- First:
SELECT s.name rep_name,
    r.name region_name,
    SUM(o.total_amt_usd) total_amt
FROM sales_reps s
    JOIN accounts a ON a.sales_rep_id = s.id
    JOIN orders o ON o.account_id = a.id
    JOIN region r ON r.id = s.region_id
GROUP BY 1,
    2
ORDER BY 3 DESC;
-- Second: Goal is to pull the max for each region
SELECT region_name,
    MAX(total_amt) total_amt
FROM(
        SELECT s.name rep_name,
            r.name region_name,
            SUM(o.total_amt_usd) total_amt
        FROM sales_reps s
            JOIN accounts a ON a.sales_rep_id = s.id
            JOIN orders o ON o.account_id = a.id
            JOIN region r ON r.id = s.region_id
        GROUP BY 1,
            2
    ) t1
GROUP BY 1;
-- Final:
SELECT t3.rep_name,
    t3.region_name,
    t3.total_amt
FROM(
        SELECT region_name,
            MAX(total_amt) total_amt
        FROM(
                SELECT s.name rep_name,
                    r.name region_name,
                    SUM(o.total_amt_usd) total_amt
                FROM sales_reps s
                    JOIN accounts a ON a.sales_rep_id = s.id
                    JOIN orders o ON o.account_id = a.id
                    JOIN region r ON r.id = s.region_id
                GROUP BY 1,
                    2
            ) t1
        GROUP BY 1
    ) t2
    JOIN (
        SELECT s.name rep_name,
            r.name region_name,
            SUM(o.total_amt_usd) total_amt
        FROM sales_reps s
            JOIN accounts a ON a.sales_rep_id = s.id
            JOIN orders o ON o.account_id = a.id
            JOIN region r ON r.id = s.region_id
        GROUP BY 1,
            2
        ORDER BY 3 DESC
    ) t3 ON t3.region_name = t2.region_name
    AND t3.total_amt = t2.total_amt;
-- The first level 2 query gets the region name and max total amount
-- The second level 2 query gets the rep name, region name and Sum of the total amount in usd.
-- There will be 1 row of the total amount usd column that matches the max total amount column, for each group.
-- We join there, where the region names match and so do the total amounts.
-- The reason for the double nested query is that we can't get the max until we get the sum, in other words, not in the same level of subquery nesting.
-- The reason for the top level query is that we somehow need to merge the sales rep names back together with
-- Which sales rep goes with that total amount and region? that's what our second level 2 subquery is for; it tracks the connection of sales rep to total_amt/region combos. The region and total amt have to match for a row to be joined.
-- I tested and this query alone could have gotten the region name and total amt, but would have been missing the sales rep:
SELECT region_name,
    total_amt
FROM(
        SELECT region_name,
            MAX(total_amt) total_amt
        FROM(
                SELECT s.name rep_name,
                    r.name region_name,
                    SUM(o.total_amt_usd) total_amt
                FROM sales_reps s
                    JOIN accounts a ON a.sales_rep_id = s.id
                    JOIN orders o ON o.account_id = a.id
                    JOIN region r ON r.id = s.region_id
                GROUP BY 1,
                    2
            ) t1
        GROUP BY 1
    ) t2