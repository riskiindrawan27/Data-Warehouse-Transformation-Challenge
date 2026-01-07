-- Staging model for shippers
-- Raw shipper data with basic transformations

WITH source AS (
    SELECT 
        shipper_id,
        shipper_name,
        phone,
        created_at
    FROM {{ source('retail', 'shippers') }}
)

SELECT
    shipper_id,
    TRIM(shipper_name) AS shipper_name,
    phone,
    created_at
FROM source
