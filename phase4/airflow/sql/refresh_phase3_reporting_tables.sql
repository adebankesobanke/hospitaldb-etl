-- Placeholder for Phase 3 reporting tables
-- Replace with actual ETL SQL

TRUNCATE TABLE reporting_tables.patient_summary;
INSERT INTO reporting_tables.patient_summary
SELECT * FROM phase3_raw.patient_data LIMIT 10;  -- demo placeholder

