-- In the accounts table, there is a column holding the website for each company. The last three digits specify what type of web address they are using. A list of extensions (and pricing) is provided here. Pull these extensions and provide how many of each website type exist in the accounts table.
WITH t1 AS (
    SELECT website,
        RIGHT(website, 3) last_three
    FROM accounts
)
SELECT COUNT(*),
    last_three
FROM t1
GROUP BY last_three
ORDER BY 1 DESC;
-- Answer:
SELECT RIGHT(website, 3) AS domain,
    COUNT(*) num_companies
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;