-- Placeholder for dashboards refresh
-- Replace with actual dashboard ETL

-- Example: updating aggregated dashboard tables
TRUNCATE TABLE dashboards.daily_revenue;
INSERT INTO dashboards.daily_revenue
SELECT CURRENT_DATE, SUM(amount) FROM phase3_raw.revenue_data;

