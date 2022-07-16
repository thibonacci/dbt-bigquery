with mandates as (

    select * from {{ source('gc_paysvc_live', 'mandates') }}

)

select 

    scheme,
    count(*) as count_mandates,
    min(created_at) as min_created_at,
    max(created_at) as max_created_at

from mandates

group by 1
