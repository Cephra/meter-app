CREATE OR REPLACE VIEW v_value_stats
AS
WITH meter_start AS (
    SELECT
        t_value.meter_id,
        min(t_value.timestamp) AS meter_first_date
    FROM t_value
    GROUP BY t_value.meter_id
),

value_with_first_meter_date AS (
    SELECT
        v.id AS value_id,
        v.timestamp,
        v.value,
        v.value AS raw_value,
        v.meter_id,
        m.meter_type_id,
        ms.meter_first_date
    FROM t_value AS v
    INNER JOIN meter_start AS ms ON v.meter_id = ms.meter_id
    INNER JOIN t_meter AS m ON v.meter_id = m.id
    ORDER BY v.timestamp
),

adjusted_values AS (
    SELECT
        v.value_id,
        v.timestamp,
        v.value,
        v.raw_value,
        v.meter_id,
        v.meter_type_id,
        v.meter_first_date,
        CASE
            WHEN lag(v.value, 1) OVER (
                PARTITION BY v.meter_id
                ORDER BY v.timestamp, v.meter_first_date
            ) IS null THEN null
            ELSE v.value - lag(v.value, 1) OVER (
                PARTITION BY v.meter_id
                ORDER BY v.timestamp, v.meter_first_date
            )
        END AS meter_adjusted_value
    FROM value_with_first_meter_date AS v
    ORDER BY v.timestamp, v.meter_first_date
),

normalized_value AS (
    SELECT
        v.value_id AS id,
        v.timestamp,
        v.meter_id,
        v.meter_type_id,
        v.raw_value,
        sum(v.meter_adjusted_value)
            OVER (
                PARTITION BY v.meter_type_id
                ORDER BY
                    v.timestamp, v.meter_first_date
                ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            )
            AS value
    FROM adjusted_values AS v
    ORDER BY v.timestamp, v.meter_first_date
),

normalized_value_delta AS (
    SELECT
        nv.id,
        nv.timestamp,
        nv.meter_id,
        nv.meter_type_id,
        nv.raw_value,
        nv.value,
        extract(
            DAY FROM nv.timestamp - lag(nv.timestamp, 1, nv.timestamp) OVER (
                PARTITION BY nv.meter_type_id
                ORDER BY nv.timestamp
            )
        )::double precision AS date_diff,
        nv.value
        - lag(nv.value, 1) OVER (
            PARTITION BY nv.meter_type_id
            ORDER BY nv.timestamp
        ) AS delta
    FROM normalized_value AS nv
),

delta_year AS (
    SELECT
        nvd.id,
        nvd.timestamp,
        nvd.meter_id,
        nvd.meter_type_id,
        nvd.raw_value,
        nvd.value,
        nvd.date_diff,
        nvd.delta,
        CASE
            WHEN nvd.date_diff = 0::double precision THEN 0::double precision
            ELSE nvd.delta / nvd.date_diff * 365::double precision
        END AS delta_year
    FROM normalized_value_delta AS nvd
)

SELECT
    id,
    timestamp,
    meter_id,
    meter_type_id,
    raw_value,
    value,
    date_diff,
    delta,
    delta_year,
    avg(delta_year)
        OVER (
            PARTITION BY meter_type_id
            ORDER BY timestamp ROWS BETWEEN 3 PRECEDING AND CURRENT ROW
        )
        AS delta_last4_avg,
    avg(delta_year)
        OVER (
            PARTITION BY meter_type_id
            ORDER BY timestamp ROWS BETWEEN 51 PRECEDING AND CURRENT ROW
        )
        AS delta_year_avg
FROM delta_year;
