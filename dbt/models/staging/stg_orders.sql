-- Staging model for orders
-- Raw order data with basic transformations

WITH source AS (
    SELECT 
        order_id,
        customer_id,
        store_id,
        shipper_id,
        order_date,
        ship_date,
        ship_mode,
        order_status,
        created_at,
        updated_at
    FROM {{ source('retail', 'orders') }}
)

SELECT
    order_id,
    customer_id,
    store_id,
    shipper_id,
    order_date,
    ship_date,
    TRIM(ship_mode) AS ship_mode,
    TRIM(order_status) AS order_status,
    CASE 
        WHEN ship_date IS NOT NULL THEN DATE_DIFF('day', order_date, ship_date)
        ELSE NULL 
    END AS days_to_ship,
    created_at,
    updated_at
FROM source
