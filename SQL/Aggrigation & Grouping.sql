-- a.Aggrigation & Grouping


-- 1)Find the total, average, minimum, and maximum credit limit of all customers.
-- SELECT
--     SUM(CUST_CREDIT_LIMIT) AS TOTAL_CREDIT_LIMIT,
--     AVG(CUST_CREDIT_LIMIT) AS AVG_CREDIT_LIMIT,
--     MIN(CUST_CREDIT_LIMIT) AS MIN_CREDIT_LIMIT,
--     MAX(CUST_CREDIT_LIMIT) AS MAX_CREDIT_LIMIT
-- FROM
--     SH.CUSTOMERS;


    -- Count the number of customers in each income level.
-- SELECT
--     CUST_INCOME_LEVEL,
--     COUNT(*) AS CUSTOMER_COUNT
-- FROM
--     SH.CUSTOMERS
-- GROUP BY
--     CUST_INCOME_LEVEL;



    -- Show total credit limit by state and country.
-- SELECT
--     COUNTRY_ID,
--     CUST_STATE_PROVINCE_ID,
--     SUM(CUST_CREDIT_LIMIT) AS TOTAL_CREDIT_LIMIT
-- FROM
--     SH.CUSTOMERS
-- GROUP BY
--     COUNTRY_ID,
--     CUST_STATE_PROVINCE_ID
-- ORDER BY
--     COUNTRY_ID,
--     CUST_STATE_PROVINCE_ID;


    -- Display average credit limit for each marital status and gender combination.
-- SELECT
--     CUST_MARITAL_STATUS,
--     CUST_GENDER,
--     AVG(CUST_CREDIT_LIMIT) AS AVG_CREDIT_LIMIT
-- FROM
--     SH.CUSTOMERS
-- GROUP BY
--     CUST_MARITAL_STATUS,
--     CUST_GENDER;
  


    -- Find the top 3 states with the highest average credit limit.
-- SELECT
--     CUST_STATE_PROVINCE,
    
--     AVG(CUST_CREDIT_LIMIT) AS AVG_CREDIT_LIMIT
-- FROM
--     SH.CUSTOMERS
-- GROUP BY
--     CUST_STATE_PROVINCE
-- ORDER BY
--     AVG_CREDIT_LIMIT DESC
-- FETCH FIRST 3 ROWS ONLY;


    -- Find the country with the maximum total customer credit limit.
-- SELECT
--     COUNTRY_ID,
--     SUM(CUST_CREDIT_LIMIT) AS TOTAL_CREDIT_LIMIT
-- FROM
--     SH.CUSTOMERS
-- GROUP BY
--     COUNTRY_ID
-- ORDER BY
--     TOTAL_CREDIT_LIMIT DESC
-- FETCH FIRST 1 ROW ONLY;


    -- Show the number of customers whose credit limit exceeds their state average.
-- SELECT
--     COUNT(*) AS CUSTOMERS_ABOVE_STATE_AVG
-- FROM
--     SH.CUSTOMERS c
-- WHERE
--     CUST_CREDIT_LIMIT > (
--         SELECT AVG(CUST_CREDIT_LIMIT)
--         FROM SH.CUSTOMERS
--         WHERE CUST_STATE_PROVINCE = c.CUST_STATE_PROVINCE
--     );

    

    -- Calculate total and average credit limit for customers born after 1980.
-- SELECT
--     SUM(CUST_CREDIT_LIMIT) AS TOTAL_CREDIT_LIMIT,
--     AVG(CUST_CREDIT_LIMIT) AS AVG_CREDIT_LIMIT
-- FROM
--     SH.CUSTOMERS
-- WHERE
--     CUST_YEAR_OF_BIRTH > 1980;



    -- Find states having more than 50 customers.
-- SELECT
--     CUST_STATE_PROVINCE,
--     COUNT(*) AS CUSTOMER_COUNT
-- FROM
--     SH.CUSTOMERS
-- GROUP BY
--     CUST_STATE_PROVINCE
-- HAVING
--     COUNT(*) > 50;



    -- List countries where the average credit limit is higher than the global average.
-- SELECT
--     COUNTRY_ID,
--     AVG(CUST_CREDIT_LIMIT) AS AVG_CREDIT_LIMIT
-- FROM
--     SH.CUSTOMERS
-- GROUP BY
--     COUNTRY_ID
-- HAVING
--     AVG(CUST_CREDIT_LIMIT) > (
--         SELECT AVG(CUST_CREDIT_LIMIT)
--         FROM SH.CUSTOMERS
--     );



    -- Calculate the variance and standard deviation of customer credit limits by country.
-- SELECT
--     COUNTRY_ID,
--     VARIANCE(CUST_CREDIT_LIMIT) AS VARIANCE_CREDIT_LIMIT,
--     STDDEV(CUST_CREDIT_LIMIT)   AS STDDEV_CREDIT_LIMIT
-- FROM
--     SH.CUSTOMERS
-- GROUP BY
--     COUNTRY_ID;



    -- Find the state with the smallest range (max–min) in credit limits.
-- SELECT
--     CUST_STATE_PROVINCE,
--     (MAX(CUST_CREDIT_LIMIT) - MIN(CUST_CREDIT_LIMIT)) AS CREDIT_RANGE
-- FROM
--     SH.CUSTOMERS
-- GROUP BY
--     CUST_STATE_PROVINCE
-- ORDER BY
--     CREDIT_RANGE ASC
-- FETCH FIRST 1 ROW ONLY;



    -- Show the total number of customers per income level and the percentage contribution of each.

-- SELECT
--     CUST_INCOME_LEVEL,
--     COUNT(*) AS CUSTOMER_COUNT,
--     ROUND(
--         (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM SH.CUSTOMERS)),
--         2
--     ) AS PERCENTAGE_CONTRIBUTION
-- FROM
--     SH.CUSTOMERS
-- GROUP BY
--     CUST_INCOME_LEVEL
-- ORDER BY
--     CUSTOMER_COUNT DESC;


    -- For each income level, find how many customers have NULL credit limits.
-- SELECT
--     CUST_INCOME_LEVEL,
--     COUNT(*) AS NULL_CREDIT_COUNT
-- FROM
--     SH.CUSTOMERS
-- WHERE
--     CUST_CREDIT_LIMIT IS NULL
-- GROUP BY
--     CUST_INCOME_LEVEL
-- ORDER BY
--     NULL_CREDIT_COUNT DESC;


    -- Display countries where the sum of credit limits exceeds 10 million.
-- SELECT
--     COUNTRY_ID,
--     SUM(CUST_CREDIT_LIMIT) AS TOTAL_CREDIT_LIMIT
-- FROM
--     SH.CUSTOMERS
-- GROUP BY
--     COUNTRY_ID
-- HAVING
--     SUM(CUST_CREDIT_LIMIT) > 10000000
-- ORDER BY
--     TOTAL_CREDIT_LIMIT DESC;


    -- Find the state that contributes the highest total credit limit to its country.
-- SELECT COUNTRY_ID,
--        CUST_STATE_PROVINCE,
--        TOTAL_CREDIT_LIMIT
-- FROM (
--     SELECT 
--         COUNTRY_ID,
--         CUST_STATE_PROVINCE,
--         SUM(CUST_CREDIT_LIMIT) AS TOTAL_CREDIT_LIMIT,
--         ROW_NUMBER() OVER (
--             PARTITION BY COUNTRY_ID 
--             ORDER BY SUM(CUST_CREDIT_LIMIT) DESC
--         ) AS RN
--     FROM SH.CUSTOMERS
--     GROUP BY COUNTRY_ID, CUST_STATE_PROVINCE
-- ) 
-- WHERE RN = 1
-- ORDER BY COUNTRY_ID;


    -- Show total credit limit per year of birth, sorted by total descending.
-- SELECT
--     CUST_YEAR_OF_BIRTH,
--     SUM(CUST_CREDIT_LIMIT) AS TOTAL_CREDIT_LIMIT
-- FROM
--     SH.CUSTOMERS
-- GROUP BY
--     CUST_YEAR_OF_BIRTH
-- ORDER BY
--     TOTAL_CREDIT_LIMIT DESC;




    -- Identify customers who hold the maximum credit limit in their respective country.
-- SELECT 
--     COUNTRY_ID,
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_LAST_NAME,
--     CUST_CREDIT_LIMIT
-- FROM (
--     SELECT 
--         COUNTRY_ID,
--         CUST_ID,
--         CUST_FIRST_NAME,
--         CUST_LAST_NAME,
--         CUST_CREDIT_LIMIT,
--         RANK() OVER (
--             PARTITION BY COUNTRY_ID
--             ORDER BY CUST_CREDIT_LIMIT DESC
--         ) AS RN
--     FROM SH.CUSTOMERS
-- )
-- WHERE RN = 1
-- ORDER BY COUNTRY_ID;




    -- Show the difference between maximum and average credit limit per country.
-- SELECT
--     COUNTRY_ID,
--     MAX(CUST_CREDIT_LIMIT) - AVG(CUST_CREDIT_LIMIT) AS MAX_MINUS_AVG
-- FROM
--     SH.CUSTOMERS
-- GROUP BY
--     COUNTRY_ID
-- ORDER BY
--     MAX_MINUS_AVG DESC;


    -- Display the overall rank of each state based on its total credit limit (using GROUP BY + analytic rank).
-- SELECT
--     CUST_STATE_PROVINCE,
--     TOTAL_CREDIT_LIMIT,
--     RANK() OVER (ORDER BY TOTAL_CREDIT_LIMIT DESC) AS STATE_RANK
-- FROM (
--     SELECT
--         CUST_STATE_PROVINCE,
--         SUM(CUST_CREDIT_LIMIT) AS TOTAL_CREDIT_LIMIT
--     FROM SH.CUSTOMERS
--     GROUP BY CUST_STATE_PROVINCE
-- ) 
-- ORDER BY STATE_RANK;