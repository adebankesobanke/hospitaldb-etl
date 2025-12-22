CREATE OR REPLACE FUNCTION calculate_patient_age(p_dob DATE)
RETURNS INT AS $$
BEGIN
    RETURN DATE_PART('year', AGE(CURRENT_DATE, p_dob));
END;
$$ LANGUAGE plpgsql;
