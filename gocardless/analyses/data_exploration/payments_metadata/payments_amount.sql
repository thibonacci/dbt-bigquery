with payments as (

    select * from {{ source('gc_paysvc_live', 'payments') }}

)

select 

    currency,
    min(amount) over() as min_amount,
    max(amount) over() as max_amount,
    percentile_cont(amount, 0.5) over() as median

from payments
