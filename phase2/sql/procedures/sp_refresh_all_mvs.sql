DROP PROCEDURE IF EXISTS sp_refresh_all_mvs;

CREATE OR REPLACE PROCEDURE sp_refresh_all_mvs()
LANGUAGE plpgsql
AS $$
BEGIN
    RAISE NOTICE 'Refreshing mv_patient_summary...';
    REFRESH MATERIALIZED VIEW CONCURRENTLY mv_patient_summary;

    RAISE NOTICE 'Refreshing mv_visit_summary...';
    REFRESH MATERIALIZED VIEW CONCURRENTLY mv_visit_summary;

    RAISE NOTICE 'Refreshing mv_billing_summary...';
    REFRESH MATERIALIZED VIEW CONCURRENTLY mv_billing_summary;

    RAISE NOTICE 'All materialized views refreshed successfully.';
END;
$$;
