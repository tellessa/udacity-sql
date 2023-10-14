WITH t1 AS (
    SELECT DATE,
        SUBSTR(DATE, 7, 4) AS year,
        SUBSTR(DATE, 4, 2) AS day,
        SUBSTR(DATE, 1, 2) AS month
    FROM sf_crime_data
)
SELECT CONCAT(t1.year, '-', month, '-', day) AS my_varchar,
    date,
    CONCAT(t1.year, '-', month, '-', day)::date AS my_date
FROM t1;
-- month/day/year is original
-- We need to pass in the string and the date format as arguments
-- Answer 4:
SELECT date orig_date,
    (
        SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) || '-' || SUBSTR(date, 4, 2)
    ) new_date
FROM sf_crime_data;
-- Answer 5: Literally just added ::DATE, how convenient!
SELECT date orig_date,
    (
        SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) || '-' || SUBSTR(date, 4, 2)
    )::DATE new_date
FROM sf_crime_data;