with payments as (

    select * from {{ source('gc_paysvc_live', 'payments') }}

),

windowing as (

    select 

        currency,
        min(amount) over(partition by currency) as min_amount,
        max(amount) over(partition by currency) as max_amount,
        percentile_cont(amount, 0.5) over(partition by currency) as median

    from payments

)

select
    *

from windowing 

group by 1,2,3,4
