/*
This SQL script aggregates data from the CMS Medicare Utilization and Payment (MUP) dataset
focusing on the counts of male and female providers who rendered services for the HCPCS codes G0121 and G0105 
as well as the number of beneficiaries who received the service for each HCPCS code.

NOTE: Use /explain on the Databricks Assistant view (Toggle Assistant, top-right on the cell) to know more about the script like the different clauses

Questions:
1. What is the total number of male and female providers who rendered services for the HCPCS codes G0121 and G0105?
2. What is the male to female ratio when rendering services for the HCPCS codes G0121 and G0105?
3. What is the total number of beneficiaries who received the service for each HCPCS code?
4. What is the correlation between male and female providers who rendered services for the HCPCS codes G0121 and G0105?
*/

SELECT 
    SUM(CASE WHEN rndrng_prvdr_gndr = 'M' AND hcpcs_cd = 'G0121' THEN 1 ELSE 0 END) as male_prvdr_count_G0121,
    SUM(CASE WHEN rndrng_prvdr_gndr = 'F' AND hcpcs_cd = 'G0121' THEN 1 ELSE 0 END) as female_prvdr_count_G0121,
    SUM(CASE WHEN rndrng_prvdr_gndr = 'M' AND hcpcs_cd = 'G0105' THEN 1 ELSE 0 END) as male_prvdr_count_G0105,
    SUM(CASE WHEN rndrng_prvdr_gndr = 'F' AND hcpcs_cd = 'G0105' THEN 1 ELSE 0 END) as female_prvdr_count_G0105,
    SUM(tot_benes) as total_beneficiaries, -- // Number of distinct Medicare beneficiaries receiving the service for each HCPCS code
    SUM(CASE WHEN hcpcs_cd = 'G0121' THEN tot_benes ELSE 0 END) as total_benef_G0121,
    SUM(CASE WHEN hcpcs_cd = 'G0105' THEN tot_benes ELSE 0 END) as total_benef_G0105,
    mimi_src_file_date as file_date
FROM mimi_ws_1.datacmsgov.mupphy
WHERE rndrng_prvdr_gndr IS NOT NULL
GROUP BY mimi_src_file_date
ORDER BY file_date

-- COMMAND ----------