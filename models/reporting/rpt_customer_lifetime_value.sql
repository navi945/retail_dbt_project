
{{ config(materialized='table') }}

select

    dc.customer_id,
    dc.customer_name,fs.product_id,

    sum(fs.sales_amount) as lifetime_value

from {{ ref('fact_sales') }} fs

join {{ ref('dim_customers') }} dc
    on fs.customer_sk = dc.customer_sk and fs.current_flag='Y'

group by 1,2,3