
    
    

with dbt_test__target as (

  select id as unique_field
  from `gc-prd-ext-data-test-prod-906c`.`gc_paysvc_live`.`organisations`
  where id is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


