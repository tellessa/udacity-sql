-- How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?
-- 24 word question.
-- Final answer will be a count of the table showing all accounts meeting the criteria
-- We need to know the NAME of the account where SUM(standard_qty) is the greatest using MAX() or order by limit 1
-- What are total purchases? Just the count of the orders table?
-- We need to get a count of the orders table grouped by the account_id
-- Then we need to filter it down to only the rows that have more total purchases than that one.
-- Then count how many rows it has
HAVING COUNT(o.id) >
SELECT MAX(lifetime_std_qty) lifetime_std_qty
FROM (
        SELECT a.name account_name,
            SUM(o.standard_qty) lifetime_std_qty
        FROM accounts a
            JOIN orders o ON o.account_id = a.id
        GROUP BY 1
    ) t1;
-- We have to join on the amount being greater than the amount for a particular name.
-- If they asked for a table OF the accounts with more total purchases, that's one less step.
-- The below query gets the account which bought the most standard qty of paper
SELECT a.name account_name,
    SUM(o.standard_qty) lifetime_std_qty
FROM accounts a
    JOIN orders o ON o.account_id = a.id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;
-- The below query gets the total purchases for each account
SELECT a.name account_name,
    SUM(o.standard_qty) lifetime_std_qty
FROM accounts a
    JOIN orders o ON o.account_id = a.id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;
-- Finally, we want to know the total number of purchases for the account with the most standard qty of paper
SELECT a.name,
    COUNT(*)
FROM accounts a
    JOIN orders o ON o.account_id = a.id
GROUP BY 1
ORDER BY 2 DESC;
-- Can we MAX(lifetime_std_qty) and COUNT(*) of the orders in the same SELECT clause? Maybe with a left join where orders is the left table.
-- The below query gives us the total count ofr Core-Mark Holding
SELECT *
FROM (
        SELECT a.name account_name,
            SUM(o.standard_qty) lifetime_std_qty
        FROM accounts a
            JOIN orders o ON o.account_id = a.id
        GROUP BY 1
        ORDER BY 2 DESC
        LIMIT 1
    ) t1
    JOIN (
        SELECT a.name account_name,
            COUNT(*) total_purchases
        FROM accounts a
            JOIN orders o ON o.account_id = a.id
        GROUP BY 1
        ORDER BY 2 DESC
    ) t2 ON t1.account_name = t2.account_name;
-- Now we need to filter a table of all the counts to those that are greater than that 56
-- Having total_purchases > total_purchases of the row returned above, and if we are smart, we will modify the above to return a single value instead of a row
-- Finally count # rows (*) in that table.
-- The joins are actually the same, so the aggregation should be able to be done in the same select statement after all.
-- The first query had a limit 1; we'll still need the single value it was returning to filter this data
SELECT COUNT(*)
FROM (
        SELECT a.name account_name,
            COUNT(*) total_purchases,
            SUM(o.standard_qty) lifetime_std_qty
        FROM accounts a
            JOIN orders o ON o.account_id = a.id
        GROUP BY 1
        HAVING COUNT(*) > (
                -- Subquery that gets the total purchases for the account that has bought the most standard qty paper
                -- This runs, and outer query also runs, but not as a HAVING clause
                SELECT tot_purchases_top_std_qty
                FROM (
                        SELECT a.name,
                            COUNT(*) tot_purchases_top_std_qty,
                            SUM(o.standard_qty) lifetime_std_qty_top_std_qty
                        FROM accounts a
                            JOIN orders o ON o.account_id = a.id
                        GROUP BY 1
                        ORDER BY 3 DESC
                        LIMIT 1
                    ) t2
            )
        ORDER BY 2 DESC
    ) t1;
-- Outer query:
SELECT a.name account_name,
    COUNT(*) total_purchases,
    SUM(o.standard_qty) lifetime_std_qty
FROM accounts a
    JOIN orders o ON o.account_id = a.id
GROUP BY 1
ORDER BY 2 DESC;
-- Putting in the literal 56 instead of the subquery works.
-- The subquery is not returning 56 though, it's returning 41617
-- Answer:
SELECT COUNT(*)
FROM (
        SELECT a.name
        FROM orders o
            JOIN accounts a ON a.id = o.account_id
        GROUP BY 1
        HAVING SUM(o.total) > (
                SELECT total
                FROM (
                        SELECT a.name act_name,
                            SUM(o.standard_qty) tot_std,
                            SUM(o.total) total
                        FROM accounts a
                            JOIN orders o ON o.account_id = a.id
                        GROUP BY 1
                        ORDER BY 2 DESC
                        LIMIT 1
                    ) inner_tab
            )
    ) counter_tab;