-- Materialized View: Visit Summary
DROP MATERIALIZED VIEW IF EXISTS mv_visit_summary;
CREATE MATERIALIZED VIEW mv_visit_summary AS
SELECT 
    v.visit_id,
    v.patient_id,
    p.first_name,
    p.last_name,
    p.gender,
    v.visit_date,
    v.doctor_assigned,
    v.reason_for_visit,
    COALESCE(b.total_billed, 0) AS total_billed_for_visit,
    COALESCE(b.total_paid, 0) AS total_paid_for_visit,
    (COALESCE(b.total_billed, 0) - COALESCE(b.total_paid, 0)) AS outstanding_for_visit,
    CURRENT_TIMESTAMP AS refreshed_at
FROM staging_visits v
LEFT JOIN staging_patients p 
    ON v.patient_id = p.patient_id
LEFT JOIN (
    SELECT 
        visit_id,
        SUM(amount) AS total_billed,
        SUM(CASE WHEN status = 'PAID' THEN amount ELSE 0 END) AS total_paid
    FROM staging_billing
    GROUP BY visit_id
) b
    ON v.visit_id = b.visit_id;

