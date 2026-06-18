{{ config(
    materialized='incremental',
    unique_key='sales_sk'
) }}

select

    {{ dbt_utils.generate_surrogate_key(['oi.order_item_id']) }} as sales_sk,

    o.order_id,

    dc.customer_sk,

    dp.product_sk,

    o.customer_id,
    oi.product_id,

    o.order_date,

    oi.quantity,

    oi.unit_price,

    (oi.quantity * oi.unit_price) as sales_amount,

    o.order_status

from {{ ref('stg_order_items') }} oi

inner join {{ ref('stg_orders') }} o
    on oi.order_id = o.order_id

inner join {{ ref('dim_customers') }} dc
    on o.customer_id = dc.customer_id
    and dc.current_flag = 'Y'

inner join {{ ref('dim_products') }} dp
    on oi.product_id = dp.product_id
    and dp.current_flag = 'Y'

{% if is_incremental() %}

where o.order_date >
(
    select coalesce(max(order_date), '1900-01-01')
    from {{ this }}
)

{% endif %}