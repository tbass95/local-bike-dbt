with stocks as (
    select * from {{ ref('stg_stocks') }}
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

stores as (
    select * from {{ ref('stg_stores') }}
),

enriched as (
    select
        s.store_id,
        s.product_id,
        p.product_name,
        b.brand_name,
        c.category_name,
        p.list_price,
        st.store_name,
        st.city as store_city,
        st.state as store_state,
        s.quantity as stock_quantity,
        cast(s.quantity * p.list_price as float64) as stock_value,
        case
            when s.quantity = 0 then 'RUPTURE'
            when s.quantity <= 5 then 'CRITIQUE'
            when s.quantity <= 10 then 'FAIBLE'
            when s.quantity <= 25 then 'OK'
            else 'SURSTOCK'
        end as stock_status
    from stocks s
    left join products p on s.product_id = p.product_id
    left join brands b on p.brand_id = b.brand_id
    left join categories c on p.category_id = c.category_id
    left join stores st on s.store_id = st.store_id
)

select * from enriched
