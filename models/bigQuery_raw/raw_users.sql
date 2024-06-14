{{ config(
    materialized='incremental'
) }}

-- Append new data to the existing table
SELECT
    ID AS user_id,
    FIRST_NAME AS name,
    FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', CURRENT_TIMESTAMP()) AS updated_at_utc
FROM
    {{ source('jaffle_shop', 'customers') }}

{% if is_incremental() %}
-- This filter will only be applied on an incremental run
WHERE
    updated_at_utc > (SELECT MAX(updated_at_utc) FROM {{ this }})
{% endif %}
