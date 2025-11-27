{{ config(
    materialized='table'
) }}

WITH source AS (
    SELECT
        ID AS order_id,
        USER_ID AS user_id,
        ORDER_DATE AS order_date,
        STATUS AS status,
        _ETL_LOADED_AT AS etl_loaded_at
    FROM {{ source('steve_raw', 'orders') }}
),

cleaned AS (
    SELECT
        order_id,
        user_id,
        CAST(order_date AS DATE) AS order_date,
        LOWER(status) AS status,
        etl_loaded_at
    FROM source
)

SELECT * FROM cleaned
