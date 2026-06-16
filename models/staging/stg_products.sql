{{ config(materialized='view') }}

{{ config(materialized='view') }}

with products_dedup as (

    select
        PRODUCT_ID,
        PRODUCT_NAME,
        CATEGORY,
        COST_PRICE,
        SELLING_PRICE,

        row_number() over (
            partition by PRODUCT_ID
            order by PRODUCT_ID
        ) as rn

    from {{ source('raw', 'PRODUCTS') }}

)

select
    PRODUCT_ID,
    PRODUCT_NAME,
    CATEGORY,
    COST_PRICE,
    SELLING_PRICE

from products_dedup
where rn = 1