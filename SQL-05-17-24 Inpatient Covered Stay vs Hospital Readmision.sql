/*
  This SQL script is designed to query a database table named geovariation to retrieve and analyze data related to Medicare Fee-for-Service (FFS) beneficiaries in Florida counties. 
  The script focuses on comparing the number of inpatient readmissions within 30 days to the total count of beneficiaries using hospital inpatient services with at least one covered stay. 

  -- AND bene_geo_desc NOT LIKE '%-%'
  -- AND bene_geo_desc NOT IN ('National', 'Territory', 'ZZ')

  Questions
  1. What is the difference between the number of inpatient readmissions within 30 days and 
    the total count of FFS Medicare beneficiaries using Hospital Inpatient services with at least one covered stay?
  2. How does the percentage of inpatient readmissions within 30 days 
    compare to the total count of FFS Medicare beneficiaries using Hospital Inpatient services with at least one covered stay?
  3. What is the percentage of Medicare Fee-for-Service beneficiaries who are eligible for Medicaid for at least one month in the year?

  The purpose of this query is to analyze the difference between the number of inpatient readmissions 
  within 30 days and the total count of beneficiaries using hospital inpatient services, specifically for Florida counties.
  The results will help in understanding the readmission rates and their impact on the overall inpatient service usage.
*/

SELECT
  year,
  bene_geo_cd, -- The geographic code for the beneficiary's location.
  bene_geo_desc, -- The geographic description (e.g., county name).
  bene_dual_pct, -- Percentage of Medicare Fee‐for‐Service beneficiaries who are eligible for Medicaid for at least one month in the year.
  bene_avg_risk_scre, -- The average risk score of the beneficiaries.
  benes_ip_cvrd_stay_cnt, --  Number of FFS Medicare beneficiaries using Hospital Inpatient services with at least one covered stay
  acute_hosp_readmsn_cnt, -- Total count of inpatient readmissions within 30 days of an acute hospital stay during the reference period, where the reference period refers to an inpatient hospital stay during the calendar year, regardless of whether the readmission was planned or unplanned
  benes_ip_cvrd_stay_cnt - acute_hosp_readmsn_cnt AS difference
FROM geovariation
WHERE bene_geo_lvl = 'County' 
  AND bene_geo_cd IS NOT NULL
  AND benes_ip_cvrd_stay_cnt IS NOT NULL
  AND acute_hosp_readmsn_cnt IS NOT NULL
  AND bene_geo_desc LIKE 'FL%';

