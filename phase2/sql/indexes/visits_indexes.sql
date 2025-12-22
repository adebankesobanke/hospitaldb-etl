CREATE INDEX IF NOT EXISTS idx_stg_visits_id
ON stg_visits (visit_id);

CREATE INDEX IF NOT EXISTS idx_stg_visits_date
ON stg_visits (visit_date);

CREATE INDEX IF NOT EXISTS idx_stg_visits_patient
ON stg_visits (patient_id);
