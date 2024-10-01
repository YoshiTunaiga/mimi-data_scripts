/*
The SQL code retrieves data from a table called "cdc.vsrr_drugoverdose" and applies several filters to the data.

The filters include:

- Selecting rows where the "year" column is greater than 2020
- Excluding rows where the "state" column is equal to 'US'
- Excluding rows where the "predicted_value" column is NULL

The code then returns all columns from the filtered rows in the "cdc.vsrr_drugoverdose" table.
*/

SELECT  
  state, 
  SUM(data_value) as raw_data_value, 
  SUM(predicted_value) as predicted_value, 
  indicator FROM cdc.vsrr_drugoverdose
WHERE year > 2020
  AND state != 'US'
  AND predicted_value IS NOT NULL
GROUP BY state, indicator
ORDER BY state