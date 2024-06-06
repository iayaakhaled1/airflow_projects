-- tests/my_model_test.sql

{% macro time_difference_test() %}
  {{ config(
    materialized='view',
    unique_key='test_id',
    test_label='Time difference test',
  ) }}

  SELECT
    'time_difference_test' AS test_id,
    CASE
      WHEN TIMESTAMP_DIFF(FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', current_timestamp()), updated_at_utc, MINUTE) < 2 
      THEN Null
      ELSE 'Difference between updated_at and current timestamp is greater than 2 minutes'
    END AS error_message
  FROM
    {{ ref('raw_users') }}
{% endmacro %}

{{ time_difference_test() }}
