with organisations as (

    select * from `gc-prd-ext-data-test-prod-906c`.`gc_paysvc_live`.`organisations`

),

mandates as (

    select * from `gc-prd-ext-data-test-prod-906c`.`gc_paysvc_live`.`mandates`

)

select 

    organisations.parent_vertical,
    count(case when mandates.created_at < '2018-12-01' then mandates.id end) as count_mandates_pre_campaign,
    count(case when mandates.created_at >= '2018-12-01' then mandates.id end) as count_mandates_post_campaign

from mandates

left join organisations
        on mandates.organisation_id = organisations.id

where cast(mandates.created_at as date) >= '2018-12-01' - 14
    and cast(mandates.created_at as date) < '2018-12-01' + 14

group by 1

order by 1