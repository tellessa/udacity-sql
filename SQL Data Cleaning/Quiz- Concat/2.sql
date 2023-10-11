-- You may have noticed that in the previous solution some of the company names include spaces, which will certainly not work in an email address. See if you can create an email address that will work by removing all of the spaces in the account name, but otherwise your solution should be just as in question 1. Some helpful documentation is here.
-- Clean the space out
WITH t1 AS (
    SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1) first_name,
        RIGHT(
            primary_poc,
            LENGTH(primary_poc) - STRPOS(primary_poc, ' ')
        ) last_name,
        replace(name, ' ', '') trimmed_name
    FROM accounts
)
SELECT first_name,
    last_name,
    CONCAT(
        first_name,
        '.',
        last_name,
        '@',
        trimmed_name,
        '.com'
    )
FROM t1;
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
    CONCAT(
        first_name,
        '.',
        last_name,
        '@',
        REPLACE(name, ' ', ''),
        '.com'
    )
FROM t1;