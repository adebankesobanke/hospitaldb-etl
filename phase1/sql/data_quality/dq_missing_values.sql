-- PURPOSE: Identify missing critical fields across core tables.
-- NOTE: These checks help ensure completeness of required business fields.

-- Missing patient demographic information
SELECT patient_id, full_name, date_of_birth, gender
FROM raw_patients
WHERE full_name IS NULL 
   OR date_of_birth IS NULL
   OR gender IS NULL;

-- Missing doctor specialization
SELECT doctor_id, full_name, specialization
FROM raw_doctors
WHERE specialization IS NULL;

-- Missing visit essential fields
SELECT visit_id, patient_id, doctor_id, visit_date
FROM raw_visits
WHERE patient_id IS NULL
   OR doctor_id IS NULL
   OR visit_date IS NULL;

