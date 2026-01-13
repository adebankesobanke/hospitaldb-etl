CREATE MATERIALIZED VIEW analytics.mv_branch_kpis AS
SELECT
    br.branch_id,
    br.branch_name,
    COUNT(DISTINCT v.visit_id)    AS total_visits,
    COUNT(DISTINCT v.patient_id)  AS unique_patients,
    SUM(b.amount)                 AS total_billed_amount
FROM analytics.branches br
LEFT JOIN analytics.visits v
    ON br.branch_id = v.branch_id
LEFT JOIN analytics.billing b
    ON v.visit_id = b.visit_id
GROUP BY
    br.branch_id,
    br.branch_name;

CREATE INDEX idx_mv_branch_kpis_branch
ON analytics.mv_branch_kpis(branch_id);