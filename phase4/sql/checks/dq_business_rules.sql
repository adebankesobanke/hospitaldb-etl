-- =================================
-- Data Quality: Business Rule Checks
-- =================================

-- Billing amount should never be negative or zero
INSERT INTO analytics.data_quality_results (check_name, table_name, status, issue_count, error_message)
SELECT
    'INVALID_BILLING_AMOUNT',
    'analytics.billing',
    CASE
        WHEN COUNT(*) = 0 THEN 'PASS'
        ELSE 'FAIL'
    END,
    COUNT(*),
    'Billing amount must be greater than zero'
FROM analytics.billing
WHERE amount <= 0;

-- Daily revenue should not be NULL
INSERT INTO analytics.data_quality_results (check_name, table_name, status, issue_count, error_message)
SELECT
    'NULL_DAILY_REVENUE',
    'analytics.mv_daily_revenue',
    CASE
        WHEN COUNT(*) = 0 THEN 'PASS'
        ELSE 'FAIL'
    END,
    COUNT(*),
    'Daily revenue contains NULL values'
FROM analytics.mv_daily_revenue
WHERE total_revenue IS NULL;
