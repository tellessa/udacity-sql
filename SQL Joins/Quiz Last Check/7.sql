SELECT DISTINCT a.name account,
    we.channel
FROM accounts a
    JOIN web_events we ON a.id = we.account_id
WHERE a.id = 1001;
-- Ran first try