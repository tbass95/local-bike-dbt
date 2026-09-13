with orders_enriched as (
    select * from {{ ref('int_orders_enriched') }}
),

aggregated as (
    select
        customer_id,
        customer_name,
        customer_city,
        customer_state,
        count(distinct order_id) as nb_orders,
        sum(quantity) as total_items_bought,
        round(sum(net_revenue), 2) as total_revenue,
        round(avg(net_revenue), 2) as avg_line_value,
        min(order_date) as first_order_date,
        max(order_date) as last_order_date,
        date_diff(max(order_date), min(order_date), day) as customer_lifetime_days
    from orders_enriched
    group by 1, 2, 3, 4
)

select * from aggregated
