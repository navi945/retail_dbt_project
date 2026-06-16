{{ config(materialized='table') }}

select

    r.return_id,
    r.order_id,
    r.return_reason,
    r.return_date,

    o.customer_id

from {{ ref('stg_returns') }} r
join {{ ref('stg_orders') }} o
    on r.order_id = o.order_id