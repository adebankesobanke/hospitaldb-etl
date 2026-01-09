CREATE SCHEMA IF NOT EXISTS staging;

DROP TABLE IF EXISTS staging.visits;

CREATE TABLE staging.visits AS
SELECT
    visit_id,
    patient_id,
    visit_date,
    visit_type,
    branch_id,
    CURRENT_TIMESTAMP AS created_at
FROM raw.visits_raw
WHERE visit_id IS NOT NULL
  AND visit_date IS NOT NULL;
