-- ===============================
-- Data Quality: NULL Checks
-- ===============================

-- Patients: patient_id should never be NULL
INSERT INTO analytics.data_quality_results (check_name, table_name, status, issue_count)
SELECT
    'NULL_CHECK_PATIENT_ID',
    'analytics.patients',
    CASE 
        WHEN COUNT(*) = 0 THEN 'PASS'
        ELSE 'FAIL'
    END,
    COUNT(*)
FROM analytics.patients
WHERE patient_id IS NULL;

-- Visits: visit_date should never be NULL
INSERT INTO analytics.data_quality_results (check_name, table_name, status, issue_count)
SELECT
    'NULL_CHECK_VISIT_DATE',
    'analytics.visits',
    CASE 
        WHEN COUNT(*) = 0 THEN 'PASS'
        ELSE 'FAIL'
    END,
    COUNT(*)
FROM analytics.visits
WHERE visit_date IS NULL;

-- Billing: amount should never be NULL
INSERT INTO analytics.data_quality_results (check_name, table_name, status, issue_count)
SELECT
    'NULL_CHECK_BILLING_AMOUNT',
    'analytics.billing',
    CASE 
        WHEN COUNT(*) = 0 THEN 'PASS'
        ELSE 'FAIL'
    END,
    COUNT(*)
FROM analytics.billing
WHERE amount IS NULL;
