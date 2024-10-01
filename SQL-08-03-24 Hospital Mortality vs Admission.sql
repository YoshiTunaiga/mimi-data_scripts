/*
this query aggregates healthcare data by year for the state of Florida, 
calculating total discharges, counts of beneficiaries in different age groups, 
and the mortality rate for beneficiaries under 65 years old. 
The results are grouped by year and ordered chronologically.
*/

SELECT 
    YEAR(CAST(_input_file_date AS DATE)) AS year,
    SUM(tot_dschrgs) AS total_discharges,
    SUM(bene_age_lt_65_cnt) AS total_mort_lt_65_age,
    SUM( bene_age_75_84_cnt) AS total_mort_75_84,
    SUM(bene_age_65_74_cnt) AS total_mort_65_74,
    SUM(bene_age_gt_84_cnt) AS total_mort_gt_84,
    ROUND(SUM(bene_age_lt_65_cnt/tot_dschrgs),2) AS mortality_rate
FROM 
    mimi_ws_1.datacmsgov.mupihp_prvdr
WHERE 
    rndrng_prvdr_state_abrvtn = 'FL'
GROUP BY 
    YEAR(CAST(_input_file_date AS DATE))
ORDER BY 
    year;