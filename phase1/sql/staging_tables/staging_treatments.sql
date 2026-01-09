CREATE SCHEMA IF NOT EXISTS staging;

DROP TABLE IF EXISTS staging.treatments;

CREATE TABLE staging.treatments AS
SELECT
    treatment_id,
    visit_id,
    treatment_name,
    cost,
    created_at
FROM raw.raw_treatments
WHERE treatment_id IS NOT NULL;
