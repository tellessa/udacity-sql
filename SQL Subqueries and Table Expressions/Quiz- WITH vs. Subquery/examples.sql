-- Before
SELECT channel,
    AVG(events) AS average_events
FROM (
        SELECT DATE_TRUNC('day', occurred_at) AS day,
            channel,
            COUNT(*) as events
        FROM web_events
        GROUP BY 1,
            2
    ) sub
GROUP BY channel
ORDER BY 2 DESC;
-- After
WITH events AS (
    SELECT DATE_TRUNC('day', occurred_at) AS day,
        channel,
        COUNT(*) as events
    FROM web_events
    GROUP BY 1,
        2
)
SELECT channel,
    AVG(events) AS average_events
FROM events
GROUP BY channel
ORDER BY 2 DESC;
-- Programmers created sql, and it's just like programmers to store complicated logic in variables or functions before using it to make things like simpler and more modular.
-- Multiple CTEs:
WITH table1 AS (
    SELECT *
    FROM web_events
),
table2 AS (
    SELECT *
    FROM accounts
)
SELECT *
FROM table1
    JOIN table2 ON table1.account_id = table2.id;