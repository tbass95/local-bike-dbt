with source as (
    select * from {{ source('raw_data', 'order_items') }}
),

renamed as (
    select
        cast(order_id as int64) as order_id,
        cast(item_id as int64) as item_id,
        cast(product_id as int64) as product_id,
        cast(quantity as int64) as quantity,
        cast(list_price as float64) as list_price,
        cast(discount as float64) as discount,
        cast(quantity * list_price as float64) as gross_revenue,
        cast(quantity * list_price * discount as float64) as discount_amount,
        cast(quantity * list_price * (1 - discount) as float64) as net_revenue
    from source
)

select * from renamed
