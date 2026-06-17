{{ config(materialized='table') }}

select

    dbt_scd_id as product_sk,

    product_id,
    product_name,
    category,
    cost_price,
    selling_price,

    dbt_valid_from as effective_date,

    coalesce(
        dbt_valid_to,
        '9999-12-31'
    ) as expiry_date,

    case
        when dbt_valid_to is null then 'Y'
        else 'N'
    end as current_flag

from {{ ref('product_snapshot') }}