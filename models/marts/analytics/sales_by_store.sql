with sales as (
    select * from {{ ref('fact_sales') }}
),
stores as (
    select * from {{ ref('dim_stores') }}
),
aggregated as (
    select
        s.store_id,
        st.store_name,
        st.city as store_city,
        st.state as store_state,
        count(distinct s.order_id) as total_orders,
        sum(s.quantity) as total_units_sold,
        round(sum(s.net_revenue), 2) as total_revenue,
        round(sum(s.discount_amount), 2) as total_discounts,
        round(avg(s.net_revenue), 2) as avg_line_value,
        min(s.order_date) as first_sale_date,
        max(s.order_date) as last_sale_date
    from sales s
    left join stores st on s.store_id = st.store_id
    group by 1, 2, 3, 4
)
select * from aggregated
