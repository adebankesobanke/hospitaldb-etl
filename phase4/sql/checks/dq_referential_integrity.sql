-- =========================================
-- Data Quality: Referential Integrity Checks
-- =========================================

-- Orphaned visits (patient_id not found in patients)
INSERT INTO analytics.data_quality_results (check_name, table_name, status, issue_count)
SELECT
    'ORPHAN_VISITS_PATIENT_ID',
    'analytics.visits',
    CASE
        WHEN COUNT(*) = 0 THEN 'PASS'
        ELSE 'FAIL'
    END,
    COUNT(*)
FROM analytics.visits v
LEFT JOIN analytics.patients p
    ON v.patient_id = p.patient_id
WHERE p.patient_id IS NULL;

-- Orphaned billing records (visit_id not found in visits)
INSERT INTO analytics.data_quality_results (check_name, table_name, status, issue_count)
SELECT
    'ORPHAN_BILLING_VISIT_ID',
    'analytics.billing',
    CASE
        WHEN COUNT(*) = 0 THEN 'PASS'
        ELSE 'FAIL'
    END,
    COUNT(*)
FROM analytics.billing b
LEFT JOIN analytics.visits v
    ON b.visit_id = v.visit_id
WHERE v.visit_id IS NULL;
