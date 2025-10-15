-- C. Conditional, CASE, and DECODE (10 Questions)

    -- Categorize customers into income tiers: Platinum, Gold, Silver, Bronze.

-- SELECT
--   CUST_ID,
--   CUST_FIRST_NAME,
--   CUST_CITY,
--   CUST_CREDIT_LIMIT,
--   CASE
--     WHEN CUST_CREDIT_LIMIT >= 10000 THEN 'PLATINUM'
--     WHEN CUST_CREDIT_LIMIT >= 7000  THEN 'GOLD'
--     WHEN CUST_CREDIT_LIMIT >= 4000  THEN 'SILVER'
--     ELSE 'BRONZE'
--   END AS TIER
-- FROM SH.CUSTOMERS
-- ORDER BY CUST_CREDIT_LIMIT DESC;



    -- Display “High”, “Medium”, or “Low” income categories based on credit limit.

-- SELECT
--   CUST_ID,
--   CUST_FIRST_NAME,
--   CUST_CREDIT_LIMIT,
--   CASE
--     WHEN CUST_CREDIT_LIMIT >= 10000 THEN 'High'
--     WHEN CUST_CREDIT_LIMIT >= 7000  THEN 'Medium'
--     ELSE 'Low'
--   END AS CATEGORIES
-- FROM SH.CUSTOMERS
-- ORDER BY CUST_CREDIT_LIMIT DESC;

    -- Replace NULL income levels with “Unknown” using NVL.
-- SELECT
--   CUST_ID,
--   CUST_FIRST_NAME,
--   NVL(TO_CHAR(CUST_CREDIT_LIMIT), 'Unknown') AS CREDIT_LIMIT,
--   CASE
--     WHEN CUST_CREDIT_LIMIT >= 10000 THEN 'High'
--     WHEN CUST_CREDIT_LIMIT >= 7000  THEN 'Medium'
--     WHEN CUST_CREDIT_LIMIT IS NULL  THEN 'Unknown'
--     ELSE 'Low'
--   END AS CATEGORY
-- FROM SH.CUSTOMERS
-- ORDER BY CUST_CREDIT_LIMIT DESC NULLS LAST;



    -- Show customer details and mark whether they have above-average credit limit or not.
-- SELECT
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_CREDIT_LIMIT,
--     CASE
--         WHEN CUST_CREDIT_LIMIT > AVG(CUST_CREDIT_LIMIT) OVER() 
--         THEN 'Above Average'
--         ELSE 'Below Average'
--     END AS CREDIT_STATUS
-- FROM SH.CUSTOMERS
-- ORDER BY CUST_CREDIT_LIMIT DESC;



    -- Use DECODE to convert marital status codes (S/M/D) into full text.
-- SELECT
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_MARITAL_STATUS,
--     DECODE(CUST_MARITAL_STATUS,
--            'S', 'Single',
--            'M', 'Married',
--            'D', 'Divorced',
--            'Unknown') AS MARITAL_STATUS_FULL
-- FROM SH.CUSTOMERS;



    -- Use CASE to show age group (≤30, 31–50, >50) from CUST_YEAR_OF_BIRTH.
-- SELECT 
--     CUST_FIRST_NAME,
--     CUST_YEAR_OF_BIRTH,
--     CASE
--         WHEN (EXTRACT(YEAR FROM SYSDATE) - CUST_YEAR_OF_BIRTH) <= 30 THEN 'Young'
--         WHEN (EXTRACT(YEAR FROM SYSDATE) - CUST_YEAR_OF_BIRTH) BETWEEN 31 AND 50 THEN 'Middle-Aged'
--         ELSE 'Senior'
--     END AS AGE_GROUP
-- FROM SH.CUSTOMERS;
   



    -- Label customers as “Old Credit Holder” or “New Credit Holder” based on year of birth < 1980.
-- SELECT
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_YEAR_OF_BIRTH,
--     CASE
--         WHEN CUST_YEAR_OF_BIRTH < 1980 THEN 'Old Credit Holder'
--         ELSE 'New Credit Holder'
--     END AS CREDIT_HOLDER_TYPE
-- FROM SH.CUSTOMERS
-- ORDER BY CUST_YEAR_OF_BIRTH;


    -- Create a loyalty tag — “Premium” if credit limit > 50,000 and income_level = ‘E’.
-- SELECT
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_CREDIT_LIMIT,
--     CUST_INCOME_LEVEL,
--     CASE
--         WHEN CUST_CREDIT_LIMIT > 50000 AND CUST_INCOME_LEVEL = 'E' THEN 'Premium'
--         ELSE 'Standard'
--     END AS LOYALTY_TAG
-- FROM SH.CUSTOMERS
-- ORDER BY CUST_CREDIT_LIMIT DESC;



    -- Assign grades (A–F) based on credit limit range using CASE.
-- SELECT
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_CREDIT_LIMIT,
--     CASE
--         WHEN CUST_CREDIT_LIMIT >= 90000 THEN 'A'
--         WHEN CUST_CREDIT_LIMIT >= 70000 THEN 'B'
--         WHEN CUST_CREDIT_LIMIT >= 50000 THEN 'C'
--         WHEN CUST_CREDIT_LIMIT >= 30000 THEN 'D'
--         WHEN CUST_CREDIT_LIMIT >= 10000 THEN 'E'
--         ELSE 'F'
--     END AS CREDIT_GRADE
-- FROM SH.CUSTOMERS
-- ORDER BY CUST_CREDIT_LIMIT DESC;


    -- Show country, state, and number of premium customers using conditional aggregation.
-- SELECT
--     COUNTRY_ID,
--     CUST_STATE_PROVINCE,
--     COUNT(CASE WHEN CUST_CREDIT_LIMIT > 50000 THEN 1 END) AS PREMIUM_CUSTOMERS
-- FROM SH.CUSTOMERS
-- GROUP BY
--     COUNTRY_ID,
--     CUST_STATE_PROVINCE
-- ORDER BY
--     COUNTRY_ID,
--     CUST_STATE_PROVINCE;