-- Need to find the max (equates to most recent, while min is the oldest) value in we.occurred_at.
-- Then find the channel in that same row.
-- SELECT the date, channel and account name
-- For account name, we join on we.account_id = a.id
-- My solution, which for some reason is not showing up in order;
SELECT a.name account,
    we.channel,
    MAX(we.occurred_at)
FROM web_events we
    JOIN accounts a ON we.account_id = a.id
GROUP BY occurred_at,
    account,
    channel;
-- Their solution:
-- My conclusion: One way to get the max is by ordering by that column, then limiting to 1.
SELECT w.occurred_at,
    w.channel,
    a.name
FROM web_events w
    JOIN accounts a ON w.account_id = a.id
ORDER BY w.occurred_at DESC
LIMIT 1;
-- What I learned:
-- Use ORDER BY with LIMIT 1: This approach is useful when you need to retrieve the maximum value of a column along with other related information from the same row. By sorting the column in descending order and limiting the result to 1, you can obtain the row with the maximum value. This method is more flexible and can be used in various scenarios.
-- Use MAX() function: The MAX() function is specifically designed to find the maximum value of a column. It is a more concise and direct way to retrieve the maximum value without the need for sorting or limiting the result. This method is often preferred when you only need the maximum value and not the other related information from the same row.
-- In summary, use MAX() if you only need to get back one value
-- Use ORDER BY x DESC LIMIT 1 when you need additional info from that row.
-- Additional thoughts: From an Excel user's perspective, it doesn't really make sense to put the max of a column into the same row as unaggregated data.
-- On the other hand if we group by the other two columns after the initial group by, I'm not sure what that does.
-- TODO: Understand how multiple arguments to the group by clause are parsed.