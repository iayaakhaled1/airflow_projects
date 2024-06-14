SELECT
    ID AS user_id,
    FIRST_NAME AS name,
    FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', CURRENT_TIMESTAMP()) AS updated_at_utc
FROM
    {{ source('jaffle_shop', 'customers') }}