-- Procedure: Insert a new patient
CREATE OR REPLACE PROCEDURE sp_insert_patient(
    p_first_name VARCHAR,
    p_last_name VARCHAR,
    p_birth_date DATE,
    p_gender CHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO staging_patients (first_name, last_name, birth_date, gender)
    VALUES (p_first_name, p_last_name, p_birth_date, p_gender);
END;
$$;
