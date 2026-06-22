{{ config(materialized='table') }}

select
    order_date,order_id,
    count(distinct order_id) as total_orders,
    sum(quantity) as total_quantity,
    sum(sales_amount) as total_sales
from {{ ref('fact_sales') }}
group by order_date,
order_id