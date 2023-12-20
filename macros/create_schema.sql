{% macro trino__create_schema(relation) -%}
{%- call statement('create_schema') -%}
    CREATE SCHEMA {{ relation.schema }} WITH (location='s3://lakehouse/')
{% endcall %}
{% endmacro %}