-- Use the accounts table and a CASE statement to create two groups: one group of company names that start with a number and a second group of those company names that start with a letter. What proportion of company names start with a letter?
-- Some sql functions transform each object in a column, while others aggregate the column itself
-- The left and right functions transform each object, returning the same number of objects as we began with.
WITH t1 AS (
    SELECT name,
        LEFT(name, 1) first_letter,
        CASE
            WHEN LEFT(name, 1) LIKE '[0-9]%' THEN 'letter'
            ELSE 'number'
        END AS first_char_type
    FROM accounts
)
SELECT first_char_type,
    COUNT(*)
FROM t1
GROUP BY first_char_type
ORDER BY 1 DESC;
-- Answer:
-- nums	letters
-- 1	350
SELECT SUM(num) nums,
    SUM(letter) letters
FROM (
        SELECT name,
            CASE
                WHEN LEFT(UPPER(name), 1) IN ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9') THEN 1
                ELSE 0
            END AS num,
            CASE
                WHEN LEFT(UPPER(name), 1) IN ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9') THEN 0
                ELSE 1
            END AS letter
        FROM accounts
    ) t1;
-- He seems to be assigning the number column points when it starts with a number string,
-- and assigning the letter column a point when it starts with anything else.
-- My revised answer:
-- It gives the correct information albeit in a two-row two column format:
-- first_char_type	count
-- number	1
-- letter	350
WITH t1 AS (
    SELECT name,
        LEFT(name, 1) first_letter,
        CASE
            WHEN LEFT(UPPER(name), 1) IN ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9') THEN 'number'
            ELSE 'letter'
        END AS first_char_type
    FROM accounts
)
SELECT first_char_type,
    COUNT(*)
FROM t1
GROUP BY first_char_type
ORDER BY 1 DESC;