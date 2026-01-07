-- Dimension Store (Type 1 - Overwrite)
-- Store information doesn't require historical tracking

SELECT
    store_id,
    store_name,
    city,
    state,
    country,
    created_at,
    CURRENT_TIMESTAMP AS last_updated
FROM {{ ref('stg_stores') }}
