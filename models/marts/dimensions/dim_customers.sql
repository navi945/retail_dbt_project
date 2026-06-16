{{ config(materialized='table') }}

select

    {{ dbt_utils.generate_surrogate_key(['customer_id']) }}
        as customer_sk,

    customer_id,
    customer_name,
    email,
    city,

    dbt_valid_from as effective_date,

    coalesce(
        dbt_valid_to,
        '9999-12-31'
    ) as expiry_date,

    case
        when dbt_valid_to is null
        then 'Y'
        else 'N'
    end as current_flag

from {{ ref('customer_snapshot') }}