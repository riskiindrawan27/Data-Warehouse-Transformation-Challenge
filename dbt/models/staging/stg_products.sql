-- Staging model for products
-- Raw product data with basic transformations

WITH source AS (
    SELECT 
        product_id,
        product_name,
        category,
        subcategory,
        unit_price,
        cost_price,
        created_at,
        updated_at
    FROM {{ source('retail', 'products') }}
)

SELECT
    product_id,
    TRIM(product_name) AS product_name,
    TRIM(category) AS category,
    TRIM(subcategory) AS subcategory,
    unit_price,
    cost_price,
    ROUND(unit_price - cost_price, 2) AS profit_margin,
    created_at,
    updated_at
FROM source
