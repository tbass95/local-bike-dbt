with order_items as (
    select * from {{ ref('stg_order_items') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

products as (
    select * from {{ ref('stg_products') }}
),

brands as (
    select * from {{ ref('stg_brands') }}
),

categories as (
    select * from {{ ref('stg_categories') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

stores as (
    select * from {{ ref('stg_stores') }}
),

staffs as (
    select * from {{ ref('stg_staffs') }}
),

joined as (
    select
        -- Order line identifiers
        oi.order_id,
        oi.item_id,
        oi.product_id,
        o.customer_id,
        o.store_id,
        o.staff_id,
        
        -- Order info
        o.order_date,
        o.required_date,
        o.shipped_date,
        o.order_status,
        date_diff(o.shipped_date, o.order_date, day) as shipping_days,
        
        -- Product info
        p.product_name,
        p.model_year,
        p.list_price as product_list_price,
        b.brand_name,
        c.category_name,
        
        -- Customer info
        cust.full_name as customer_name,
        cust.city as customer_city,
        cust.state as customer_state,
        
        -- Store info
        st.store_name,
        st.city as store_city,
        st.state as store_state,
        
        -- Staff info
        sf.full_name as staff_name,
        sf.manager_id as staff_manager_id,
        
        -- Financials
        oi.quantity,
        oi.list_price,
        oi.discount,
        oi.gross_revenue,
        oi.discount_amount,
        oi.net_revenue
    from order_items oi
    left join orders o on oi.order_id = o.order_id
    left join products p on oi.product_id = p.product_id
    left join brands b on p.brand_id = b.brand_id
    left join categories c on p.category_id = c.category_id
    left join customers cust on o.customer_id = cust.customer_id
    left join stores st on o.store_id = st.store_id
    left join staffs sf on o.staff_id = sf.staff_id
)

select * from joined
where order_status = 4  -- uniquement les commandes livrées
