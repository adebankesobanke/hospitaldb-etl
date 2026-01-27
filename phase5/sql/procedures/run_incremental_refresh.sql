CREATE OR REPLACE PROCEDURE analytics.run_incremental_refresh()
LANGUAGE plpgsql
AS $$
BEGIN
    RAISE NOTICE 'Starting Phase 5 incremental refresh...';

    -- =================================================
    -- Incremental: Patient Visits
    -- =================================================
    RAISE NOTICE 'Incremental load: patient visits';

    INSERT INTO analytics.mv_patient_visits_delta (
        visit_id,
        patient_id,
        visit_date,
        visit_type,
        branch_id
    )
    SELECT
        v.visit_id,
        v.patient_id,
        v.visit_date,
        v.visit_type,
        v.branch_id
    FROM analytics.visits v
    LEFT JOIN analytics.mv_patient_visits_delta d
        ON v.visit_id = d.visit_id
    WHERE d.visit_id IS NULL;

    INSERT INTO analytics.incremental_load_audit (
        table_name,
        last_processed_id
    )
    SELECT
        'mv_patient_visits_delta',
        MAX(visit_id)
    FROM analytics.mv_patient_visits_delta;

    -- =================================================
    -- Incremental: Billing Summary
    -- =================================================
    RAISE NOTICE 'Incremental load: billing summary';

    INSERT INTO analytics.mv_billing_summary_delta (
        billing_id,
        patient_id,
        visit_id,
        amount
    )
    SELECT
        b.billing_id,
        b.patient_id,
        b.visit_id,
        b.amount
    FROM analytics.billing b
    LEFT JOIN analytics.mv_billing_summary_delta d
        ON b.billing_id = d.billing_id
    WHERE d.billing_id IS NULL;

    INSERT INTO analytics.incremental_load_audit (
        table_name,
        last_processed_id
    )
    SELECT
        'mv_billing_summary_delta',
        MAX(billing_id)
    FROM analytics.mv_billing_summary_delta;

    -- =================================================
    -- Refresh Materialized Views
    -- =================================================
    RAISE NOTICE 'Refreshing materialized views';

    REFRESH MATERIALIZED VIEW analytics.mv_patient_visits;
    REFRESH MATERIALIZED VIEW analytics.mv_billing_summary;

    RAISE NOTICE 'Phase 5 incremental refresh completed successfully.';
    -- Phase 6: Data quality validation
PERFORM analytics.check_zero_row_loads();
RAISE NOTICE 'Phase 6 data quality checks completed.';
    PERFORM analytics.check_zero_row_loads();
RAISE NOTICE 'Zero-row load check completed.';

EXCEPTION
    WHEN OTHERS THEN
        INSERT INTO analytics.incremental_load_audit (
            table_name,
            error_message
        )
        VALUES (
            'run_incremental_refresh',
            SQLERRM
        );

        RAISE;
END;
$$;

