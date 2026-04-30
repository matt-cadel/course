{{
  config(
    materialized = 'ephemeral'
    )
}} 

WITH raw_airport_comments AS (
    SELECT
        *
    FROM
       {{ source('airstats', 'airport_comments') }}
)

SELECT 
    id AS comment_id,
    airport_ident,
    date AS comment_timestamp,
    member_nickname,
    subject AS comment_subject,
    body AS comment_body
FROM raw_airport_comments



-- insert into AIRSTATS.RAW.AIRPORT_COMMENTS 
-- select 
-- 999 ID,
-- 999 THREAD_REF,
-- 602304 AIRPORT_REF,
-- 'RU-10136' AIRPORT_IDENT,
-- current_timestamp() DATE,
-- 'mattcadel' MEMBER_NICKNAME,
-- 'Test' SUBJECT,
-- 'This is a test' BODY,
-- current_timestamp() LOADED_AT
