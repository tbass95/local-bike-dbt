with customers as (
    select * from {{ ref('stg_customers') }}
),

final as (
    select
        customer_id,
        full_name,
        first_name,
        last_name,
        email,
        phone,
        city,
        state,
        zip_code
    from customers
)

select * from final
