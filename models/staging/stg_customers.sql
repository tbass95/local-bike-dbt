with source as (
    select * from {{ source('raw_data', 'customers') }}
),

renamed as (
    select
        cast(customer_id as int64) as customer_id,
        trim(cast(first_name as string)) as first_name,
        trim(cast(last_name as string)) as last_name,
        concat(trim(cast(first_name as string)), ' ', trim(cast(last_name as string))) as full_name,
        cast(phone as string) as phone,
        lower(trim(cast(email as string))) as email,
        trim(cast(street as string)) as street,
        trim(cast(city as string)) as city,
        trim(cast(state as string)) as state,
        cast(zip_code as string) as zip_code
    from source
)

select * from renamed
