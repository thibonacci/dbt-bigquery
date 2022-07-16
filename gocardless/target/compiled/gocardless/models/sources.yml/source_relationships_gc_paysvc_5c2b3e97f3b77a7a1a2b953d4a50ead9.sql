
    
    

with child as (
    select mandate_id as from_field
    from `gc-prd-ext-data-test-prod-906c`.`gc_paysvc_live`.`payments`
    where mandate_id is not null
),

parent as (
    select id as to_field
    from `gc-prd-ext-data-test-prod-906c`.`gc_paysvc_live`.`mandates`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


