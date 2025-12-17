-- View: Doctor Visit Summary
CREATE OR REPLACE VIEW vw_doctor_visits AS
SELECT
    d.doctor_id,
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name,
    COUNT(fv.visit_id) AS total_visits,
    SUM(fv.length_of_stay) AS total_days
FROM dim_doctor d
JOIN fact_visits fv
    ON d.doctor_id = fv.doctor_id
GROUP BY d.doctor_id, d.first_name, d.last_name;
