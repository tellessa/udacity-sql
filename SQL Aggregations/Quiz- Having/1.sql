-- How many of the sales reps have more than 5 accounts that they manage?
SELECT s.name "sales rep",
    COUNT(*)
FROM sales_reps s
GROUP BY "sales rep"
HAVING COUNT(*) > 5;
-- Answer
SELECT s.id,
    s.name,
    COUNT(*) num_accounts
FROM accounts a
    JOIN sales_reps s ON s.id = a.sales_rep_id
GROUP BY s.id,
    s.name
HAVING COUNT(*) > 5
ORDER BY num_reps_above5;
-- My riff on their Answer, selecting only the count column:
SELECT COUNT(*) num_reps_above5
FROM accounts a
    JOIN sales_reps s ON s.id = a.sales_rep_id
GROUP BY s.id,
    s.name
HAVING COUNT(*) > 5
ORDER BY num_reps_above5;
-- You have to join to the accounts table because that's the only way to know how many accounts have a foreign key to a given sales rep.
-- Count(*) will be much higher when all those rows having a foreign key of the same sales rep are brought into the result set, and much lower without that join
-- I missed the join mainly, but I also only had one column in my group by clause; I was forgetting that they can't be in the select, which includes an agg function, unless they also appear in the group by clause.
-- alt answer using a subquery. Not sure what the value of this is, as all we seemed to get back was the same number with a different alias.
SELECT COUNT(*) num_reps_above5
FROM(
        SELECT s.id,
            s.name,
            COUNT(*) num_accounts
        FROM accounts a
            JOIN sales_reps s ON s.id = a.sales_rep_id
        GROUP BY s.id,
            s.name
        HAVING COUNT(*) > 5
        ORDER BY num_accounts
    ) AS Table1;