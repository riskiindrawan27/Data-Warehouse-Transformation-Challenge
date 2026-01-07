-- Staging model for customers
-- Raw customer data with basic transformations

WITH source AS (
    SELECT 
        customer_id,
        customer_name,
        email,
        phone,
        city,
        state,
        country,
        created_at,
        updated_at
    FROM {{ source('retail', 'customers') }}
)

SELECT
    customer_id,
    TRIM(customer_name) AS customer_name,
    LOWER(TRIM(email)) AS email,
    phone,
    TRIM(city) AS city,
    TRIM(state) AS state,
    TRIM(country) AS country,
    created_at,
    updated_at
FROM source
