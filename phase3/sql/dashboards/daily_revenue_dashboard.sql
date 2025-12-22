CREATE OR REPLACE VIEW daily_revenue_dashboard AS
SELECT
    v.visit_date,
    SUM(b.amount) AS total_revenue,
    COUNT(DISTINCT v.patient_id) AS unique_patients
FROM stg_visits v
JOIN stg_billing b
    ON v.visit_id = b.visit_id
GROUP BY v.visit_date
ORDER BY v.visit_date;
