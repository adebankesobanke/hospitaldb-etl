CREATE OR REPLACE PROCEDURE refresh_reporting_tables()
LANGUAGE plpgsql
AS $$
BEGIN
    TRUNCATE TABLE revenue_summary;
    INSERT INTO revenue_summary
    SELECT * FROM revenue_summary;  -- assuming the table rebuild query
END;
$$;
