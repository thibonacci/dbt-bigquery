with payments as (

    select * from `gc-prd-ext-data-test-prod-906c`.`gc_paysvc_live`.`payments`

)

select 

    min(amount) over() as min_amount,
    max(amount) over() as max_amount,
    percentile_cont(amount, 0.5) over() as median

from payments