-- Incremental load for mv_billing_summary
WITH last_processed AS (
    SELECT COALESCE(MAX(last_processed_id), 0) AS last_id
    FROM analytics.incremental_load_audit
    WHERE table_name = 'mv_billing_summary'
)
INSERT INTO analytics.mv_billing_summary (billing_id, patient_id, visit_id, amount)
SELECT b.billing_id, b.patient_id, b.visit_id, b.amount
FROM analytics.billing b
JOIN last_processed lp ON b.billing_id > lp.last_id;

-- Update audit table
INSERT INTO analytics.incremental_load_audit (table_name, last_processed_id)
SELECT 'mv_billing_summary', MAX(billing_id)
FROM analytics.mv_billing_summary;
