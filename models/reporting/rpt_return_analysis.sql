{{ config(materialized='table') }}

select

    return_reason,

    count(*) as total_returns

from {{ ref('fact_returns') }}

group by return_reason