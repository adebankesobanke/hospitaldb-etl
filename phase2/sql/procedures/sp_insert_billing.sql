-- Procedure: Insert a new billing record
CREATE OR REPLACE PROCEDURE sp_insert_billing(
    p_patient_id INT,
    p_visit_id INT,
    p_billing_date DATE,
    p_amount NUMERIC,
    p_status VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO staging_billing (patient_id, visit_id, billing_date, amount, status)
    VALUES (p_patient_id, p_visit_id, p_billing_date, p_amount, p_status);
END;
$$;
