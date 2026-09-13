with source as (
    select * from {{ source('raw_data', 'staffs') }}
),

renamed as (
    select
        cast(staff_id as int64) as staff_id,
        trim(cast(first_name as string)) as first_name,
        trim(cast(last_name as string)) as last_name,
        concat(trim(cast(first_name as string)), ' ', trim(cast(last_name as string))) as full_name,
        lower(trim(cast(email as string))) as email,
        cast(phone as string) as phone,
        cast(active as int64) as active,
        cast(store_id as int64) as store_id,
        safe_cast(manager_id as int64) as manager_id
    from source
)

select * from renamed
