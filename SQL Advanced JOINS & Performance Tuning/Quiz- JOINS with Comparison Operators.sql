SELECT a.name account_name,
    a.primary_poc,
    s.name sales_rep
FROM accounts a
    JOIN sales_reps s ON a.sales_rep_id = s.id
    AND a.primary_poc < s.name;
-- Their answer: I forgot to call out left join explicitly, which means I did an inner join by accident
SELECT accounts.name as account_name,
    accounts.primary_poc as poc_name,
    sales_reps.name as sales_rep_name
FROM accounts
    LEFT JOIN sales_reps ON accounts.sales_rep_id = sales_reps.id
    AND accounts.primary_poc < sales_reps.name;