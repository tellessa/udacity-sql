-- We would also like to create an initial password, which they will change after their first log in. The first password will be
-- 1. the first letter of the primary_poc's first name (lowercase),
--     a. Get the first name
--     b. pull the first letter of it.
-- 2. then the last letter of their first name (lowercase),
--     a. Get the first name
--     b. Pull the last letter of it.
-- 3. the first letter of their last name (lowercase),
--     a. Get the last name
--     b. pull the first letter of it.
-- 4. the last letter of their last name (lowercase),
--     a. Get the last name
--     b. pull the last letter of it.
-- 5. the number of letters in their first name,
--     a. Get the first name
--     b. compute the length of it.
-- 6. the number of letters in their last name,
--     a. Get the last name
--     b. compute the length of it.
-- 7. Capitalize the name of the company they are working with,
-- 8. Concat everything.
-- example: input: David Ryan from acme
-- output: ddrn54ACME
-- Strategy: Use a CTE to pull the first and last names.
WITH t1 AS (
    SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1) first_name,
        RIGHT(
            primary_poc,
            LENGTH(primary_poc) - STRPOS(primary_poc, ' ')
        ) last_name,
        name
    FROM accounts
),
t2 AS (
    SELECT t1.first_name,
        t1.last_name,
        lower(LEFT(t1.first_name, 1)) fname_fletter,
        RIGHT(t1.first_name, 1) fname_lletter,
        LOWER(LEFT(t1.last_name, 1)) lname_fletter,
        RIGHT(t1.last_name, 1) lname_lletter,
        LENGTH(t1.first_name) length_first,
        LENGTH(t1.last_name) length_last,
        UPPER(REPLACE(name, ' ', '')) cap_name
    FROM t1
)
SELECT first_name,
    last_name,
    CONCAT(
        t2.fname_fletter,
        t2.fname_lletter,
        t2.lname_fletter,
        t2.lname_lletter,
        t2.length_first,
        t2.length_last,
        cap_name
    )
FROM t2;
-- Answer:
-- They used the same t1, but didn't create a T2.
WITH t1 AS (
    SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1) first_name,
        RIGHT(
            primary_poc,
            LENGTH(primary_poc) - STRPOS(primary_poc, ' ')
        ) last_name,
        name
    FROM accounts
)
SELECT first_name,
    last_name,
    CONCAT(first_name, '.', last_name, '@', name, '.com'),
    LEFT(LOWER(first_name), 1) || RIGHT(LOWER(first_name), 1) || LEFT(LOWER(last_name), 1) || RIGHT(LOWER(last_name), 1) || LENGTH(first_name) || LENGTH(last_name) || REPLACE(UPPER(name), ' ', '')
FROM t1;