CREATE TABLE IF NOT EXISTS staging.visits AS
SELECT
    visit_id,
    patient_id,
    visit_date,
    reason,
    branch_id
FROM raw.visits_raw;
