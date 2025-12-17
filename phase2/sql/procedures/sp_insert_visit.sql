-- Procedure: Insert a new visit
CREATE OR REPLACE PROCEDURE sp_insert_visit(
    p_patient_id INT,
    p_visit_date DATE,
    p_department VARCHAR,
    p_doctor_id INT,
    p_total_amount NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO staging_visits (patient_id, visit_date, department, doctor_id, total_amount)
    VALUES (p_patient_id, p_visit_date, p_department, p_doctor_id, p_total_amount);
END;
$$;
