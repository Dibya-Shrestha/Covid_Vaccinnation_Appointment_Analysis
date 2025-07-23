use Covid_Appointment;

select * from dbo.Table6;

-- Restructuring SQL Table by converting the original table from Wide to Long Format

-- Step 1: Create empty table for reshaped data
CREATE TABLE dbo.table6_long (
    type NVARCHAR(100),        
    nhs_area_code NVARCHAR(50),
    ons_code NVARCHAR(50),
    name NVARCHAR(200),
    month VARCHAR(10),
    appointment_count INT
);

SELECT
    type,
    nhs_area_code,
    ons_code,
    name,
    CAST('dec_22' AS varchar(10)) AS month,
    CAST(0 AS int) AS appointment_count
INTO dbo.table6_long
FROM dbo.table6
WHERE 1=0;

-- Step 2: Insert reshaped data into new table
INSERT INTO dbo.table6_long (type, nhs_area_code, ons_code, name, month, appointment_count)
SELECT type, nhs_area_code, ons_code, name, 'dec_22', dec_22 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'jan_23', jan_23 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'feb_23', feb_23 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'mar_23', mar_23 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'apr_23', apr_23 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'may_23', may_23 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'jun_23', jun_23 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'jul_23', jul_23 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'aug_23', aug_23 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'sep_23', sep_23 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'oct_23', oct_23 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'nov_23', nov_23 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'dec_23', dec_23 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'jan_24', jan_24 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'feb_24', feb_24 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'mar_24', mar_24 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'apr_24', apr_24 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'may_24', may_24 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'jun_24', jun_24 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'jul_24', jul_24 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'aug_24', aug_24 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'sep_24', sep_24 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'oct_24', oct_24 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'nov_24', nov_24 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'dec_24', dec_24 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'jan_25', jan_25 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'feb_25', feb_25 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'mar_25', mar_25 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'apr_25', apr_25 FROM dbo.table6
UNION ALL
SELECT type, nhs_area_code, ons_code, name, 'may_25', may_25 FROM dbo.table6;

-- Displaying data from the new table
select * from dbo.Table6_long;

-- Total appointments per month across all regions (aggregated)
SELECT
  month,
  SUM(appointment_count) AS total_appointments
FROM dbo.table6_long
WHERE type = 'region'
GROUP BY month
ORDER BY month;

-- Total appointments per ICB overall (all months combined)
SELECT
  name,
  SUM(appointment_count) AS total_appointments
FROM dbo.table6_long
WHERE type = 'ICB'
GROUP BY name
ORDER BY total_appointments DESC;

--Top 5 ICBs with the highest total appointments (all months)
SELECT TOP 5
  name,
  SUM(appointment_count) AS total_appointments
FROM dbo.table6_long
WHERE type = 'ICB'
GROUP BY name
ORDER BY total_appointments DESC;

--ICBs with zero appointments in any month (possible data gaps)
SELECT
  name,
  month,
  appointment_count
FROM dbo.table6_long
WHERE type = 'ICB' AND appointment_count = 0
ORDER BY name, month;

--Average appointments per month per ICB
SELECT
  name,
  AVG(appointment_count) AS avg_monthly_appointments
FROM dbo.table6_long
WHERE type = 'ICB'
GROUP BY name
ORDER BY avg_monthly_appointments DESC;

--Total appointments per ICB in 2023
SELECT
  name,
  SUM(appointment_count) AS total_appointments_2023
FROM dbo.table6_long
WHERE type = 'ICB' AND month LIKE '%_23'
GROUP BY name
ORDER BY total_appointments_2023 DESC;

--Share of Each ICB Within Its Region
SELECT
  name AS region_name, 
  SUM(appointment_count) AS total_appointment, 
  ROUND(
    100.0 * SUM(appointment_count) / 
    (SELECT SUM(appointment_count)
     FROM dbo.table6_long
     WHERE type='region' AND month LIKE '%24')
  , 2) AS percentage
FROM dbo.table6_long
WHERE type='region' AND month LIKE '%24'
GROUP BY name
ORDER BY percentage DESC;

--region with the highest appointment count in Dec 2024
SELECT TOP 1
  name AS region_name,
  SUM(appointment_count) AS total_appointments
FROM dbo.table6_long
WHERE type = 'region' AND month = 'Dec_24'
GROUP BY name
ORDER BY total_appointments DESC;

--Regions with a Drop in Appointments in 2024 vs 2023
SELECT 
  name AS region_name,
  SUM(CASE WHEN month LIKE '%23' THEN appointment_count ELSE 0 END) AS total_2023,
  SUM(CASE WHEN month LIKE '%24' THEN appointment_count ELSE 0 END) AS total_2024,
  SUM(CASE WHEN month LIKE '%24' THEN appointment_count ELSE 0 END) - 
  SUM(CASE WHEN month LIKE '%23' THEN appointment_count ELSE 0 END) AS change_in_appointments
FROM dbo.table6_long
WHERE type = 'region'
GROUP BY name
HAVING SUM(CASE WHEN month LIKE '%24' THEN appointment_count ELSE 0 END) < 
       SUM(CASE WHEN month LIKE '%23' THEN appointment_count ELSE 0 END)
ORDER BY change_in_appointments;


