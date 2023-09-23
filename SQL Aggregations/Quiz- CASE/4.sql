-- We would now like to perform a similar calculation to the first, but we want to obtain the total amount spent by customers only in 2016 and 2017. Keep the same levels as in the previous question. Order with the top spending customers listed first.
SELECT a.name,
    SUM(total_amt_usd) total_spent,
    CASE
        WHEN SUM(total_amt_usd) > 200000 THEN 'top'
        WHEN SUM(total_amt_usd) > 100000 THEN 'middle'
        ELSE 'low'
    END AS customer_level
FROM orders o
    JOIN accounts a ON o.account_id = a.id
WHERE DATE_TRUNC('year', o.occurred_at) BETWEEN '2016-01-01' AND '2018-01-01'
GROUP BY a.name
ORDER BY 2 DESC;
-- FIrst one might be right, but I started trying to show the year in the results and got errors:
-- Turns out my chosen alias, year, is a function keyword or something of that sort?
SELECT a.name,
    o.occurred_at year_,
    SUM(total_amt_usd) total_spent,
    CASE
        WHEN SUM(total_amt_usd) > 200000 THEN 'top'
        WHEN SUM(total_amt_usd) > 100000 THEN 'middle'
        ELSE 'low'
    END AS customer_level
FROM orders o
    JOIN accounts a ON o.account_id = a.id
WHERE DATE_TRUNC('year', o.occurred_at) BETWEEN '2016-01-01' AND '2018-01-01'
GROUP BY a.name,
    2
ORDER BY 3 DESC;
-- Answer: returns 322 results, and so did my first answer. FOr some reason my second answer returns 3781 results.
SELECT a.name,
    SUM(total_amt_usd) total_spent,
    CASE
        WHEN SUM(total_amt_usd) > 200000 THEN 'top'
        WHEN SUM(total_amt_usd) > 100000 THEN 'middle'
        ELSE 'low'
    END AS customer_level
FROM orders o
    JOIN accounts a ON o.account_id = a.id
WHERE occurred_at > '2015-12-31'
GROUP BY 1
ORDER BY 2 DESC;