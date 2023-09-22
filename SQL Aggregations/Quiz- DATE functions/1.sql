-- Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. Do you notice any trends in the yearly sales totals?
-- No join needed
SELECT total_amt_usd,
    DATE_TRUNC('year', occurred_at)
FROM orders
GROUP BY total_amt_usd,
    occurred_at
ORDER BY 1 DESC;
-- answer
SELECT DATE_PART('year', occurred_at) ord_year,
    SUM(total_amt_usd) total_spent
FROM orders
GROUP BY 1
ORDER BY 2 DESC;
-- It makes sense that he grouped by the date part and performed the sum function on the results of that group by
-- The DATE_TRUNC() version actually yields very similar results, but it shows a timestamp of that year's first moment, down to the second, instead of just the year.
-- I was thrown off by the word total, didn't realize I was supposed to sum the values myself, and this was made worse by believing that data_trunc/date_part was an agg function, and therefore I needed the other column to not be so that I could group by it.