with mandates as (

    select * from `gc-prd-ext-data-test-prod-906c`.`gc_paysvc_live`.`mandates`

)

select 

    count(case when created_at < '2018-12-01' then id end) as count_mandates_pre_campaign,
    count(case when created_at >= '2018-12-01' then id end) as count_mandates_post_campaign

from mandates

where cast(created_at as date) >= '2018-12-01' - 14
    and cast(created_at as date) < '2018-12-01' + 14