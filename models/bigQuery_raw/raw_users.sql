{{ config(
    materialized='table')
}}
  
SELECT ID as user_id , 
       FIRST_NAME as name , 
      FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', current_timestamp()) as updated_at_utc
 FROM {{ source('jaffle_shop', 'customers') }}