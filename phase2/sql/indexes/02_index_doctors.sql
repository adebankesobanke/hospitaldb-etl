-- ==========================================
-- Indexes for doctors table
-- ==========================================

CREATE INDEX IF NOT EXISTS idx_doctors_doctor_id
    ON dim_doctors (doctor_id);

CREATE INDEX IF NOT EXISTS idx_doctors_specialty
    ON dim_doctors (specialty);
