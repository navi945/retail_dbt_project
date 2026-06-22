{{ config(materialized='view') }}

SELECT
    PRODUCT_ID,
    STOCK_QTY,
    WAREHOUSE,
    LAST_UPDATED
FROM {{ source('raw', 'INVENTORY') }} AS inventory