with stocks as (
    select * from {{ ref('int_stocks_enriched') }}
)
select
    store_id,
    store_name,
    store_city,
    product_id,
    product_name,
    brand_name,
    category_name,
    stock_quantity,
    stock_value,
    list_price,
    stock_status
from stocks
where stock_status in ('RUPTURE', 'CRITIQUE', 'FAIBLE')
order by
    case stock_status
        when 'RUPTURE' then 1
        when 'CRITIQUE' then 2
        when 'FAIBLE' then 3
    end,
    stock_value desc
