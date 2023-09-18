SELECT AVERAGE(standard_amt_usd) avg_std_usd,
    AVERAGE(gloss_amt_usd) avg_gloss_usd,
    AVERAGE(poster_amt_usd) avg_poster_usd,
    AVERAGE(standard_qty) avg_std_qty,
    AVERAGE(gloss_qty) avg_gloss_qty,
    AVERAGE(poster_qty) avg_poster_qty,
    FROM orders;
-- Mine using AVG instead and selecting qtys first, then costs- it had a trailing comma which is invalid syntax
SELECT AVG(standard_qty) avg_std_qty,
    AVG(gloss_qty) avg_gloss_qty,
    AVG(poster_qty) avg_poster_qty,
    AVG(standard_amt_usd) avg_std_usd,
    AVG(gloss_amt_usd) avg_gloss_usd,
    AVG(poster_amt_usd) avg_poster_usd,
    FROM orders;
-- Their answer
SELECT AVG(standard_qty) mean_standard,
    AVG(gloss_qty) mean_gloss,
    AVG(poster_qty) mean_poster,
    AVG(standard_amt_usd) mean_standard_usd,
    AVG(gloss_amt_usd) mean_gloss_usd,
    AVG(poster_amt_usd) mean_poster_usd
FROM orders;