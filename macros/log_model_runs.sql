{% macro log_model_runs(results) %}

{% for result in results %}

    {% if result.node.resource_type == 'model' %}

        {% set model_name = result.node.name %}
        {% set schema_name = result.node.schema %}

        {% if 'stg_' in model_name %}
            {% set layer = 'STAGING' %}
        {% elif 'int_' in model_name %}
            {% set layer = 'INTERMEDIATE' %}
        {% elif 'dim_' in model_name or 'fact_' in model_name %}
            {% set layer = 'MARTS' %}
        {% else %}
            {% set layer = 'OTHER' %}
        {% endif %}

        {% set sql %}
        insert into RETAIL_DWH.AUDIT.DBT_MODEL_RUN_LOG
        (
            MODEL_NAME,
            MODEL_TYPE,
            LAYER,
            STATUS,
            RUN_DATE,
            DATABASE_NAME,
            SCHEMA_NAME
        )
        values
        (
            '{{ model_name }}',
            '{{ result.node.resource_type }}',
            '{{ layer }}',
            '{{ result.status }}',
            current_timestamp(),
            '{{ result.node.database }}',
            '{{ schema_name }}'
        )
        {% endset %}

        {% do run_query(sql) %}

    {% endif %}

{% endfor %}

{% endmacro %}