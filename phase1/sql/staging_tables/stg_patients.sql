CREATE TABLE IF NOT EXISTS staging.patients AS
SELECT DISTINCT
    patient_id,
    INITCAP(first_name) AS first_name,
    INITCAP(last_name) AS last_name,
    gender,
    dob,
    branch_id
FROM raw.patients_raw;

