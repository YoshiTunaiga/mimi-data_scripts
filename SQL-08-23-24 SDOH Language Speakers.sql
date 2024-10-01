/*
Purpose: 
  The query aggregates population and language data for counties in Florida, 
  providing a breakdown of English, Spanish, API (Asian Pacific Islander), and other language speakers.
  
  - Verified Florida has 67 counties
  Comment: The code starts with a comment indicating that Florida has 67 counties.

The query retrieves and aggregates population and language data for each county in Florida, 
grouping by relevant geographic and administrative fields, and orders the results by total population in descending order.

SELECT Clause:

state, territory, countyfips, statefips, region, and county (aliased as city) are selected directly.
SUM(acs_tot_pop_wt) AS total_population: Sums the total population weight for each county.
ROUND(SUM(acs_pct_english * acs_tot_pop_wt / 100), 0) AS english_speakers: Calculates the number of English speakers by summing the weighted percentage of English speakers and rounding to the nearest whole number.
Similar calculations are done for Spanish speakers (acs_pct_spanish), API language speakers (acs_pct_api_lang), and other language speakers (acs_pct_oth_lang).
FROM Clause: Specifies the table mimi_ws_1.ahrq.sdohdb_tract as the data source.

WHERE Clause: Filters the data to include only records where the state is 'Florida'.

GROUP BY Clause: Groups the results by state, county, territory, region, countyfips, and statefips.

ORDER BY Clause: Orders the results by total_population in descending order, so the counties with the highest population appear first.
*/

SELECT 
    state,
    territory,
    countyfips,
    statefips,
    region,
    county AS city,
    SUM(acs_tot_pop_wt) AS total_population,
    ROUND(SUM(acs_pct_english * acs_tot_pop_wt / 100), 0) AS english_speakers,
    ROUND(SUM(acs_pct_spanish * acs_tot_pop_wt / 100),0) AS spanish_speakers,
    ROUND(SUM(acs_pct_api_lang * acs_tot_pop_wt / 100),0) AS api_language_speakers, -- asian pacific island
    ROUND(SUM(acs_pct_oth_lang * acs_tot_pop_wt / 100),0) AS other_language_speakers
FROM 
    mimi_ws_1.ahrq.sdohdb_tract
WHERE
    state = 'Florida'
GROUP BY 
    state, county, territory,region,countyfips,
    statefips
ORDER BY    
    total_population DESC