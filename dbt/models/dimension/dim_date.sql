-- Dimension Date
-- Date dimension for time-based analysis

{{ config(
    materialized='table'
) }}

WITH date_range AS (
    -- Generate dates from 2024-01-01 to 2026-12-31
    SELECT CAST(date_add('day', seq, DATE '2024-01-01') AS DATE) AS date_day
    FROM UNNEST(SEQUENCE(0, 1095)) AS t(seq)
)

SELECT
    date_day,
    YEAR(date_day) AS year,
    QUARTER(date_day) AS quarter,
    MONTH(date_day) AS month,
    DAY(date_day) AS day,
    DAY_OF_WEEK(date_day) AS day_of_week,
    DAY_OF_YEAR(date_day) AS day_of_year,
    WEEK(date_day) AS week_of_year,
    CASE DAY_OF_WEEK(date_day)
        WHEN 1 THEN 'Monday'
        WHEN 2 THEN 'Tuesday'
        WHEN 3 THEN 'Wednesday'
        WHEN 4 THEN 'Thursday'
        WHEN 5 THEN 'Friday'
        WHEN 6 THEN 'Saturday'
        WHEN 7 THEN 'Sunday'
    END AS day_name,
    CASE MONTH(date_day)
        WHEN 1 THEN 'January'
        WHEN 2 THEN 'February'
        WHEN 3 THEN 'March'
        WHEN 4 THEN 'April'
        WHEN 5 THEN 'May'
        WHEN 6 THEN 'June'
        WHEN 7 THEN 'July'
        WHEN 8 THEN 'August'
        WHEN 9 THEN 'September'
        WHEN 10 THEN 'October'
        WHEN 11 THEN 'November'
        WHEN 12 THEN 'December'
    END AS month_name,
    CASE 
        WHEN DAY_OF_WEEK(date_day) IN (6, 7) THEN TRUE
        ELSE FALSE
    END AS is_weekend,
    CONCAT('Q', CAST(QUARTER(date_day) AS VARCHAR), '-', CAST(YEAR(date_day) AS VARCHAR)) AS quarter_name
FROM date_range
