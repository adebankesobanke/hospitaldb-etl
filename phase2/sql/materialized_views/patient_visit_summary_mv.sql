CREATE MATERIALIZED VIEW IF NOT EXISTS patient_visit_summary_mv AS
SELECT
    p.patient_id,
    p.gender,
    COUNT(v.visit_id) AS visit_count
FROM stg_patients p
LEFT JOIN stg_visits v
    ON p.patient_id = v.patient_id
GROUP BY p.patient_id, p.gender;
