
    
    

with child as (
    select organisation_id as from_field
    from `gc-prd-ext-data-test-prod-906c`.`gc_paysvc_live`.`mandates`
    where organisation_id is not null
),

parent as (
    select id as to_field
    from `gc-prd-ext-data-test-prod-906c`.`gc_paysvc_live`.`organisations`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


