with organisations as (

    select * from {{ source('gc_paysvc_live', 'organisations') }}

),

mandates as (

    select * from {{ source('gc_paysvc_live', 'mandates') }}

),

payments as (

    select * from {{ source('gc_paysvc_live', 'payments') }}

),

joined as (

    select 

        mandates.id,
        organisations.parent_vertical,
        max(payments.id) as payment_id

    from mandates

    left join payments
        on mandates.id = payments.mandate_id

    left join organisations
        on mandates.organisation_id = organisations.id

    {{ dbt_utils.group_by(n=2) }}

),

activated as (

    select 

        id, 
        parent_vertical,
        payment_id is not null as is_activated

    from joined

),

final as (

    select 

        parent_vertical,
        count(id) as count_mandates,
        1.0 * count(case when is_activated then id end) / count(id) as activation_rate

    from activated

    group by 1

    order by 3 desc

)

select * from final
