with payments as (

    select * from {{ source('gc_paysvc_live', 'payments') }}

)

select 

    count(*) as count_payments,
    min(created_at) as min_created_at,
    max(created_at) as max_created_at

from payments
