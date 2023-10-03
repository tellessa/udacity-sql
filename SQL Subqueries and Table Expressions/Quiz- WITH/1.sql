WITH t1 AS (
    SELECT s.name rep_name,
        r.name region_name,
        SUM(o.total_amt_usd) total_amt
    FROM sales_reps s
        JOIN accounts a ON a.sales_rep_id = s.id
        JOIN orders o ON o.account_id = a.id
        JOIN region r ON r.id = s.region_id
    GROUP BY 1,
        2
),
t2 AS (
    SELECT region_name,
        MAX(total_amt) total_amt
    FROM t1
    GROUP BY 1
),
t3 AS (
    SELECT s.name rep_name,
        r.name region_name,
        SUM(o.total_amt_usd) total_amt
    FROM sales_reps s
        JOIN accounts a ON a.sales_rep_id = s.id
        JOIN orders o ON o.account_id = a.id
        JOIN region r ON r.id = s.region_id
    GROUP BY 1,
        2
    ORDER BY 3 DESC
)
SELECT t3.rep_name,
    t3.region_name,
    t3.total_amt
FROM t2
    JOIN t3 ON t3.region_name = t2.region_name
    AND t3.total_amt = t2.total_amt;
-- Answer:
-- They were able to factor common logic out of t1 and t3 into a single alias. The only difference was the order by clause, which didn't change the results of the old t1 functionally.
-- Lesson learned: When refactoring a subq into a CTE, always check that common logic has been factored out.
WITH t1 AS (
    SELECT s.name rep_name,
        r.name region_name,
        SUM(o.total_amt_usd) total_amt
    FROM sales_reps s
        JOIN accounts a ON a.sales_rep_id = s.id
        JOIN orders o ON o.account_id = a.id
        JOIN region r ON r.id = s.region_id
    GROUP BY 1,
        2
    ORDER BY 3 DESC
),
t2 AS (
    SELECT region_name,
        MAX(total_amt) total_amt
    FROM t1
    GROUP BY 1
)
SELECT t1.rep_name,
    t1.region_name,
    t1.total_amt
FROM t1
    JOIN t2 ON t1.region_name = t2.region_name
    AND t1.total_amt = t2.total_amt;