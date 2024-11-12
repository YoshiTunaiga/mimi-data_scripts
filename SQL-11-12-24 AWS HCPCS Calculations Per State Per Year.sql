/*
  Summary: This query calculates and groups the total counts of services for the HCPCS codes G0438 and G0439 by provider state and file date.

  Questions
  - What is the difference between G0438 and G0439?
      G0438 - Initial AWV
      G0439 - Subsequent AWV
  - How to calculate the total number of G0438 and G0439?
  - What does XX, MP, ZZ means in the rndrng_prvdr_state_abrvtn column?

*/

WITH calc_mupphy AS (
  SELECT
    rndrng_prvdr_state_abrvtn,
    mimi_src_file_date,
    SUM(CASE WHEN hcpcs_cd = 'G0438' THEN tot_srvcs ELSE 0 END)::numeric(18,0) AS hcpcs_G0438_count,
    SUM(CASE WHEN hcpcs_cd = 'G0439' THEN tot_srvcs ELSE 0 END)::numeric(18,0) AS hcpcs_G0439_count
  FROM mimi_ws_1.datacmsgov.mupphy 
  WHERE hcpcs_cd IN ('G0439', 'G0438')
  GROUP BY rndrng_prvdr_state_abrvtn, mimi_src_file_date
), combined_mupphy AS (
  SELECT 
    rndrng_prvdr_state_abrvtn,
    YEAR(mimi_src_file_date) as file_year,
    hcpcs_G0438_count,
    hcpcs_G0439_count,
    (hcpcs_G0438_count + hcpcs_G0439_count) as total_aws_count
  FROM calc_mupphy
)
SELECT *
FROM combined_mupphy
