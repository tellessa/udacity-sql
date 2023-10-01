-- He summed the total column, whereas I was trying to sum the total number of purchases
-- He bolded the word total, which should have pointed me to the right column; but I misinterpreted it as something that could be obtained using COUNT(*).
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
-- We can use a column in the Having clause that we didn't use in the SELECT clause, but we must group by something in the select for that to even make sense.
-- The innermost table gives us the account names and their sums of standard qtys and totals. standard_qty is only included so that it can be used to order from greatest to least by that column. After the ordering is done, we only want the top row, which is what this table's result set ends up being limited to.
-- Having gotten the top row, we actually throw away the act name and tot_std from the second-to-deepest query, selecting only the total column.
-- The second-to-highest query selects the account name and groups by it. Grouping in this way filters the a.name to the number of unique names there are. The HAVING clause further filters the result set to only the rows where the sum of the total column is greater than the second-to-deepest queries result. Remember, that query gave us the total for the account with the highest tot_std.
-- Finally, the outermost query just gives a simple count of the number of rows returned by the second-to-highest query.