-- Function: Calculate Total Bill for a Patient
CREATE OR REPLACE FUNCTION fn_total_bill(p_patient_id INT)
RETURNS NUMERIC AS $$
DECLARE total NUMERIC;
BEGIN
    SELECT SUM(amount) INTO total
    FROM staging_billing
    WHERE patient_id = p_patient_id;
    RETURN COALESCE(total, 0);
END;
$$ LANGUAGE plpgsql;
