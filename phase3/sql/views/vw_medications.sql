-- View: Medications per Visit
CREATE OR REPLACE VIEW vw_medications AS
SELECT
    fv.visit_id,
    p.patient_id,
    p.first_name,
    p.last_name,
    m.medication_id,
    m.drug_name,
    m.dose,
    m.prescription_date
FROM fact_medications m
JOIN fact_visits fv
    ON m.visit_id = fv.visit_id
JOIN dim_patient p
    ON fv.patient_id = p.patient_id;
