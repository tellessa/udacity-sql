-- accounts have name
-- web_events have account_id
-- Initial
-- SELECT accounts.primary_poc, web_events.occurred_at, web_events.channel, accounts.name
-- FROM accounts a
-- JOIN web_events w
-- ON a.id = w.account_id
-- WHERE a.name = 'Walmart'
-- ;
-- Revised after errors
SELECT accounts.primary_poc,
    web_events.occurred_at,
    web_events.channel,
    accounts.name
FROM accounts
    JOIN web_events ON accounts.id = web_events.account_id
WHERE accounts.name = 'Walmart';

-- Their answer
SELECT a.primary_poc,
    w.occurred_at,
    w.channel,
    a.name
FROM web_events w
    JOIN accounts a ON w.account_id = a.id
WHERE a.name = 'Walmart';