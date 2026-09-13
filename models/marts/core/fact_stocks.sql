with stocks_enriched as (
    select * from {{ ref('int_stocks_enriched') }}
),

final as (
    select
        {{ dbt_utils.generate_surrogate_key(['store_id', 'product_id']) }} as stock_key,
        store_id,
        product_id,
        stock_quantity,
        stock_value,
        stock_status,
        list_price,
        brand_name,
        category_name
    from stocks_enriched
)

select * from final
