-- Determine the number of times a particular channel was used in the web_events table for each region. Your final table should have three columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.
SELECT r.name,
    w.channel,
    COUNT(*) num_events
FROM region r
    JOIN sales_reps s ON s.region_id = r.id
    JOIN accounts a ON s.id = a.sales_rep_id
    JOIN web_events w ON a.id = w.account_id
GROUP BY r.name,
    w.channel
ORDER BY num_events DESC;
-- We can connect web_events.account_id to a.id
-- And a.sales_rep_id to s.id
-- And s.region_id to r.id
-- THeir answer:
SELECT r.name,
    w.channel,
    COUNT(*) num_events
FROM accounts a
    JOIN web_events w ON a.id = w.account_id
    JOIN sales_reps s ON s.id = a.sales_rep_id
    JOIN region r ON r.id = s.region_id
GROUP BY r.name,
    w.channel
ORDER BY num_events DESC;