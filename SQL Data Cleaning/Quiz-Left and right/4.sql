-- Consider vowels as a, e, i, o, and u. What proportion of company names start with a vowel, and what percent start with anything else?
SELECT SUM(vowel) vowel,
    SUM(other) other
FROM (
        SELECT name,
            CASE
                WHEN LEFT(LOWER(name), 1) IN ('a', 'e', 'i', 'o', 'u') THEN 1
                ELSE 0
            END AS vowel,
            CASE
                WHEN LEFT(LOWER(name), 1) IN ('a', 'e', 'i', 'o', 'u') THEN 0
                ELSE 1
            END AS other
        FROM accounts
    ) t1;
-- answer:
-- matches except using LOWER instead of UPPER
SELECT SUM(vowels) vowels,
    SUM(other) other
FROM (
        SELECT name,
            CASE
                WHEN LEFT(UPPER(name), 1) IN ('A', 'E', 'I', 'O', 'U') THEN 1
                ELSE 0
            END AS vowels,
            CASE
                WHEN LEFT(UPPER(name), 1) IN ('A', 'E', 'I', 'O', 'U') THEN 0
                ELSE 1
            END AS other
        FROM accounts
    ) t1;