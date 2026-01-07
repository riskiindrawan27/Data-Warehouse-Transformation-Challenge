-- Staging model for stores
-- Raw store data with basic transformations

WITH source AS (
    SELECT 
        store_id,
        store_name,
        city,
        state,
        country,
        created_at
    FROM {{ source('retail', 'stores') }}
)

SELECT
    store_id,
    TRIM(store_name) AS store_name,
    TRIM(city) AS city,
    TRIM(state) AS state,
    TRIM(country) AS country,
    created_at
FROM source
