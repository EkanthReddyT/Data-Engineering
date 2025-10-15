--  D. Date & Conversion Functions (10 Questions)

    -- Convert CUST_YEAR_OF_BIRTH to age as of today.
-- SELECT CUST_FIRST_NAME,
--      CUST_YEAR_OF_BIRTH,
-- EXTRACT(YEAR FROM SYSDATE)-CUST_YEAR_OF_BIRTH AS AGE
-- FROM SH.CUSTOMERS
-- ORDER BY AGE DESC;




    -- Display all customers born between 1980 and 1990.
-- SELECT CUST_FIRST_NAME,
--        CUST_YEAR_OF_BIRTH
-- FROM SH.CUSTOMERS
-- WHERE CUST_YEAR_OF_BIRTH between 1980 AND 1990
-- ORDER BY CUST_YEAR_OF_BIRTH DESC;



    -- Format date of birth into “Month YYYY” using TO_CHAR.
-- SELECT 
--     CUST_FIRST_NAME,
--     CUST_YEAR_OF_BIRTH,
--     TO_CHAR(TO_DATE(CUST_YEAR_OF_BIRTH, 'YYYY'), 'FMMONTH YYYY') AS DOB_FORMATTED
-- FROM SH.CUSTOMERS;





    -- Convert income level text (like 'A: Below 30,000') to numeric lower limit.
-- SELECT
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_INCOME_LEVEL,
--     CASE
--         WHEN CUST_INCOME_LEVEL LIKE 'A:%' THEN 0
--         WHEN CUST_INCOME_LEVEL LIKE 'B:%' THEN 30000
--         WHEN CUST_INCOME_LEVEL LIKE 'C:%' THEN 50001
--         WHEN CUST_INCOME_LEVEL LIKE 'D:%' THEN 70001
--         WHEN CUST_INCOME_LEVEL LIKE 'E:%' THEN 100001
--         ELSE NULL
--     END AS INCOME_LOWER_LIMIT
-- FROM SH.CUSTOMERS;



    -- Display customer birth decades (e.g., 1960s, 1970s).
-- SELECT 
--     CUST_FIRST_NAME,
--     CUST_YEAR_OF_BIRTH,
--     FLOOR(CUST_YEAR_OF_BIRTH/10)*10 ||'s' AS "BIRTH DECADE"
--     FROM SH.CUSTOMERS
--     ORDER BY CUST_YEAR_OF_BIRTH;



    -- Show customers grouped by age bracket (10-year intervals).
-- SELECT
--     FLOOR((EXTRACT(YEAR FROM SYSDATE) - CUST_YEAR_OF_BIRTH)/10)*10 AS AGE_BRACKET_START,
--     FLOOR((EXTRACT(YEAR FROM SYSDATE) - CUST_YEAR_OF_BIRTH)/10)*10 + 9 AS AGE_BRACKET_END,
--     COUNT(*) AS NUM_CUSTOMERS
-- FROM SH.CUSTOMERS
-- GROUP BY FLOOR((EXTRACT(YEAR FROM SYSDATE) - CUST_YEAR_OF_BIRTH)/10)*10
-- ORDER BY AGE_BRACKET_START;


    -- Convert country_id to uppercase and state name to lowercase.
-- SELECT
--     UPPER(COUNTRY_ID) AS COUNTRY_UPPER,
--     LOWER(CUST_STATE_PROVINCE) AS STATE_LOWER
-- FROM SH.CUSTOMERS;



    -- Show customers where credit limit > average of their birth decade.
-- SELECT *
-- FROM (
--     SELECT
--         CUST_FIRST_NAME,
--         CUST_YEAR_OF_BIRTH,
--         FLOOR(CUST_YEAR_OF_BIRTH/10)*10 AS BIRTH_DECADE,
--         CUST_CREDIT_LIMIT,
--         AVG(CUST_CREDIT_LIMIT) OVER (PARTITION BY FLOOR(CUST_YEAR_OF_BIRTH/10)*10) AS AVG_DEC_CREDIT
--     FROM SH.CUSTOMERS
-- ) t
-- WHERE CUST_CREDIT_LIMIT > AVG_DEC_CREDIT;




    -- Convert all numeric credit limits to currency format $999,999.00.
-- SELECT
--     CUST_FIRST_NAME,
--     TO_CHAR(CUST_CREDIT_LIMIT, '$999,999.00') AS CREDIT_FORMATTED
-- FROM SH.CUSTOMERS;



    -- Find customers whose credit limit was NULL and replace with average (using NVL).
-- SELECT
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_CREDIT_LIMIT,
--     NVL(
--         CUST_CREDIT_LIMIT,
--         (SELECT AVG(CUST_CREDIT_LIMIT) FROM SH.CUSTOMERS)
--     ) AS CREDIT_WITH_AVG
-- FROM SH.CUSTOMERS
-- ORDER BY CUST_FIRST_NAME;