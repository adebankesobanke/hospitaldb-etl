<<<<<<< HEAD
-- Index on Patient ID
-- ==========================================
-- Indexes for patients table
-- ==========================================

-- Speed up lookups by patient_id (PK already indexed, but adding for clarity)
CREATE INDEX IF NOT EXISTS idx_patients_patient_id
    ON dim_patients (patient_id);

-- Improve searches by gender
CREATE INDEX IF NOT EXISTS idx_patients_gender
    ON dim_patients (gender);

-- Improve searches by date of birth (useful for analytics)
CREATE INDEX IF NOT EXISTS idx_patients_dob
    ON dim_patients (date_of_birth);
=======
CREATE INDEX IF NOT EXISTS idx_stg_patients_id
ON stg_patients (patient_id);

CREATE INDEX IF NOT EXISTS idx_stg_patients_dob
ON stg_patients (date_of_birth);
>>>>>>> 6af9b5afdd4ce94ec461b6cc25b17afbd2b33376
