/*
   QUERY:
   This SQL query calculates the Consumer Price Index (CPI),
   for monthly drug premiums by state and year, 
   comparing each year's premiums to the base year 2018.

   QUESTIONS:
   1. What is the Consumer Price Index (CPI) for monthly drug premiums by state and year?
   2. How does the CPI compare to the base year 2018?
   3. What is the CPI for each state in 2018?
   4. Is it possible to compared the CPI results with FRED data?
*/

SELECT 
    YEAR(main.mimi_src_file_date) as file_year,
    main.state,
    ROUND(SUM(main.monthly_drug_premium), 2) as monthly_premium,
    COALESCE(base_2018.base_2018_premium, 0) as base_month_premium,
    ROUND((SUM(main.monthly_drug_premium) / COALESCE(base_2018.base_2018_premium, 1)) * 100, 2) as CPI
FROM mimi_ws_1.partcd.landscape_prescription_drug_plan AS main
LEFT JOIN (
    SELECT 
        state,
        ROUND(SUM(monthly_drug_premium), 2) as base_2018_premium
    FROM mimi_ws_1.partcd.landscape_prescription_drug_plan
    WHERE YEAR(mimi_src_file_date) = 2018
        AND state IS NOT NULL
        AND monthly_drug_premium IS NOT NULL
        AND mimi_src_file_date IS NOT NULL
    GROUP BY state
) AS base_2018
ON main.state = base_2018.state
WHERE main.state IS NOT NULL
    AND main.monthly_drug_premium IS NOT NULL
    AND main.mimi_src_file_date IS NOT NULL
GROUP BY YEAR(main.mimi_src_file_date), main.state, base_2018.base_2018_premium
ORDER BY YEAR(main.mimi_src_file_date)