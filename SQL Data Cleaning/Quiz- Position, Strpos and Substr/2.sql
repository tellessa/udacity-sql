SELECT LEFT(name, STRPOS(name, ' ') -1) first_name,
    RIGHT(
        name,
        LENGTH(name) - STRPOS(name, ' ')
    ) last_name
FROM sales_reps;
-- Answer
SELECT LEFT(name, STRPOS(name, ' ') -1) first_name,
    RIGHT(
        name,
        LENGTH(name) - STRPOS(name, ' ')
    ) last_name
FROM sales_reps;