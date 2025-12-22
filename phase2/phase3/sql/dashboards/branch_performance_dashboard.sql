CREATE OR REPLACE VIEW branch_performance_dashboard AS
SELECT
    v.branch_id,
    COUNT(DISTINCT v.patient_id) AS total_patients,
    COUNT(v.visit_id) AS total_visits,
    SUM(b.amount) AS total_revenue
FROM stg_visits v
JOIN stg_billing b
    ON v.visit_id = b.visit_id
GROUP BY v.branch_id
ORDER BY total_revenue DESC;
