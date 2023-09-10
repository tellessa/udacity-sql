-- Initial
SELECT region.name,
    sales_reps.name,
    accounts.name
FROM region
    JOIN sales_reps ON region.id = sales_reps.region_id
    JOIN accounts ON sales_reps.id = accounts.sales_rep_id
ORDER BY 3;
-- ASC
-- should go low to high, so a-z
;
-- Revised to give the initial 3 "name" columns unique names
SELECT r.name region,
    s.name rep,
    a.name account
FROM region r
    JOIN sales_reps s ON r.id = s.region_id
    JOIN accounts a ON s.id = a.sales_rep_id
ORDER BY 3;
-- ASC
-- should go low to high, so a-z
;
-- sales_rep.region_id
--Region is one to many- one region has many sales_reps, for its id column
-- FROM there we can get the accounts that have that sales rep
-- We have no way of going directly from region to sales reps
-- We don't care about joining all of the sales rep data to the accounts
-- We would rather take the regions we know we need, then get the sales reps for it, then the accounts for that rep
-- Their answer:
SELECT r.name region,
    s.name rep,
    a.name account
FROM sales_reps s
    JOIN region r ON s.region_id = r.id
    JOIN accounts a ON a.sales_rep_id = s.id
ORDER BY a.name;
-- Conclusion: I achieved the same result, initially without any aliases, and using a number in the order by.
-- My joins were done in a different order
-- Mine and theirs both give back 351 results and are in alphabetcal order by name.
-- ORDER BY is one operator, but the order is almost like a command whereas the by is the more english-like part
-- Do you want to order? yes
-- By what? by the