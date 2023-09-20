-- Which accounts used facebook as a channel to contact customers more than 6 times?
-- Need to join accounts to web_events through w's foreign key "account_id"
SELECT a.id,
    a.name,
    -- channel,
    COUNT(*) channel_usages
FROM accounts a
    JOIN web_events w ON a.id = w.account_id
WHERE w.channel = "facebook"
GROUP BY a.id,
    a.name -- channel
HAVING COUNT(*) > 6
ORDER BY 3 DESC;
-- answer: I didn't get that the filter for only the facebook channel needed to be in the having clause
-- I also missed prefixing channel with the table alias, and used a different alias for the count(*)
SELECT a.id,
    a.name,
    w.channel,
    COUNT(*) use_of_channel
FROM accounts a
    JOIN web_events w ON a.id = w.account_id
GROUP BY a.id,
    a.name,
    w.channel
HAVING COUNT(*) > 6
    AND w.channel = 'facebook'
ORDER BY use_of_channel;