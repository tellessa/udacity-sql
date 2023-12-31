-- Which account used facebook most as a channel?
SELECT a.id,
    a.name,
    w.channel,
    COUNT(*) use_of_channel
FROM accounts a
    JOIN web_events w ON a.id = w.account_id
GROUP BY a.id,
    a.name,
    w.channel
HAVING w.channel = 'facebook'
ORDER BY use_of_channel DESC
LIMIT 1;
-- answer:
SELECT a.id,
    a.name,
    w.channel,
    COUNT(*) use_of_channel
FROM accounts a
    JOIN web_events w ON a.id = w.account_id
WHERE w.channel = 'facebook'
GROUP BY a.id,
    a.name,
    w.channel
ORDER BY use_of_channel DESC
LIMIT 1;