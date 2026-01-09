CREATE TABLE staging.appointments AS
SELECT
    appointment_id,
    patient_id,
    doctor_id,
    appointment_date,
    branch_id,
    CURRENT_TIMESTAMP AS created_at
FROM raw.raw_appointments
WHERE appointment_id IS NOT NULL
  AND appointment_date IS NOT NULL;