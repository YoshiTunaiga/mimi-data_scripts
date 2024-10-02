/*
  This SQL query retrieves the top 10 CBSA areas with the highest average PM2.5 air quality index for the year 2022.

  Questions:
  1. How do the top 10 CBSAs with highest average PM2.5 AQI compare in terms of:
    - Population density
    - Industrial activity
    - Geographic features (valley locations, proximity to wildfire-prone areas)
  2. Are there common characteristics among these metropolitan areas that might explain their elevated PM2.5 levels?
  3. How does the PM2.5 AQI vary across different seasons for these 10 tops CBSAs?
  4. Are there specific months or time periods when PM2.5 levels spike?
  5. Are these high AQI levels part of a longer-term trend or an anomaly?
  6. Is there a correlation between these high PM2.5 levels and reported respiratory health issues in these regions?
*/

SELECT 
  YEAR(CAST(date AS DATE)) AS year,
  ROUND(AVG(aqi), 2) as aqi_avg,
  cbsa
FROM mimi_ws_1.epa.airdata_daily_cbsa
WHERE 
  defining_parameter == 'PM2.5'
  AND YEAR(CAST(date AS DATE)) == '2022'
GROUP BY cbsa, year
ORDER BY aqi_avg DESC
LIMIT 10