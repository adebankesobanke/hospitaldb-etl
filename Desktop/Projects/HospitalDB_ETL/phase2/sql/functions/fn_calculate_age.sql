-- Function: Calculate Age from Birth Date
DROP FUNCTION IF EXISTS fn_calculate_age;

CREATE FUNCTION fn_calculate_age(dob DATE, ref_date DATE)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE 
    age_years INTEGER;
BEGIN
    IF dob IS NULL OR ref_date IS NULL THEN
        RETURN NULL;
    END IF;

    age_years := DATE_PART('year', age(ref_date, dob));

    RETURN age_years;
END;
$$;
