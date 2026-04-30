WITH la_heliport_closed AS (
    SELECT * FROM {{ ref('scd_silver_airports') }}
)
SELECT
    *
FROM
    la_heliport_closed
WHERE airport_ident = '01CN'