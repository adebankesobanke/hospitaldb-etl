DROP TABLE IF EXISTS staging.patients;

CREATE TABLE staging.patients AS
SELECT
    patient_id,
    first_name,
    last_name,
    gender,
    date_of_birth,
    phone,
    email,
    address,
    branch_id,
    created_at
FROM raw.patients_raw
WHERE patient_id IS NOT NULL;

