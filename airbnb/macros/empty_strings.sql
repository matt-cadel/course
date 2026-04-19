{% macro empty_strings(model) %}
    {%- for col in adapter.get_columns_in_relation(model) -%}
        {%- if col.is_string() %}
            {{ col.name }} IS NULL OR {{ col.name }} = '' AND
        {%- endif %}
    {%- endfor %}
    TRUE
{% endmacro %}
