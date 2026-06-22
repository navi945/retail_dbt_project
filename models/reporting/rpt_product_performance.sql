{{ config(materialized='table') }}

select

    dp.product_id,
    dp.product_name,
    dp.category,

    sum(fs.quantity) as total_quantity_sold,
    sum(fs.sales_amount) as total_sales

from {{ ref('fact_sales') }} fs

join {{ ref('dim_products') }} dp
    on fs.product_sk = dp.product_sk

group by 1,2,3