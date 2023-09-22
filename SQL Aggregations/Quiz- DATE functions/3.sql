-- Which year did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly represented by the dataset?
SELECT DATE_PART('year', occurred_at) ord_month,
    COUNT(*) num_orders
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC;
-- answer:
SELECT DATE_PART('year', occurred_at) ord_year,
    COUNT(*) total_sales
FROM orders
GROUP BY 1
ORDER BY 2 DESC;