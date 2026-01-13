DROP MATERIALIZED VIEW IF EXISTS analytics.mv_billing_summary;

CREATE MATERIALIZED VIEW analytics.mv_billing_summary AS
SELECT
    b.billing_id,
    b.visit_id,
    b.patient_id,
    b.amount
FROM analytics.billing b;

CREATE INDEX idx_mv_billing_summary_patient
ON analytics.mv_billing_summary(patient_id);

CREATE INDEX idx_mv_billing_summary_visit
ON analytics.mv_billing_summary(visit_id);