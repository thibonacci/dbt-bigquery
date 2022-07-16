with payments as (

    select * from `gc-prd-ext-data-test-prod-906c`.`gc_paysvc_live`.`payments`

)

select 

    count(*) as count_payments,
    min(created_at) as min_created_at,
    max(created_at) as max_created_at

from payments