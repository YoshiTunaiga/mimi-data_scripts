/*
This SQL script retrieves and summarizes data from the CMS Medicare Part D Prescribers by Provider and Drug dataset
focusing on the top 5 generic drugs with the most claims between 2020 and 2024.

Questions:
1. What is the percentage of claims for the top 5 generic drugs that are refilled in the last 30 days?
2. What are the top 5 generic drugs with the most claims for people aged 65 and over?
3. Which year had the highest percentage of claims for the top 5 generic drugs that were refilled in the last 30 days?
*/

SELECT gnrc_name, 
       SUM(tot_clms) AS total_claims, 
       COUNT(tot_30day_fills) AS total_30day_refill, 
       COUNT(ge65_tot_30day_fills) AS total_ge65_30day_refill, 
       ROUND(COUNT(ge65_tot_30day_fills) * 100.0 / COUNT(tot_30day_fills), 1) AS refill_percentage
FROM mimi_ws_1.datacmsgov.mupdpr
WHERE _input_file_date >= '2020-01-01' AND _input_file_date <= '2024-12-31'
GROUP BY gnrc_name
ORDER BY total_claims DESC
LIMIT 5;

-- COMMAND ----------