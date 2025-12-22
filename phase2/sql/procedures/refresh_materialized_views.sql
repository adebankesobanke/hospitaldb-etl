CREATE OR REPLACE FUNCTION get_patient_lifetime_value(p_patient_id INT)
RETURNS NUMERIC AS $$
DECLARE
    total NUMERIC;
BEGIN
    SELECT COALESCE(SUM(b.amount), 0)
    INTO total
    FROM stg_billing b
    JOIN stg_visits v ON b.visit_id = v.visit_id
    WHERE v.patient_id = p_patient_id;

    RETURN total;
END;
$$ LANGUAGE plpgsql;
