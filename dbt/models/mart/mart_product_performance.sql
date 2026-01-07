-- Product Performance Mart
-- Product-level performance metrics

WITH sales AS (
    SELECT
        product_id,
        date_key,
        quantity,
        gross_amount,
        discount_amount,
        net_amount,
        cost_amount,
        profit_amount,
        order_status
    FROM {{ ref('fact_sales') }}
),

product_dim AS (
    SELECT
        product_id,
        product_name,
        category,
        subcategory,
        unit_price,
        cost_price
    FROM {{ ref('dim_product') }}
    WHERE is_current = 1
)

SELECT
    p.product_id,
    p.product_name,
    p.category,
    p.subcategory,
    p.unit_price AS current_unit_price,
    p.cost_price AS current_cost_price,
    COUNT(DISTINCT s.date_key) AS total_orders,
    SUM(s.quantity) AS total_quantity_sold,
    ROUND(SUM(s.gross_amount), 2) AS total_gross_revenue,
    ROUND(SUM(s.discount_amount), 2) AS total_discount_given,
    ROUND(SUM(s.net_amount), 2) AS total_net_revenue,
    ROUND(SUM(s.cost_amount), 2) AS total_cost,
    ROUND(SUM(s.profit_amount), 2) AS total_profit,
    CASE 
        WHEN SUM(s.net_amount) > 0 THEN 
            ROUND((SUM(s.profit_amount) / SUM(s.net_amount)) * 100, 2)
        ELSE 0
    END AS profit_margin_percent,
    CASE 
        WHEN SUM(s.quantity) > 0 THEN 
            ROUND(SUM(s.net_amount) / SUM(s.quantity), 2)
        ELSE 0
    END AS avg_selling_price,
    ROUND(AVG(s.net_amount), 2) AS avg_order_value,
    SUM(CASE WHEN s.order_status = 'Delivered' THEN s.quantity ELSE 0 END) AS delivered_quantity,
    SUM(CASE WHEN s.order_status = 'Pending' THEN s.quantity ELSE 0 END) AS pending_quantity,
    CURRENT_TIMESTAMP AS created_at
FROM product_dim p
LEFT JOIN sales s ON p.product_id = s.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category,
    p.subcategory,
    p.unit_price,
    p.cost_price
