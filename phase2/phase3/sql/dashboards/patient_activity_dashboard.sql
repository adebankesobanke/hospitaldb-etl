CREATE OR REPLACE VIEW patient_activity_dashboard AS
SELECT
    p.patient_id,
    p.gender,
    COUNT(v.visit_id) AS total_visits,
    AVG(EXTRACT(DAY FROM AGE(v.visit_date, p.date_of_birth))) AS avg_visit_interval
FROM stg_patients p
LEFT JOIN stg_visits v
    ON p.patient_id = v.patient_id
GROUP BY p.patient_id, p.gender;
