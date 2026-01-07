-- Sales Summary Mart
-- Aggregated sales data for reporting and analytics

WITH sales AS (
    SELECT
        date_key,
        customer_id,
        product_id,
        store_id,
        order_status,
        quantity,
        gross_amount,
        discount_amount,
        net_amount,
        cost_amount,
        profit_amount
    FROM {{ ref('fact_sales') }}
),

date_dim AS (
    SELECT
        date_day,
        year,
        quarter,
        month,
        month_name,
        day_name,
        is_weekend
    FROM {{ ref('dim_date') }}
),

customer_dim AS (
    SELECT
        customer_id,
        customer_name,
        city AS customer_city,
        state AS customer_state
    FROM {{ ref('dim_customer') }}
    WHERE is_current = 1
),

product_dim AS (
    SELECT
        product_id,
        product_name,
        category,
        subcategory
    FROM {{ ref('dim_product') }}
    WHERE is_current = 1
),

store_dim AS (
    SELECT
        store_id,
        store_name,
        city AS store_city,
        state AS store_state
    FROM {{ ref('dim_store') }}
)

SELECT
    d.date_day,
    d.year,
    d.quarter,
    d.month,
    d.month_name,
    d.day_name,
    d.is_weekend,
    c.customer_name,
    c.customer_city,
    c.customer_state,
    p.product_name,
    p.category,
    p.subcategory,
    st.store_name,
    st.store_city,
    st.store_state,
    s.order_status,
    SUM(s.quantity) AS total_quantity,
    COUNT(DISTINCT s.customer_id) AS unique_customers,
    COUNT(DISTINCT date_key) AS order_count,
    ROUND(SUM(s.gross_amount), 2) AS total_gross_amount,
    ROUND(SUM(s.discount_amount), 2) AS total_discount_amount,
    ROUND(SUM(s.net_amount), 2) AS total_net_amount,
    ROUND(SUM(s.cost_amount), 2) AS total_cost_amount,
    ROUND(SUM(s.profit_amount), 2) AS total_profit_amount,
    CASE 
        WHEN SUM(s.net_amount) > 0 THEN 
            ROUND((SUM(s.profit_amount) / SUM(s.net_amount)) * 100, 2)
        ELSE 0
    END AS profit_margin_percent,
    CURRENT_TIMESTAMP AS created_at
FROM sales s
LEFT JOIN date_dim d ON s.date_key = d.date_day
LEFT JOIN customer_dim c ON s.customer_id = c.customer_id
LEFT JOIN product_dim p ON s.product_id = p.product_id
LEFT JOIN store_dim st ON s.store_id = st.store_id
GROUP BY
    d.date_day,
    d.year,
    d.quarter,
    d.month,
    d.month_name,
    d.day_name,
    d.is_weekend,
    c.customer_name,
    c.customer_city,
    c.customer_state,
    p.product_name,
    p.category,
    p.subcategory,
    st.store_name,
    st.store_city,
    st.store_state,
    s.order_status
