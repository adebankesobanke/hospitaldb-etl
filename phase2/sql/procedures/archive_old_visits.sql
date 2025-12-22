CREATE OR REPLACE PROCEDURE archive_old_visits()
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM stg_visits
    WHERE visit_date < CURRENT_DATE - INTERVAL '8 years';
END;
$$;
