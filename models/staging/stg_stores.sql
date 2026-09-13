with source as (
    select * from {{ source('raw_data', 'stores') }}
),

renamed as (
    select
        cast(store_id as int64) as store_id,
        trim(cast(store_name as string)) as store_name,
        cast(phone as string) as phone,
        lower(trim(cast(email as string))) as email,
        trim(cast(street as string)) as street,
        trim(cast(city as string)) as city,
        trim(cast(state as string)) as state,
        cast(zip_code as string) as zip_code
    from source
)

select * from renamed
