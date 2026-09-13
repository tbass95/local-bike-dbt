with orders_enriched as (
    select * from {{ ref('int_orders_enriched') }}
),
customers as (
    select * from {{ ref('stg_customers') }}
),
reference_date as (
    select date_add(max(order_date), interval 1 day) as ref_date
    from orders_enriched
),
rfm_base as (
    select
        customer_id,
        max(order_date) as last_order_date,
        count(distinct order_id) as frequency,
        round(sum(net_revenue), 2) as monetary
    from orders_enriched
    group by 1
),
rfm_scores as (
    select
        r.customer_id,
        c.full_name as customer_name,
        c.city,
        c.state,
        r.last_order_date,
        date_diff((select ref_date from reference_date), r.last_order_date, day) as recency_days,
        r.frequency,
        r.monetary,
        ntile(4) over (order by date_diff((select ref_date from reference_date), r.last_order_date, day) desc) as r_score,
        ntile(4) over (order by r.frequency) as f_score,
        ntile(4) over (order by r.monetary) as m_score
    from rfm_base r
    left join customers c on r.customer_id = c.customer_id
)
select
    customer_id,
    customer_name,
    city,
    state,
    last_order_date,
    recency_days,
    frequency,
    monetary,
    r_score,
    f_score,
    m_score,
    concat(cast(r_score as string), cast(f_score as string), cast(m_score as string)) as rfm_segment,
    case
        when r_score = 4 and f_score = 4 and m_score = 4 then 'CHAMPION'
        when r_score >= 3 and f_score >= 3 then 'FIDELE'
        when r_score >= 3 and f_score <= 2 then 'NOUVEAU_PROMETTEUR'
        when r_score <= 2 and f_score >= 3 then 'A_RISQUE'
        when r_score = 1 and f_score = 1 then 'PERDU'
        else 'A_REACTIVER'
    end as customer_segment
from rfm_scores
