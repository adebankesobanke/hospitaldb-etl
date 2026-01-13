DROP MATERIALIZED VIEW IF EXISTS analytics.mv_patient_visits;

CREATE MATERIALIZED VIEW analytics.mv_patient_visits AS
SELECT
    v.visit_id,
    v.patient_id,
    v.visit_date,
    v.visit_type,
    v.branch_id
FROM analytics.visits v;

CREATE INDEX idx_mv_patient_visits_patient
ON analytics.mv_patient_visits(patient_id);