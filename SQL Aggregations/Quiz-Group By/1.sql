-- You use a join when you already know you need a column from one table,
-- And you also need another column from another table.
-- Need to join the orders to accounts
-- Joining is just about looking at a more complete set of accurate records.
SELECT a.name,
    o.occurred_at
FROM orders o
    JOIN accounts a ON o.account_id = a.id
GROUP BY o.occurred_at,
    a.name
ORDER BY o.occurred_at
LIMIT 1;
-- I want the name, but it's almost an afterthought.
-- We get the right row by checking that the occurred_at is the oldest (least)
-- Their solution: Note that it didn't use GROUP BY
-- Also, order by doesn't require us to specify the original table a column came from,
-- but instead uses its name as it will appear in the final table.
SELECT a.name,
    o.occurred_at
FROM accounts a
    JOIN orders o ON a.id = o.account_id
ORDER BY occurred_at
LIMIT 1;