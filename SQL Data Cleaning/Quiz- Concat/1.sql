-- Each company in the accounts table wants to create an email address for each primary_poc. The email address should be the first name of the primary_poc . last name primary_poc @ company name .com.
-- first.last @co_name.com name is a field primary poc is another field.
-- 1. create first from primary_poc
-- 2. create last from primary_poc
-- 3. reference the alias to select the concatenation
SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1) || '.' || RIGHT(
        primary_poc,
        LENGTH(primary_poc) - STRPOS(primary_poc, ' ')
    ) || '@' || name || '.com' email
FROM accounts a;
-- Answer:
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
    CONCAT(first_name, '.', last_name, '@', name, '.com')
FROM t1;
-- Uses same formulas, but cleans it up by moving the formulas into a CTE