with payments as (

    select * from `gc-prd-ext-data-test-prod-906c`.`gc_paysvc_live`.`payments`

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