CREATE TABLE IF NOT EXISTS branch_summary AS
SELECT
    v.branch_id,
    COUNT(DISTINCT v.patient_id) AS total_patients,
    COUNT(v.visit_id) AS total_visits,
    SUM(b.amount) AS total_revenue,
    AVG(b.amount) AS avg_billing_per_visit
FROM stg_visits v
JOIN stg_billing b
    ON v.visit_id = b.visit_id
GROUP BY v.branch_id
ORDER BY total_revenue DESC;
