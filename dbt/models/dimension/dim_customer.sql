-- Dimension Customer with SCD Type 2 structure
-- Simplified for Trino/MySQL compatibility

{{ config(
    materialized='table'
) }}

WITH source_data AS (
    SELECT
        customer_id,
        customer_name,
        email,
        phone,
        city,
        state,
        country,
        updated_at
    FROM {{ ref('stg_customers') }}
)

SELECT
    CONCAT('CUST_', CAST(customer_id AS VARCHAR)) AS customer_key,
    customer_id,
    customer_name,
    email,
    phone,
    city,
    state,
    country,
    updated_at AS valid_from,
    CAST(NULL AS TIMESTAMP) AS valid_to,
    TRUE AS is_current
FROM source_data
