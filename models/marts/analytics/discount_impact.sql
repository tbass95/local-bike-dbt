with sales as (
    select * from {{ ref('fact_sales') }}
),
buckets as (
    select
        case
            when discount = 0 then 'AUCUNE'
            when discount <= 0.05 then '0-5%'
            when discount <= 0.10 then '5-10%'
            when discount <= 0.15 then '10-15%'
            else '15%+'
        end as discount_bucket,
        case
            when discount = 0 then 0
            when discount <= 0.05 then 1
            when discount <= 0.10 then 2
            when discount <= 0.15 then 3
            else 4
        end as bucket_order,
        quantity,
        gross_revenue,
        discount_amount,
        net_revenue
    from sales
)
select
    discount_bucket,
    count(*) as nb_lines,
    sum(quantity) as total_units_sold,
    round(sum(gross_revenue), 2) as total_gross_revenue,
    round(sum(discount_amount), 2) as total_discount_given,
    round(sum(net_revenue), 2) as total_net_revenue,
    round(sum(discount_amount) / nullif(sum(gross_revenue), 0) * 100, 2) as discount_rate_pct,
    round(avg(net_revenue), 2) as avg_line_value
from buckets
group by 1, bucket_order
order by bucket_order
