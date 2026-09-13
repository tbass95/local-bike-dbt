with staffs as (
    select * from {{ ref('stg_staffs') }}
),
stores as (
    select * from {{ ref('stg_stores') }}
),

final as (
    select
        s.staff_id,
        s.full_name,
        s.first_name,
        s.last_name,
        s.email,
        s.phone,
        s.active,
        s.manager_id,
        s.store_id,
        st.store_name,
        st.city as store_city,
        st.state as store_state
    from staffs s
    left join stores st on s.store_id = st.store_id
)

select * from final
