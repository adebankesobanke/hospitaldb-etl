-- Incremental load for mv_daily_revenue
WITH last_processed AS (
    SELECT COALESCE(MAX(last_processed_id), 0) AS last_id
    FROM analytics.incremental_load_audit
    WHERE table_name = 'mv_daily_revenue'
)
INSERT INTO analytics.mv_daily_revenue (branch_id, revenue_date, total_revenue)
SELECT dr.branch_id, dr.revenue_date, dr.total_revenue
FROM analytics.daily_revenue_source dr
JOIN last_processed lp ON dr.revenue_date > COALESCE(lp.last_processed_id, '1900-01-01'::date);

-- Update audit table
INSERT INTO analytics.incremental_load_audit (table_name, last_processed_id)
SELECT 'mv_daily_revenue', MAX(revenue_date)
FROM analytics.mv_daily_revenue;
