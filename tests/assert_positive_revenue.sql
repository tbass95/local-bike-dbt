select *
from {{ ref('fact_sales') }}
where net_revenue < 0
