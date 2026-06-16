{{ config(materialized='view') }}



with customer_deedup as (

    select *
    from (

        select
            CUSTOMER_ID,
            trim(CUSTOMER_NAME) as customer_name,
            lower(EMAIL) as email,
            city,
            signup_date,

            row_number() over (
                partition by CUSTOMER_ID
                order by SIGNUP_DATE desc
            ) as rn

        from {{ source('raw','CUSTOMERS') }}

    )

    where rn = 1

)

select
    customer_id,

    coalesce(customer_name,'UNKNOWN') as customer_name,

    coalesce(email,'NA') as email,

    coalesce(city,'UNKNOWN') as city,

    signup_date

from customer_deedup