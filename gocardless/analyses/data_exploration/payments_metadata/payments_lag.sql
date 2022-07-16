with payments as (

    select * from {{ source('gc_paysvc_live', 'payments') }}

),

payments_lag as (

    select

        id,
        date_diff(charge_date, cast(created_at as date), day) as laggie

    from payments

)

select 

    min(laggie) as min_lag,
    max(laggie) as max_lag

from payments_lag

