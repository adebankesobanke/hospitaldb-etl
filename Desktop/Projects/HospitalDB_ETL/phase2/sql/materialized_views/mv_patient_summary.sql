-- Materialized View: Patient Summary

DROP MATERIALIZED VIEW IF EXISTS mv_patient_summary;
CREATE MATERIALIZED VIEW mv_patient_summary AS
WITH visit_stats AS (
    SELECT 
        patient_id,
        COUNT(*) AS total_visits,
        MIN(visit_date) AS first_visit_date,
        MAX(visit_date) AS last_visit_date
    FROM staging_visits
    GROUP BY patient_id
),
billing_stats AS (
    SELECT
        patient_id,
        SUM(amount) AS total_billed,
        SUM(CASE WHEN status = 'PAID' THEN amount ELSE 0 END) AS total_paid,
        SUM(CASE WHEN status != 'PAID' THEN amount ELSE 0 END) AS total_unpaid
    FROM staging_billing
    GROUP BY patient_id
)
SELECT 
    p.patient_id,
    p.first_name,
    p.last_name,
    p.gender,
    p.date_of_birth,
    p.contact_number,
    COALESCE(v.total_visits, 0) AS total_visits,
    v.first_visit_date,
    v.last_visit_date,
    COALESCE(b.total_billed, 0) AS total_billed,
    COALESCE(b.total_paid, 0) AS total_paid,
    COALESCE(b.total_unpaid, 0) AS total_unpaid,
    CURRENT_TIMESTAMP AS refreshed_at
FROM staging_patients p
LEFT JOIN visit_stats v ON p.patient_id = v.patient_id
LEFT JOIN billing_stats b ON p.patient_id = b.patient_id;
