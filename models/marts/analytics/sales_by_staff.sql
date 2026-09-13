with sales as (
    select * from {{ ref('fact_sales') }}
),
staffs as (
    select * from {{ ref('dim_staffs') }}
),
aggregated as (
    select
        s.staff_id,
        sf.full_name as staff_name,
        sf.store_name,
        sf.store_city,
        count(distinct s.order_id) as total_orders,
        sum(s.quantity) as total_units_sold,
        round(sum(s.net_revenue), 2) as total_revenue,
        round(avg(s.net_revenue), 2) as avg_line_value
    from sales s
    left join staffs sf on s.staff_id = sf.staff_id
    group by 1, 2, 3, 4
)
select * from aggregated
order by total_revenue desc
