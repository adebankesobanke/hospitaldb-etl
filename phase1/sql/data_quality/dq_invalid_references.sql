-- PURPOSE: Detect foreign key violations (orphan records)
-- These issues break data integrity and must be resolved before loading into staging.

-- Visits referencing non-existing patients
SELECT v.visit_id, v.patient_id
FROM raw_visits v
LEFT JOIN raw_patients p ON v.patient_id = p.patient_id
WHERE p.patient_id IS NULL;

-- Visits referencing non-existing doctors
SELECT v.visit_id, v.doctor_id
FROM raw_visits v
LEFT JOIN raw_doctors d ON v.doctor_id = d.doctor_id
WHERE d.doctor_id IS NULL;

-- Treatments referencing non-existing visits
SELECT t.treatment_id, t.visit_id
FROM raw_treatments t
LEFT JOIN raw_visits v ON t.visit_id = v.visit_id
WHERE v.visit_id IS NULL;

-- Billing referencing non-existing appointments or visits
SELECT b.bill_id, b.appointment_id
FROM raw_billing b
LEFT JOIN raw_appointments a ON b.appointment_id = a.appointment_id
WHERE b.appointment_id IS NOT NULL
  AND a.appointment_id IS NULL;
