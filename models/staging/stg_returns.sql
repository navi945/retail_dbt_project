{{ config(materialized='view') }}

select
    RETURN_ID,
    ORDER_ID,
    RETURN_DATE,
    RETURN_REASON
from {{ source('raw', 'RETURNS') }}