SELECT r.name,
    COUNT(o.total) total_orders
FROM sales_reps s
    JOIN accounts a ON a.sales_rep_id = s.id
    JOIN orders o ON o.account_id = a.id
    JOIN region r ON r.id = s.region_id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (
        SELECT MAX(total_amt)
        FROM (
                SELECT r.name region_name,
                    SUM(o.total_amt_usd) total_amt
                FROM sales_reps s
                    JOIN accounts a ON a.sales_rep_id = s.id
                    JOIN orders o ON o.account_id = a.id
                    JOIN region r ON r.id = s.region_id
                GROUP BY r.name
            ) sub
    );
-- They used a subquery to return a single value
-- They used that value to filter out the results of an aggregation to only the row that matched that single value.
-- I didn't know you can CALL an aggregate function in the Having clause. I tested and you can also refer to the result of calling a different aggregate function in the SELECT clause.
-- another lesson says, "Essentially, any time you want to perform a WHERE on an element of your query that was created by an aggregate, you need to use HAVING instead."
-- udacity GPT says, "HAVING" is used to filter the results of a query based on a condition that applies to groups created by the "GROUP BY" clause. The condition in the "HAVING" clause is a boolean expression that determines which groups are included in the final result set. If the boolean expression evaluates to true for a group, then the group is included; otherwise, it is excluded."
-- He selected 4 different counts, one for each region, but he didn't want all 4, so he used a having clause to filter them. He wanted to filter to only the region with the top quantity
-- Knowing that requires its own subquery to get the sum before getting the max.
-- The outer subquery of this having clause doesn't need an alias because it is being used as a literal/single value rather than as a table from which to select.
-- Having came in handy because we knew we could get region and a COUNT of total orders right off the bat, but our target data was a subset of that and in order to subset it, we could use having