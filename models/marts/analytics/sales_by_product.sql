with sales as (
    select * from {{ ref('fact_sales') }}
),
products as (
    select * from {{ ref('dim_products') }}
),
aggregated as (
    select
        p.product_id,
        p.product_name,
        p.brand_name,
        p.category_name,
        p.model_year,
        p.list_price,
        count(distinct s.order_id) as total_orders,
        sum(s.quantity) as total_units_sold,
        round(sum(s.net_revenue), 2) as total_revenue,
        round(sum(s.discount_amount), 2) as total_discounts,
        round(avg(s.discount), 4) as avg_discount_rate
    from sales s
    left join products p on s.product_id = p.product_id
    group by 1, 2, 3, 4, 5, 6
)
select * from aggregated
order by total_revenue desc
