SELECT a.name,
    AVG(o.standard_amt_usd) avg_std,
    AVG(o.gloss_amt_usd) avg_gloss,
    AVG(o.poster_amt_usd) avg_post
FROM accounts a
    JOIN orders o ON a.id = o.account_id
GROUP BY name
ORDER BY name;
-- Their answer:
SELECT a.name,
    AVG(o.standard_amt_usd) avg_stand,
    AVG(o.gloss_amt_usd) avg_gloss,
    AVG(o.poster_amt_usd) avg_post
FROM accounts a
    JOIN orders o ON a.id = o.account_id
GROUP BY a.name;