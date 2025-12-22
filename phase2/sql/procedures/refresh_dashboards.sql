CREATE OR REPLACE PROCEDURE refresh_dashboards()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Rebuild reporting tables first
    CALL refresh_reporting_tables();

    -- Refresh dashboard views (materialized views if you had them)
    -- For normal views, this step is optional
    -- Example for a materialized view:
    -- REFRESH MATERIALIZED VIEW CONCURRENTLY daily_revenue_dashboard;
    -- REFRESH MATERIALIZED VIEW CONCURRENTLY branch_performance_dashboard;
END;
$$;
