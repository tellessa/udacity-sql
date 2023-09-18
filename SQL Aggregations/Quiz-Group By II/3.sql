-- Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.
SELECT s.name,
    w.channel,
    COUNT(w.channel)
FROM sales_reps s
    JOIN accounts a ON s.id = a.sales_rep_id
    JOIN web_events w ON w.account_id = a.id
GROUP BY 1,
    2
ORDER BY 3 DESC;
-- The key is to count the times a channel was used. You could do this as a total, but you can also do it after grouping by a different column, in this case the sales reps.
-- Connecting s and w requires
-- Accounts connects to sales_rep_id
-- w connects to account_id
-- Their answer:
SELECT s.name,
    w.channel,
    COUNT(*) num_events
FROM accounts a
    JOIN web_events w ON a.id = w.account_id
    JOIN sales_reps s ON s.id = a.sales_rep_id
GROUP BY s.name,
    w.channel
ORDER BY num_events DESC;