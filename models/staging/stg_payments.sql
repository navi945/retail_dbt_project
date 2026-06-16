{{ config(materialized='view') }}

select
    PAYMENT_ID,
    ORDER_ID,
    PAYMENT_AMOUNT,
  
    PAYMENT_METHOD
from {{ source('raw', 'PAYMENTS') }}
