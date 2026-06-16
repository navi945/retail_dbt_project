{{ config(materialized='table') }}
select

    c.customer_id,
    c.customer_name,

    o.order_id,
    o.order_date,
    o.order_status

from {{ ref('stg_customers') }} c
join {{ ref('stg_orders') }} o
    on c.customer_id = o.customer_id