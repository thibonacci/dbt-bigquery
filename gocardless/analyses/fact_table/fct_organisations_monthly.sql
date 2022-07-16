{{
  config(
    materialized = "table",
    cluster_by = ["month_id", "organisation_id"],
  )
}}

with organisations as (

    select * from {{ source('gc_paysvc_live', 'organisations') }}

),

mandates as (

    select * from {{ source('gc_paysvc_live', 'mandates') }}

),

payments as (

    select * from {{ source('gc_paysvc_live', 'payments') }}

),

payments_converted as (

    select 

        payments.id,
        case 
            when currency = 'GBP'
            then amount
            else amount / 1.2
        end as amount_gbp,
        payments.created_at,
        payments.source,
        payments.charge_date,
        payments.mandate_id
 
    from payments

),

months as (

    {{ dbt_utils.date_spine(
        datepart="month",
        start_date="cast('2018-03-01' as date)",
        end_date="cast('2019-04-01' as date)"
    )
    }}

),

month_organisation as (

    select 

        months.date_month as month_id,
        organisations.id as organisation_id,
        organisations.created_at as organisation_created_at,
        organisations.parent_vertical

    from months

    cross join organisations

    where 1 = 1


),

joined as (

    select

        month_organisation.*,
        coalesce(count(distinct mandates.id), 0) as count_mandates_created,
        coalesce(sum(case when mandates.scheme = 'bacs' then payments_converted.amount_gbp end), 0) as bacs_amount_gbp,
        coalesce(sum(case when mandates.scheme = 'sepa_core' then payments_converted.amount_gbp end), 0) as sepa_amount_gbp,
        coalesce(sum(case when payments_converted.source = 'dashboard' then payments_converted.amount_gbp end), 0) as dashboard_amount_gbp,
        coalesce(sum(case when payments_converted.source = 'app' then payments_converted.amount_gbp end), 0) as app_amount_gbp,
        coalesce(sum(case when payments_converted.source = 'api' then payments_converted.amount_gbp end), 0) as api_amount_gbp

    from month_organisation

    left join mandates
        on month_organisation.organisation_id = mandates.organisation_id
        and month_organisation.month_id = cast(date_trunc(mandates.created_at, month) as date)

    left join payments_converted
        on mandates.id = payments_converted.mandate_id
        and month_organisation.month_id = date_trunc(payments_converted.charge_date, month)

    group by 1,2,3,4
    
    order by 1,2

)

select * from joined
