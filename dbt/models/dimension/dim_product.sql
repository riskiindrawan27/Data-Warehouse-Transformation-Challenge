-- Dimension Product with SCD Type 2 structure
-- Simplified for Trino/MySQL compatibility

{{ config(
    materialized='table'
) }}

WITH source_data AS (
    SELECT
        product_id,
        product_name,
        category,
        subcategory,
        unit_price,
        cost_price,
        profit_margin,
        updated_at
    FROM {{ ref('stg_products') }}
)

SELECT
    CONCAT('PROD_', CAST(product_id AS VARCHAR)) AS product_key,
    product_id,
    product_name,
    category,
    subcategory,
    unit_price,
    cost_price,
    profit_margin,
    updated_at AS valid_from,
    CAST(NULL AS TIMESTAMP) AS valid_to,
    TRUE AS is_current
FROM source_data
