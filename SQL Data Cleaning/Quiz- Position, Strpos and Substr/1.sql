SELECT primary_poc
FROM accounts a;
-- It saved my work! Even after my session ended!
SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ')) AS first,
    RIGHT(
        primary_poc,
        LENGTH(primary_poc) - STRPOS(primary_poc, ' ')
    ) AS last
FROM accounts;
-- We want to split on the space.
-- answer:
SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1) first_name,
    RIGHT(
        primary_poc,
        LENGTH(primary_poc) - STRPOS(primary_poc, ' ')
    ) last_name
FROM accounts;
-- My equation for getting the last name was perfect!
-- Aliases were different; not sure why they added -1
-- I think without doing that, mine includes the space?
-- Yes that's it: the below query confirms it.
SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1) first_name,
    STRPOS(primary_poc, ' ') str_pos_of_space,
    RIGHT(
        primary_poc,
        LENGTH(primary_poc) - STRPOS(primary_poc, ' ')
    ) last_name,
    LENGTH(LEFT(primary_poc, STRPOS(primary_poc, ' ') -1)) length_after_sub,
    LENGTH(
        LEFT(primary_poc, STRPOS(primary_poc, ' '))
    ) length_wo_sub,
    FROM accounts;