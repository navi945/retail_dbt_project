{{ config(materialized='view') }}

select
    ORDER_ID,
    CUSTOMER_ID,
    ORDER_DATE,
    ORDER_STATUS
from {{ source('raw', 'ORDERS') }}