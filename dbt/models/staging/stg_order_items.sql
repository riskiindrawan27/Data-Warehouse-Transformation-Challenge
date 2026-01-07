-- Staging model for order items
-- Raw order items data with basic transformations

WITH source AS (
    SELECT 
        order_item_id,
        order_id,
        product_id,
        quantity,
        discount,
        created_at
    FROM {{ source('retail', 'order_items') }}
)

SELECT
    order_item_id,
    order_id,
    product_id,
    quantity,
    discount,
    created_at
FROM source
