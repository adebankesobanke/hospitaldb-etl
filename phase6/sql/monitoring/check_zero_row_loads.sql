CREATE OR REPLACE FUNCTION analytics.check_zero_row_loads()
RETURNS VOID AS $$
DECLARE
    v_count INTEGER;
BEGIN
    -- Check mv_patient_visits
    SELECT COUNT(*) INTO v_count FROM analytics.mv_patient_visits;

    IF v_count = 0 THEN
        INSERT INTO analytics.etl_alert_log (
            alert_type,
            object_name,
            details
        )
        VALUES (
            'ZERO_ROW_LOAD',
            'mv_patient_visits',
            'Materialized view contains zero rows after refresh'
        );
    END IF;

    -- Check mv_billing_summary
    SELECT COUNT(*) INTO v_count FROM analytics.mv_billing_summary;

    IF v_count = 0 THEN
        INSERT INTO analytics.etl_alert_log (
            alert_type,
            object_name,
            details
        )
        VALUES (
            'ZERO_ROW_LOAD',
            'mv_billing_summary',
            'Materialized view contains zero rows after refresh'
        );
    END IF;

END;
$$ LANGUAGE plpgsql;
