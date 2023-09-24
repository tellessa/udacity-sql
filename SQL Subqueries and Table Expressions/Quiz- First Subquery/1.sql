SELECT DATE_TRUNC('day', occurred_at) AS day,
    channel,
    COUNT(*) event_count
FROM web_events
GROUP BY 1,
    2
ORDER BY 3 DESC;
-- Answer: same except one alias
SELECT DATE_TRUNC('day', occurred_at) AS day,
    channel,
    COUNT(*) as events
FROM web_events
GROUP BY 1,
    2
ORDER BY 3 DESC;