
{{ config(materialized='table') }}

select

    p.product_id,
    p.product_name,
    p.category,

    i.STOCK_QTY,
    i.last_updated

from {{ ref('stg_products') }} p
left join {{ ref('stg_inventory') }} i
    on p.product_id = i.product_id

