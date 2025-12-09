DROP FUNCTION IF EXISTS fn_days_between;

CREATE FUNCTION fn_days_between(start_date DATE, end_date DATE)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF start_date IS NULL OR end_date IS NULL THEN
        RETURN NULL;
    END IF;

    RETURN (end_date - start_date);
END;
$$;
