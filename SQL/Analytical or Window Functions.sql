-- B. Analytical / Window Functions (30 Questions)

    -- Assign row numbers to customers ordered by credit limit descending.

-- SELECT 
--     ROW_NUMBER() OVER (ORDER BY CUST_CREDIT_LIMIT DESC) AS ROW_NUM,
--     CUST_FIRST_NAME,
--     CUST_LAST_NAME,
--     CUST_STATE_PROVINCE,
--     CUST_CREDIT_LIMIT
-- FROM 
--     SH.CUSTOMERS
-- ORDER BY 
--     CUST_CREDIT_LIMIT DESC;

    -- Rank customers within each state by credit limit.
-- SELECT 
--     RANK() OVER (PARTITION BY CUST_STATE_PROVINCE ORDER BY CUST_CREDIT_LIMIT DESC) AS ROW_NUM,
--     CUST_FIRST_NAME,
--     CUST_LAST_NAME,
--     CUST_STATE_PROVINCE,
--     CUST_CREDIT_LIMIT
-- FROM 
--     SH.CUSTOMERS
-- ORDER BY 
--     CUST_STATE_PROVINCE,
--     ROW_NUM;



    -- Use DENSE_RANK() to find the top 5 credit holders per country.
-- SELECT *
-- FROM (
--     SELECT
--         DENSE_RANK() OVER (PARTITION BY COUNTRY_ID ORDER BY CUST_CREDIT_LIMIT DESC) AS RANK_IN_COUNTRY,
--         CUST_FIRST_NAME,
--         CUST_LAST_NAME,
--         CUST_STATE_PROVINCE,
--         COUNTRY_ID,
--         CUST_CREDIT_LIMIT,
--         CUST_INCOME_LEVEL
--     FROM SH.CUSTOMERS
-- )
-- WHERE RANK_IN_COUNTRY <= 5
-- ORDER BY COUNTRY_ID, RANK_IN_COUNTRY;




    -- Divide customers into 4 quartiles based on their credit limit using NTILE(4).
-- SELECT
--     CUST_FIRST_NAME,
--     CUST_LAST_NAME,
--     CUST_CREDIT_LIMIT,
--     NTILE(4) OVER (ORDER BY CUST_CREDIT_LIMIT DESC) AS CREDIT_QUARTILE
-- FROM SH.CUSTOMERS
-- ORDER BY CREDIT_QUARTILE, CUST_CREDIT_LIMIT DESC;


    -- Calculate a running total of credit limits ordered by customer_id.
-- SELECT
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_LAST_NAME,
--     CUST_CREDIT_LIMIT,
--     SUM(CUST_CREDIT_LIMIT) OVER (ORDER BY CUST_ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
--     ) AS RUNNING_TOTAL
-- FROM SH.CUSTOMERS
-- ORDER BY CUST_ID;

    -- Show cumulative average credit limit by country.
-- SELECT
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_LAST_NAME,
--     COUNTRY_ID,
--     CUST_CREDIT_LIMIT,
--     AVG(CUST_CREDIT_LIMIT) OVER (PARTITION BY COUNTRY_ID ORDER BY CUST_ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
--     ) AS CUMULATIVE_AVG
-- FROM SH.CUSTOMERS
-- ORDER BY COUNTRY_ID, CUST_ID;



    -- Compare each customer’s credit limit to the previous one using LAG().
-- SELECT
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_LAST_NAME,
--     CUST_CREDIT_LIMIT,
--     LAG(CUST_CREDIT_LIMIT, 1) OVER (ORDER BY CUST_ID) AS PREV_CREDIT_LIMIT,
--     CUST_CREDIT_LIMIT - LAG(CUST_CREDIT_LIMIT, 1) OVER (ORDER BY CUST_ID) AS DIFF_FROM_PREV
-- FROM SH.CUSTOMERS
-- ORDER BY CUST_ID;

    -- Show next customer’s credit limit using LEAD().
-- SELECT
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_LAST_NAME,
--     CUST_CREDIT_LIMIT,
--     LEAD(CUST_CREDIT_LIMIT,1) OVER(ORDER BY CUST_ID) AS NEXT_CREDIT_LIMIT,
--     LEAD(CUST_CREDIT_LIMIT,1) OVER(ORDER BY CUST_ID) - CUST_CREDIT_LIMIT AS DIFF_FROM_NEXT
-- FROM SH.CUSTOMERS
-- ORDER BY CUST_ID;


    -- Display the difference between each customer’s credit limit and the previous one.
-- SELECT
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_LAST_NAME,
--     CUST_CREDIT_LIMIT,
--     LAG(CUST_CREDIT_LIMIT, 1) OVER(ORDER BY CUST_ID) AS PREV_CREDIT_LIMIT,
--     CUST_CREDIT_LIMIT - LAG(CUST_CREDIT_LIMIT, 1) OVER(ORDER BY CUST_ID) AS DIFF_FROM_PREV
-- FROM
--     SH.CUSTOMERS
-- ORDER BY
--     CUST_ID;

 



    -- For each country, display the first and last credit limit using FIRST_VALUE() and LAST_VALUE().
-- SELECT
--     COUNTRY_ID,
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_LAST_NAME,
--     CUST_CREDIT_LIMIT,
--     FIRST_VALUE(CUST_CREDIT_LIMIT) OVER (PARTITION BY COUNTRY_ID ORDER BY CUST_CREDIT_LIMIT ASC) AS FIRST_CREDIT_LIMIT,
--     LAST_VALUE(CUST_CREDIT_LIMIT) OVER (PARTITION BY COUNTRY_ID ORDER BY CUST_CREDIT_LIMIT ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS LAST_CREDIT_LIMIT
-- FROM SH.CUSTOMERS
-- ORDER BY COUNTRY_ID, CUST_CREDIT_LIMIT;

    

    -- Compute percentage rank (PERCENT_RANK()) of customers based on credit limit.
-- SELECT
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_LAST_NAME,
--     CUST_CREDIT_LIMIT,
--     PERCENT_RANK() OVER (
--         ORDER BY CUST_CREDIT_LIMIT ASC
--     ) AS PERCENT_RANK
-- FROM SH.CUSTOMERS
-- ORDER BY CUST_CREDIT_LIMIT ASC;
    
    
    -- Show each customer’s position in percentile (CUME_DIST() function).
-- SELECT
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_LAST_NAME,
--     CUST_CREDIT_LIMIT,
--     CUME_DIST() OVER (ORDER BY CUST_CREDIT_LIMIT ASC) AS CUMULATIVE_DIST
-- FROM SH.CUSTOMERS
-- ORDER BY CUST_CREDIT_LIMIT ASC;




    -- Display the difference between the maximum and current credit limit for each customer.
-- SELECT
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_LAST_NAME,
--     CUST_CREDIT_LIMIT,
--     MAX(CUST_CREDIT_LIMIT) OVER () - CUST_CREDIT_LIMIT AS DIFF_FROM_MAX
-- FROM SH.CUSTOMERS
-- ORDER BY CUST_CREDIT_LIMIT DESC;


    -- Rank income levels by their average credit limit.
-- SELECT
--     CUST_INCOME_LEVEL,
--     AVG(CUST_CREDIT_LIMIT) AS AVG_CREDIT_LIMIT,
--     RANK() OVER (ORDER BY AVG(CUST_CREDIT_LIMIT) DESC) AS INCOME_RANK
-- FROM SH.CUSTOMERS
-- GROUP BY CUST_INCOME_LEVEL
-- ORDER BY INCOME_RANK;



    -- Calculate the average credit limit over the last 10 customers (sliding window).
-- SELECT
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_LAST_NAME,
--     CUST_CREDIT_LIMIT,
--     AVG(CUST_CREDIT_LIMIT) OVER (ORDER BY CUST_ID ROWS BETWEEN 9 PRECEDING AND CURRENT ROW) AS AVG_LAST_10
-- FROM SH.CUSTOMERS
-- ORDER BY CUST_ID;



    -- For each state, calculate the cumulative total of credit limits ordered by city.
-- SELECT
--     CUST_STATE_PROVINCE,
--     CUST_CITY,
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_LAST_NAME,
--     CUST_CREDIT_LIMIT,
--     SUM(CUST_CREDIT_LIMIT) OVER (
--         PARTITION BY CUST_STATE_PROVINCE ORDER BY CUST_CITY ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CUMULATIVE_CREDIT
-- FROM SH.CUSTOMERS
-- ORDER BY CUST_STATE_PROVINCE, CUST_CITY;



    -- Find customers whose credit limit equals the median credit limit (use PERCENTILE_CONT(0.5)).
-- SELECT
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_LAST_NAME,
--     CUST_CREDIT_LIMIT
-- FROM (
--     SELECT
--         CUST_ID,
--         CUST_FIRST_NAME,
--         CUST_LAST_NAME,
--         CUST_CREDIT_LIMIT,
--         PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY CUST_CREDIT_LIMIT) OVER () AS MEDIAN_CREDIT
--     FROM SH.CUSTOMERS
-- ) t
-- WHERE CUST_CREDIT_LIMIT = MEDIAN_CREDIT
-- ORDER BY CUST_CREDIT_LIMIT;



    -- Display the highest 3 credit holders per state using ROW_NUMBER() and PARTITION BY.
-- SELECT
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_LAST_NAME,
--     CUST_STATE_PROVINCE,
--     CUST_CREDIT_LIMIT
-- FROM (
--     SELECT
--         CUST_ID,
--         CUST_FIRST_NAME,
--         CUST_LAST_NAME,
--         CUST_STATE_PROVINCE,
--         CUST_CREDIT_LIMIT,
--         ROW_NUMBER() OVER (PARTITION BY CUST_STATE_PROVINCE ORDER BY CUST_CREDIT_LIMIT DESC) AS RN
--     FROM SH.CUSTOMERS
-- ) t
-- WHERE RN <= 3
-- ORDER BY CUST_STATE_PROVINCE, RN;



    -- Identify customers whose credit limit increased compared to previous row (using LAG).
-- SELECT *
-- FROM (
--     SELECT
--         CUST_ID,
--         CUST_FIRST_NAME,
--         CUST_LAST_NAME,
--         CUST_CREDIT_LIMIT,
--         LAG(CUST_CREDIT_LIMIT) OVER (ORDER BY CUST_ID) AS PREV_CREDIT,
--         CUST_CREDIT_LIMIT - LAG(CUST_CREDIT_LIMIT) OVER (ORDER BY CUST_ID) AS CREDIT_DIFF
--     FROM SH.CUSTOMERS
-- ) t
-- WHERE CREDIT_DIFF > 0
-- ORDER BY CUST_ID;




    -- Calculate moving average of credit limits with a window of 3.
-- SELECT
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_LAST_NAME,
--     CUST_CREDIT_LIMIT,
--     AVG(CUST_CREDIT_LIMIT) OVER (ORDER BY CUST_ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MOVING_AVG_3
-- FROM SH.CUSTOMERS
-- ORDER BY CUST_ID;



    -- Show cumulative percentage of total credit limit per country.
-- SELECT
--     COUNTRY_ID,
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_LAST_NAME,
--     CUST_CREDIT_LIMIT,
--     SUM(CUST_CREDIT_LIMIT) OVER (
--         PARTITION BY COUNTRY_ID ORDER BY CUST_CREDIT_LIMIT DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
--     / SUM(CUST_CREDIT_LIMIT) OVER (PARTITION BY COUNTRY_ID) * 100 AS CUM_PERCENT
-- FROM SH.CUSTOMERS
-- ORDER BY COUNTRY_ID, CUM_PERCENT DESC;


    -- Rank customers by age (derived from CUST_YEAR_OF_BIRTH).
-- SELECT
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_LAST_NAME,
--     CUST_YEAR_OF_BIRTH,
--     EXTRACT(YEAR FROM SYSDATE) - CUST_YEAR_OF_BIRTH AS AGE,
--     RANK() OVER (ORDER BY EXTRACT(YEAR FROM SYSDATE) - CUST_YEAR_OF_BIRTH DESC) AS AGE_RANK
-- FROM SH.CUSTOMERS
-- ORDER BY AGE_RANK;


    -- Calculate difference in age between current and previous customer in the same state.
-- SELECT
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_LAST_NAME,
--     CUST_STATE_PROVINCE,
--     CUST_YEAR_OF_BIRTH,
--     EXTRACT(YEAR FROM SYSDATE) - CUST_YEAR_OF_BIRTH AS AGE,
--     EXTRACT(YEAR FROM SYSDATE) - CUST_YEAR_OF_BIRTH
--     - LAG(EXTRACT(YEAR FROM SYSDATE) - CUST_YEAR_OF_BIRTH) 
--       OVER (PARTITION BY CUST_STATE_PROVINCE ORDER BY CUST_ID) AS AGE_DIFF
-- FROM SH.CUSTOMERS
-- ORDER BY CUST_STATE_PROVINCE, CUST_ID;


    -- Use RANK() and DENSE_RANK() to show how ties are treated differently.
-- SELECT
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_LAST_NAME,
--     CUST_CREDIT_LIMIT,
--     RANK() OVER (ORDER BY CUST_CREDIT_LIMIT DESC) AS RANK_VALUE,
--     DENSE_RANK() OVER (ORDER BY CUST_CREDIT_LIMIT DESC) AS DENSE_RANK_VALUE
-- FROM SH.CUSTOMERS
-- ORDER BY CUST_CREDIT_LIMIT DESC;


    -- Compare each state’s average credit limit with country average using window partition.
-- SELECT
--     COUNTRY_ID,
--     CUST_STATE_PROVINCE,
--     AVG(CUST_CREDIT_LIMIT) AS STATE_AVG,
--     AVG(CUST_CREDIT_LIMIT) OVER (PARTITION BY COUNTRY_ID) AS COUNTRY_AVG,
--     AVG(CUST_CREDIT_LIMIT) - AVG(CUST_CREDIT_LIMIT) OVER (PARTITION BY COUNTRY_ID) AS DIFF_FROM_COUNTRY_AVG
-- FROM SH.CUSTOMERS
-- GROUP BY COUNTRY_ID, CUST_STATE_PROVINCE
-- ORDER BY COUNTRY_ID, STATE_AVG DESC;


    -- Show total credit per state and also its rank within each country.
-- SELECT
--     COUNTRY_ID,
--     CUST_STATE_PROVINCE,
--     STATE_AVG,
--     COUNTRY_AVG,
--     STATE_AVG - COUNTRY_AVG AS DIFF_FROM_COUNTRY_AVG
-- FROM (
--     SELECT
--         COUNTRY_ID,
--         CUST_STATE_PROVINCE,
--         AVG(CUST_CREDIT_LIMIT) AS STATE_AVG,
--         AVG(AVG(CUST_CREDIT_LIMIT)) OVER (PARTITION BY COUNTRY_ID) AS COUNTRY_AVG
--     FROM SH.CUSTOMERS
--     GROUP BY COUNTRY_ID, CUST_STATE_PROVINCE
-- ) t
-- ORDER BY COUNTRY_ID, STATE_AVG DESC;


    -- Find customers whose credit limit is above the 90th percentile of their income level.
-- SELECT *
-- FROM (
--     SELECT
--         CUST_ID,
--         CUST_FIRST_NAME,
--         CUST_LAST_NAME,
--         CUST_INCOME_LEVEL,
--         CUST_CREDIT_LIMIT,
--         PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY CUST_CREDIT_LIMIT) 
--             OVER (PARTITION BY CUST_INCOME_LEVEL) AS P90_CREDIT
--     FROM SH.CUSTOMERS
-- ) t
-- WHERE CUST_CREDIT_LIMIT > P90_CREDIT
-- ORDER BY CUST_INCOME_LEVEL, CUST_CREDIT_LIMIT DESC;


    -- Display top 3 and bottom 3 customers per country by credit limit.
-- SELECT *
-- FROM (
--     SELECT
--         CUST_ID,
--         CUST_FIRST_NAME,
--         CUST_LAST_NAME,
--         COUNTRY_ID,
--         CUST_CREDIT_LIMIT,
--         ROW_NUMBER() OVER (PARTITION BY COUNTRY_ID ORDER BY CUST_CREDIT_LIMIT DESC) AS RN_TOP
--     FROM SH.CUSTOMERS
-- ) t
-- WHERE RN_TOP <= 3

-- UNION ALL

-- SELECT *
-- FROM (
--     SELECT
--         CUST_ID,
--         CUST_FIRST_NAME,
--         CUST_LAST_NAME,
--         COUNTRY_ID,
--         CUST_CREDIT_LIMIT,
--         ROW_NUMBER() OVER (PARTITION BY COUNTRY_ID ORDER BY CUST_CREDIT_LIMIT ASC) AS RN_BOTTOM
--     FROM SH.CUSTOMERS
-- ) t
-- WHERE RN_BOTTOM <= 3
-- ORDER BY COUNTRY_ID, CUST_CREDIT_LIMIT DESC;



--     -- Calculate rolling sum of 5 customers’ credit limit within each country.
-- SELECT
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_LAST_NAME,
--     COUNTRY_ID,
--     CUST_CREDIT_LIMIT,
--     SUM(CUST_CREDIT_LIMIT) OVER (
--         PARTITION BY COUNTRY_ID
--         ORDER BY CUST_ID
--         ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
--     ) AS ROLLING_SUM_5
-- FROM SH.CUSTOMERS
-- ORDER BY COUNTRY_ID, CUST_ID;


    -- For each marital status, display the most and least wealthy customers using analytical functions.
-- SELECT *
-- FROM (
--     SELECT
--         CUST_ID,
--         CUST_FIRST_NAME,
--         CUST_LAST_NAME,
--         CUST_MARITAL_STATUS,
--         CUST_CREDIT_LIMIT,
--         ROW_NUMBER() OVER (
--             PARTITION BY CUST_MARITAL_STATUS
--             ORDER BY CUST_CREDIT_LIMIT DESC
--         ) AS RN_MOST
--     FROM SH.CUSTOMERS
-- ) t
-- WHERE RN_MOST = 1

-- UNION ALL

-- SELECT *
-- FROM (
--     SELECT
--         CUST_ID,
--         CUST_FIRST_NAME,
--         CUST_LAST_NAME,
--         CUST_MARITAL_STATUS,
--         CUST_CREDIT_LIMIT,
--         ROW_NUMBER() OVER (
--             PARTITION BY CUST_MARITAL_STATUS
--             ORDER BY CUST_CREDIT_LIMIT ASC
--         ) AS RN_LEAST
--     FROM SH.CUSTOMERS
-- ) t
-- WHERE RN_LEAST = 1
-- ORDER BY CUST_MARITAL_STATUS, CUST_CREDIT_LIMIT DESC;