CREATE MATERIALIZED VIEW IF NOT EXISTS daily_revenue_mv AS
SELECT
    v.visit_date,
    SUM(b.amount) AS total_revenue
FROM stg_visits v
JOIN stg_billing b
    ON v.visit_id = b.visit_id
GROUP BY v.visit_date;
