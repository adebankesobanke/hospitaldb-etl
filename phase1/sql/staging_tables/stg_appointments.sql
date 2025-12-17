CREATE TABLE IF NOT EXISTS stg_appointments AS
SELECT
    appointment_id,
    patient_id,
    doctor_id,
    appointment_date,
    INITCAP(reason) AS reason,
    UPPER(status) AS status,
    created_at
FROM raw_appointments;
