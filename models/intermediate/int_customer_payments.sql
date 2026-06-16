{{ config(materialized='table') }}


select

    o.customer_id,

    p.payment_id,
    p.order_id,

    p.payment_method,
   
    p.payment_amount



from {{ ref('stg_payments') }} p
join {{ ref('stg_orders') }} o
    on p.order_id = o.order_id