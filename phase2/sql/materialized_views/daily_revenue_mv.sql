CREATE MATERIALIZED VIEW IF NOT EXISTS analytics.mv_daily_revenue AS
SELECT
    DATE(v.visit_date) AS revenue_date,
    COUNT(DISTINCT b.visit_id) AS total_visits,
    SUM(b.amount) AS total_revenue
FROM analytics.billing b
JOIN analytics.visits v
    ON b.visit_id = v.visit_id
GROUP BY DATE(v.visit_date)
ORDER BY revenue_date;
