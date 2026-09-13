with orders_enriched as (
    select * from {{ ref('int_orders_enriched') }}
),

final as (
    select
        {{ dbt_utils.generate_surrogate_key(['order_id', 'item_id']) }} as sale_key,
        order_id,
        item_id,
        customer_id,
        product_id,
        store_id,
        staff_id,
        order_date as date_id,
        order_date,
        shipped_date,
        shipping_days,
        quantity,
        list_price,
        discount,
        gross_revenue,
        discount_amount,
        net_revenue,
        brand_name,
        category_name
    from orders_enriched
)

select * from final
