WITH silver_airports AS (
    SELECT
        *
    FROM
        {{ ref('src_airports') }}
)
SELECT
    *
FROM
    silver_airports
