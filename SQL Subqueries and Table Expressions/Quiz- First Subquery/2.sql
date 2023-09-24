SELECT *
FROM (
        SELECT DATE_TRUNC('day', occurred_at) AS day,
            channel,
            COUNT(*) event_count
        FROM web_events
        GROUP BY 1,
            2
        ORDER BY 3 DESC
    ) sub;
-- Answer: Mostly same
SELECT *
FROM (
        SELECT DATE_TRUNC('day', occurred_at) AS day,
            channel,
            COUNT(*) as events
        FROM web_events
        GROUP BY 1,
            2
        ORDER BY 3 DESC
    ) sub;