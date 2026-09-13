with sales as (
    select * from {{ ref('fact_sales') }}
),
aggregated as (
    select
        extract(year from order_date) as year,
        extract(month from order_date) as month,
        format_date('%Y-%m', order_date) as year_month,
        count(distinct order_id) as nb_orders,
        sum(quantity) as units_sold,
        round(sum(net_revenue), 2) as total_revenue,
        round(sum(discount_amount), 2) as total_discounts,
        round(avg(net_revenue), 2) as avg_line_value
    from sales
    group by 1, 2, 3
)
select * from aggregated
order by year, month
