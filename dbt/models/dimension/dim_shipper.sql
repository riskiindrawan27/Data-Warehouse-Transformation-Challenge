-- Dimension Shipper (Type 1 - Overwrite)
-- Shipper information doesn't require historical tracking

SELECT
    shipper_id,
    shipper_name,
    phone,
    created_at,
    CURRENT_TIMESTAMP AS last_updated
FROM {{ ref('stg_shippers') }}
