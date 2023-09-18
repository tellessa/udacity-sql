SELECT a.name,
    AVG(o.standard_qty) avg_std,
    AVG(o.gloss_qty) avg_gloss,
    AVG(o.poster_qty) avg_poster
FROM accounts a
    JOIN orders o ON a.id = o.account_id
GROUP BY name
ORDER BY name;