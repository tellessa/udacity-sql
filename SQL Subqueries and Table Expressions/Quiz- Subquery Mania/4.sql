-- For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?
-- On question 3 we got the customers (a.name) who had a higher sum of their total than the top total
-- Do a limit 1 after an order by the total amount usd over the lifetime, which means the sum, grouped by the a.name.
-- 1. Brought in the orders and web events tables.
-- 2. Wrote a query that can give me the account name of the account that spent the most.
SELECT a.id act_id
FROM accounts a
    JOIN web_events w ON w.account_id = a.id
    JOIN orders o ON o.account_id = a.id
GROUP BY 1
ORDER BY SUM(o.total_amt_usd) DESC
LIMIT 1;
-- We know we can get a count of web events grouped by channel;
-- We also need to do this for only the web events with the account id belonging to the account from the first query
-- Web events have account id's, so we should really just return the account ID in the subquery we already figured out.
-- A count on a group by
-- 3. I have an outer query to give me a count of web events for each (grouped by) channel
SELECT channel COUNT(*)
FROM web_events w
GROUP BY 1;
-- 4. I added in the account id because I need it broken down by account id before it's broken down by channel.
SELECT channel,
    account_id,
    COUNT(*)
FROM web_events w
GROUP BY 1,
    2;
-- 5. Try to filter out all the other account ids that don't match the one returned by the first query we figured out.
SELECT channel,
    account_id,
    COUNT(*) num_events
FROM web_events w
GROUP BY 1,
    2
HAVING account_id = (
        SELECT a.id act_id
        FROM accounts a
            JOIN web_events w ON w.account_id = a.id
            JOIN orders o ON o.account_id = a.id
        GROUP BY 1
        ORDER BY SUM(o.total_amt_usd) DESC
        LIMIT 1
    );
-- 6. it's erroring near ";"
-- THe inner query runs alone
-- The outer query also does if we remove the Having clause.
-- Do I need another join?
-- Nope, I still had a semicolon inside my subquery parens, which no doubt is a common problem when cutting and pasting.
-- 7. Now when I test the account id matches 4211 which is good;
-- I also get a count of web events
-- Answer:
SELECT a.name,
    w.channel,
    COUNT(*)
FROM accounts a
    JOIN web_events w ON a.id = w.account_id
    AND a.id = (
        SELECT id
        FROM (
                SELECT a.id,
                    a.name,
                    SUM(o.total_amt_usd) tot_spent
                FROM orders o
                    JOIN accounts a ON a.id = o.account_id
                GROUP BY a.id,
                    a.name
                ORDER BY 3 DESC
                LIMIT 1
            ) inner_table
    )
GROUP BY 1,
    2
ORDER BY 3 DESC;
-- Their result set matches mine other than they used the account name instead of its id, and ordered by 3 DESC.
-- Theirs:
-- name	channel	count
-- EOG Resources	direct	44
-- EOG Resources	organic	13
-- EOG Resources	adwords	12
-- EOG Resources	facebook	11
-- EOG Resources	twitter	5
-- EOG Resources	banner	4
-- Mine:
-- account_id	channel	num_events
-- 4211	direct	44
-- 4211	organic	13
-- 4211	adwords	12
-- 4211	facebook	11
-- 4211	twitter	5
-- 4211	banner	4