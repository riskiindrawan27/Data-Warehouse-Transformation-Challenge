-- Fact Sales
-- Contains transactional sales data with foreign keys to dimensions

WITH orders AS (
    SELECT
        order_id,
        customer_id,
        store_id,
        shipper_id,
        order_date,
        ship_date,
        ship_mode,
        order_status,
        days_to_ship
    FROM {{ ref('stg_orders') }}
),

order_items AS (
    SELECT
        order_item_id,
        order_id,
        product_id,
        quantity,
        discount
    FROM {{ ref('stg_order_items') }}
),

products AS (
    SELECT
        product_id,
        unit_price,
        cost_price
    FROM {{ ref('stg_products') }}
),

sales_detail AS (
    SELECT
        oi.order_item_id,
        o.order_id,
        o.customer_id,
        oi.product_id,
        o.store_id,
        o.shipper_id,
        o.order_date,
        o.ship_date,
        o.ship_mode,
        o.order_status,
        o.days_to_ship,
        oi.quantity,
        p.unit_price,
        p.cost_price,
        oi.discount,
        -- Calculate amounts
        ROUND(oi.quantity * p.unit_price, 2) AS gross_amount,
        ROUND(oi.quantity * p.unit_price * (oi.discount / 100), 2) AS discount_amount,
        ROUND(oi.quantity * p.unit_price * (1 - oi.discount / 100), 2) AS net_amount,
        ROUND(oi.quantity * p.cost_price, 2) AS cost_amount
    FROM order_items oi
    INNER JOIN orders o ON oi.order_id = o.order_id
    INNER JOIN products p ON oi.product_id = p.product_id
)

SELECT
    order_item_id AS sales_key,
    order_id,
    customer_id,
    product_id,
    store_id,
    shipper_id,
    order_date AS date_key,
    ship_date,
    ship_mode,
    order_status,
    days_to_ship,
    quantity,
    unit_price,
    cost_price,
    discount AS discount_percent,
    gross_amount,
    discount_amount,
    net_amount,
    cost_amount,
    ROUND(net_amount - cost_amount, 2) AS profit_amount,
    CASE 
        WHEN net_amount > 0 THEN ROUND((net_amount - cost_amount) / net_amount * 100, 2)
        ELSE 0
    END AS profit_margin_percent,
    CURRENT_TIMESTAMP AS created_at
FROM sales_detail
