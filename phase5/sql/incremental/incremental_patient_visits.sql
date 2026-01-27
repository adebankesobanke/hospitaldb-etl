-- =====================================================
-- Incremental Load: patient visits (DELTA TABLE)
-- Phase 5 – Incremental ETL
-- =====================================================

INSERT INTO analytics.mv_patient_visits_delta (
    visit_id,
    patient_id,
    visit_date,
    visit_type,
    branch_id
)
SELECT
    v.visit_id,
    v.patient_id,
    v.visit_date,
    v.visit_type,
    v.branch_id
FROM analytics.visits v
LEFT JOIN analytics.mv_patient_visits_delta d
    ON v.visit_id = d.visit_id
WHERE d.visit_id IS NULL;

-- -----------------------------------------------------
-- Audit logging
-- -----------------------------------------------------

INSERT INTO analytics.incremental_load_audit (
    table_name,
    last_processed_id
)
SELECT
    'mv_patient_visits_delta',
    MAX(visit_id)
FROM analytics.mv_patient_visits_delta;
