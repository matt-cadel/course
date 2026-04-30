{{
  config(
    materialized = 'incremental',
    on_schema_change='fail',
    partition_by={
      "field": "comment_timestamp",
      "data_type": "date",
      "granularity": "day"
    },
    cluster_by=['member_nickname', 'comment_id']
    )
}}

WITH silver_airport_comments AS (
    SELECT
        *
    FROM
        {{ ref('src_airport_comments') }}
)
SELECT
    comment_id,
    airport_ident,
    comment_timestamp,
    CASE WHEN member_nickname IS NULL THEN '__ANONYMOUS__' ELSE member_nickname END member_nickname,
    comment_subject,
    comment_body,
    current_timestamp() AS loaded_at
FROM
    silver_airport_comments
WHERE comment_body IS NOT NULL
{% if is_incremental() %}
  {% if var("start_date", False) and var("end_date", False) %}
    {{ log('Loading ' ~ this ~ ' incrementally (start_date: ' ~ var("start_date") ~ ', end_date: ' ~ var("end_date") ~ ')', info=True) }}
    AND comment_timestamp >= '{{ var("start_date") }}'
    AND comment_timestamp < '{{ var("end_date") }}'
  {% else %}
    AND comment_timestamp > (select max(comment_timestamp) from {{ this }})
    {{ log('Loading ' ~ this ~ ' incrementally (all missing dates)', info=True)}}
  {% endif %}
{% endif %}