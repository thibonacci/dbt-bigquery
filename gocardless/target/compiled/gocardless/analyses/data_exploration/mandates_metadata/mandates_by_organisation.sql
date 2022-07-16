with mandates as (

    select * from `gc-prd-ext-data-test-prod-906c`.`gc_paysvc_live`.`mandates`

)

select 

    organisation_id,
    count(*) as count_mandates,
    min(created_at) as min_created_at,
    max(created_at) as max_created_at

from mandates

group by 1

order by 2 desc

limit 10