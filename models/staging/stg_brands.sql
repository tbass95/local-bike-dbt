with source as (
    select * from {{ source('raw_data', 'brands') }}
),

renamed as (
    select
        cast(brand_id as int64) as brand_id,
        trim(brand_name) as brand_name
    from source
)

select * from renamed
