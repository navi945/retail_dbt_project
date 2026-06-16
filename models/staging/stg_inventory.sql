{{ config(materialized='view') }}
select
    PRODUCT_ID,
    STOCK_QTY,
    WAREHOUSE,
    LAST_UPDATED
from {{ source('raw', 'INVENTORY') }}
