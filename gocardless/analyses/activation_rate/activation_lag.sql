with mandates as (

    select * from {{ source('gc_paysvc_live', 'mandates') }}

),

payments as (

    select * from {{ source('gc_paysvc_live', 'payments') }}

),

joined as (

    select 

        mandates.id,
        mandates.created_at,
        min(payments.created_at) as payment_created_at

    from mandates

    left join payments
        on mandates.id = payments.mandate_id

    {{ dbt_utils.group_by(n=2) }}

),

payments_lag as (

    select 

        id, 
        date_diff(payment_created_at, created_at, day) as laggie

    from joined

),

final as (

    select 

        min(laggie) as min_lag,
        max(laggie) as max_lag

    from payments_lag

)

select * from final
