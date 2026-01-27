CREATE OR REPLACE PROCEDURE analytics.run_data_quality_checks()
LANGUAGE plpgsql
AS $$
BEGIN
    RAISE NOTICE 'Starting data quality checks...';

    -- ===============================
    -- NULL CHECKS
    -- ===============================

    INSERT INTO analytics.data_quality_results (check_name, table_name, status, issue_count)
    SELECT 'NULL_CHECK_PATIENT_ID', 'analytics.patients',
           CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
           COUNT(*)
    FROM analytics.patients
    WHERE patient_id IS NULL;

    INSERT INTO analytics.data_quality_results (check_name, table_name, status, issue_count)
    SELECT 'NULL_CHECK_VISIT_DATE', 'analytics.visits',
           CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
           COUNT(*)
    FROM analytics.visits
    WHERE visit_date IS NULL;

    INSERT INTO analytics.data_quality_results (check_name, table_name, status, issue_count)
    SELECT 'NULL_CHECK_BILLING_AMOUNT', 'analytics.billing',
           CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
           COUNT(*)
    FROM analytics.billing
    WHERE amount IS NULL;

    -- ===============================
    -- REFERENTIAL INTEGRITY CHECKS
    -- ===============================

    INSERT INTO analytics.data_quality_results (check_name, table_name, status, issue_count)
    SELECT 'ORPHAN_VISITS_PATIENT_ID', 'analytics.visits',
           CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
           COUNT(*)
    FROM analytics.visits v
    LEFT JOIN analytics.patients p
           ON v.patient_id = p.patient_id
    WHERE p.patient_id IS NULL;

    INSERT INTO analytics.data_quality_results (check_name, table_name, status, issue_count)
    SELECT 'ORPHAN_BILLING_VISIT_ID', 'analytics.billing',
           CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
           COUNT(*)
    FROM analytics.billing b
    LEFT JOIN analytics.visits v
           ON b.visit_id = v.visit_id
    WHERE v.visit_id IS NULL;

    -- ===============================
    -- BUSINESS RULE CHECKS
    -- ===============================

    INSERT INTO analytics.data_quality_results (check_name, table_name, status, issue_count, error_message)
    SELECT 'INVALID_BILLING_AMOUNT', 'analytics.billing',
           CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
           COUNT(*),
           'Billing amount must be greater than zero'
    FROM analytics.billing
    WHERE amount <= 0;

    INSERT INTO analytics.data_quality_results (check_name, table_name, status, issue_count, error_message)
    SELECT 'NULL_DAILY_REVENUE', 'analytics.mv_daily_revenue',
           CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
           COUNT(*),
           'Daily revenue contains NULL values'
    FROM analytics.mv_daily_revenue
    WHERE total_revenue IS NULL;

    RAISE NOTICE 'Data quality checks completed successfully.';
END;
$$;
