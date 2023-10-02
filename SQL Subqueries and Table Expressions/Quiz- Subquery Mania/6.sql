-- What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.
-- 1. Think about what literals you'll need to fulfill the criteria:
--     a. the average spent of all orders
-- 2. Think about the intermediate table(s) you need to query from- They're describing a table of companies that spent more per order, on average, than the average of all orders.
--     a. if we treat "average of all orders" as though it were a constant, we can focus on finding the rows where average amt spent per order is greater than it.
-- What is the average amount to spend on an order?
-- What is the average amount spent on an order when grouping by company?
-- Which of those avg_amt_spent rows exceed the average of the table as a whole?
-- select the name and average amount spent for those rows
-- Concrete queries by step:
-- What is the average amount to spend on an order?
SELECT AVG(o.total_amt_usd)
FROM accounts a
    JOIN orders o on a.id = o.account_id;
-- returns 3348
-- What is the average amount spent on an order when grouping by company?
SELECT a.name,
    AVG(o.total_amt_usd)
FROM accounts a
    JOIN orders o on a.id = o.account_id
GROUP BY 1
ORDER BY 2 DESC;
-- Which of those avg_amt_spent rows exceed the average of the table as a whole?
SELECT a.name,
    AVG(o.total_amt_usd)
FROM accounts a
    JOIN orders o on a.id = o.account_id
GROUP BY 1
HAVING AVG(o.total_amt_usd) > (
        SELECT AVG(o.total_amt_usd)
        FROM accounts a
            JOIN orders o on a.id = o.account_id
    ) t1
ORDER BY 2 DESC;
-- Like in question 5, the question sounded like it wanted one average per each of the filtered rows
-- They actually wanted one average of the total of the filtered rows
-- After knowing that, before finishing reading the solution:
SELECT AVG(avg_amt)
FROM (
        SELECT a.name,
            AVG(o.total_amt_usd) avg_amt
        FROM accounts a
            JOIN orders o on a.id = o.account_id
        GROUP BY 1
        HAVING AVG(o.total_amt_usd) > (
                SELECT AVG(o.total_amt_usd)
                FROM accounts a
                    JOIN orders o on a.id = o.account_id
            )
        ORDER BY 2 DESC
    );
-- Their answer:
SELECT AVG(avg_amt)
FROM (
        SELECT o.account_id,
            AVG(o.total_amt_usd) avg_amt
        FROM orders o
        GROUP BY 1
        HAVING AVG(o.total_amt_usd) > (
                SELECT AVG(o.total_amt_usd) avg_all
                FROM orders o
            )
    ) temp_table;
-- I joined  accounts in unnecessarily. Removing that, my answer would have looked almost the same as theirs:
SELECT AVG(avg_amt)
FROM (
        SELECT o.account_id,
            AVG(o.total_amt_usd) avg_amt
        FROM orders o
        GROUP BY 1
        HAVING AVG(o.total_amt_usd) > (
                SELECT AVG(o.total_amt_usd)
                FROM orders o
            )
    ) t1;