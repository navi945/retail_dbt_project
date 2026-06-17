{% snapshot product_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='product_id',
        strategy='check',
        check_cols=[
            'product_name',
            'category',
            'cost_price',
            'selling_price'
        ]
    )
}}

select
    product_id,
    product_name,
    category,
    cost_price,
    selling_price
from {{ ref('stg_products') }}

{% endsnapshot %}