CREATE INDEX IF NOT EXISTS idx_stg_patients_id
ON stg_patients (patient_id);

CREATE INDEX IF NOT EXISTS idx_stg_patients_dob
ON stg_patients (date_of_birth);
