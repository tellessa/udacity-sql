-- Who was the primary contact associated with the earliest web_event?
-- We need to select the primary contact from the row with the earliest web event
SELECT a.primary_poc
FROM web_events w
    Join accounts a ON w.account_id = a.id
ORDER BY occurred_at ASC
LIMIT 1;
-- We can get the right row by using LIMIT 1 after an order by
-- Their answer: almost word for word the same
SELECT a.primary_poc
FROM web_events w
    JOIN accounts a ON a.id = w.account_id
ORDER BY w.occurred_at
LIMIT 1;