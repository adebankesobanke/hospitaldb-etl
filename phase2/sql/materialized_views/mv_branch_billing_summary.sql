CREATE MATERIALIZED VIEW IF NOT EXISTS mv_branch_billing_summary AS
SELECT
    b.branch_id,
    b.branch_name,
    COUNT(DISTINCT v.visit_id) AS total_visits,
    SUM(bl.amount) AS total_billed_amount,
    MIN(v.visit_date) AS first_visit_date,
    MAX(v.visit_date) AS last_visit_date
FROM staging.stg_visits v
JOIN staging.stg_billing bl
    ON v.visit_id = bl.visit_id
JOIN staging.stg_branches b
    ON v.branch_id = b.branch_id
GROUP BY
    b.branch_id,
    b.branch_name;
