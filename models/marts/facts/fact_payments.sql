{{ config(
    materialized='incremental',
    unique_key='payment_sk',
    incremental_strategy='merge'
) }}

select

    {{ dbt_utils.generate_surrogate_key(['p.payment_id']) }}
        as payment_sk,

    p.payment_id,

    p.order_id,

    dc.customer_sk,

    p.payment_amount,

    p.payment_method

from {{ ref('stg_payments') }} p

inner join {{ ref('stg_orders') }} o
    on p.order_id = o.order_id

inner join {{ ref('dim_customers') }} dc
    on o.customer_id = dc.customer_id
    and dc.current_flag = 'Y'

{% if is_incremental() %}

where p.payment_id >
(
    select coalesce(max(payment_id),0)
    from {{ this }}
)

{% endif %}