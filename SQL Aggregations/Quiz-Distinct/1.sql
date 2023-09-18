-- Use DISTINCT to test if there are any accounts associated with more than one region.
SELECT DISTINCT a.name account,
    r.name region
FROM accounts a
    JOIN sales_reps s ON s.id = a.sales_rep_id
    JOIN region r ON r.id = s.region_id;
-- We are looking for unique combinations of account and region.
-- region is not a fact table, but a dim table.
-- Their answer:
-- The below two queries have the same number of resulting rows (351), so we know that every account is associated with only one region. If each account was associated with more than one region, the first query should have returned more rows than the second query.
-- My note: The number of uniqe account names needed to match the other query, but I don't quite understand what the point of the more complex query is.
SELECT a.id as "account id",
    r.id as "region id",
    a.name as "account name",
    r.name as "region name"
FROM accounts a
    JOIN sales_reps s ON s.id = a.sales_rep_id
    JOIN region r ON r.id = s.region_id;
SELECT DISTINCT id,
    name
FROM accounts;