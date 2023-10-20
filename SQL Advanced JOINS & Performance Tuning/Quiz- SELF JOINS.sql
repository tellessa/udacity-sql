SELECT w1.id AS w1_id,
    w1.account_id AS w1_account_id,
    w1.occurred_at AS w1_occurred_at,
    w1.channel AS w1_channel,
    w2.id AS w2_id,
    w2.account_id AS w2_account_id,
    w2.occurred_at AS w2_occurred_at,
    w2.channel AS w2_channel
FROM web_events w1
    LEFT JOIN web_events w2 ON w1.account_id = w2.account_id
    AND w2.occurred_at > w1.occurred_at
    AND w2.occurred_at <= w1.occurred_at + INTERVAL '1 day'
ORDER BY w1.account_id,
    w1.occurred_at;
-- Answer: I ordered by w1's occurred at instead of w2's.
-- For a given output row, the occurred at's don't necessarily match
-- We want to create a row for each time an event occurred after another event but before 1 day had passed.
SELECT we1.id AS we_id,
    we1.account_id AS we1_account_id,
    we1.occurred_at AS we1_occurred_at,
    we1.channel AS we1_channel,
    we2.id AS we2_id,
    we2.account_id AS we2_account_id,
    we2.occurred_at AS we2_occurred_at,
    we2.channel AS we2_channel
FROM web_events we1
    LEFT JOIN web_events we2 ON we1.account_id = we2.account_id
    AND we1.occurred_at > we2.occurred_at
    AND we1.occurred_at <= we2.occurred_at + INTERVAL '1 day'
ORDER BY we1.account_id,
    we2.occurred_at;