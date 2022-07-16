with organisations as (

    select * from `gc-prd-ext-data-test-prod-906c`.`gc_paysvc_live`.`organisations`

)

select 

    count(*) as count_organisations,
    min(created_at) as min_created_at,
    max(created_at) as max_created_at

from organisations