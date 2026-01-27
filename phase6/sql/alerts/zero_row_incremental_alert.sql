-- Detect silent ETL failures where tables are empty

SELECT
    'mv_patient_visits' AS object_name,
    COUNT(*) AS row_count
FROM analytics.mv_patient_visits
HAVING COUNT(*) = 0

UNION ALL

SELECT
    'mv_billing_summary',
    COUNT(*)
FROM analytics.mv_billing_summary
HAVING COUNT(*) = 0;
