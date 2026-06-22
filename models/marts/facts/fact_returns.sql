{{ config(
    materialized='incremental',
    unique_key='return_sk',
    incremental_strategy='merge'
) }}

select

    {{ dbt_utils.generate_surrogate_key(['r.return_id']) }}
        as return_sk,

    r.return_id,

    r.order_id,

    dc.customer_sk,

    r.return_date,

    r.return_reason,

    o.order_status

from {{ ref('stg_returns') }} r

inner join {{ ref('stg_orders') }} o
    on r.order_id = o.order_id

inner join {{ ref('dim_customers') }} dc
    on o.customer_id = dc.customer_id
    and dc.current_flag = 'Y'

{% if is_incremental() %}

where r.return_date >
(
    select coalesce(max(return_date),'1900-01-01')
    from {{ this }}
)

{% endif %}