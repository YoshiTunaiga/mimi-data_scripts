/*
    This SQL script performs an analysis on the FFS Medicare beneficiaries using Hospital Inpatient services and Hospital Outpatient department services.
    It calculates various statistics and correlations related to Medicare beneficiaries' inpatient and outpatient service usage, focusing on Florida counties, and groups the results by year.


    Questions:
    1. What is the average percentage of dual beneficiaries in Florida counties?
    2. How is the correlation between the percentage of dual beneficiaries and the average risk score?
    3. Which Florida counties have the highest correlation between the percentage of dual beneficiaries and the average risk score?
*/

SELECT 
    year,
    AVG(bene_dual_pct) AS average_dual_beneficiaries, -- The average percentage of beneficiaries eligible for both Medicare and Medicaid.
    AVG(bene_avg_risk_scre) AS average_risk_score, -- The average risk score of the beneficiaries.
    SUM(benes_ip_cvrd_stay_cnt) AS total_inpatient_stays, -- The total number of inpatient stays.
    SUM(acute_hosp_readmsn_cnt) AS total_readmissions, -- The total number of readmissions within 30 days of an acute hospital stay.
    (SUM(benes_ip_cvrd_stay_cnt) - SUM(acute_hosp_readmsn_cnt)) AS difference, -- The difference between the total inpatient stays and total readmissions.
    CORR(bene_avg_risk_scre, benes_ip_cvrd_stay_cnt) AS risk_stay_corr, -- The correlation between the average risk score and the number of inpatient stays.
    CORR(bene_dual_pct, bene_avg_risk_scre) AS bene_correlation -- The correlation between the percentage of dual beneficiaries and the average risk score.
FROM 
    geovariation
WHERE bene_geo_lvl = 'County'
    AND bene_geo_cd IS NOT NULL
    AND benes_ip_cvrd_stay_cnt IS NOT NULL
    AND acute_hosp_readmsn_cnt IS NOT NULL
    AND bene_geo_desc LIKE 'FL%'
GROUP BY 
    year;

-- COMMAND ----------