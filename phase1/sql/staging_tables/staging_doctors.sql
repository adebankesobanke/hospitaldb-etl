CREATE SCHEMA IF NOT EXISTS staging;

DROP TABLE IF EXISTS staging.doctors;

CREATE TABLE staging.doctors AS
SELECT DISTINCT
    doctor_id,
    first_name,
    last_name,
    specialization,
    branch_id,
    CURRENT_TIMESTAMP AS created_at
FROM raw.raw_doctors
WHERE doctor_id IS NOT NULL;
