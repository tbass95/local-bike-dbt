with product_revenue as (
    select
        product_id,
        product_name,
        brand_name,
        total_revenue
    from {{ ref('sales_by_product') }}
    where total_revenue > 0
),
ranked as (
    select
        product_id,
        product_name,
        brand_name,
        total_revenue,
        row_number() over (order by total_revenue desc) as revenue_rank,
        sum(total_revenue) over () as total_company_revenue,
        sum(total_revenue) over (order by total_revenue desc rows unbounded preceding) as cumulative_revenue
    from product_revenue
)
select
    product_id,
    product_name,
    brand_name,
    total_revenue,
    revenue_rank,
    total_company_revenue,
    cumulative_revenue,
    round(cumulative_revenue / total_company_revenue * 100, 2) as cumulative_revenue_pct,
    case
        when cumulative_revenue / total_company_revenue <= 0.8 then 'TOP_80'
        else 'LONG_TAIL'
    end as pareto_segment
from ranked
order by revenue_rank
