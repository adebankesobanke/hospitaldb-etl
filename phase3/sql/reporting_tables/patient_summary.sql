/*
=========================================================
File: patient_summary.sql
Phase: 3 – Reporting Tables
Purpose:
    Create a patient-level summary table for analytics,
    dashboards, and executive reporting.

Design Choices:
    - One row per patient
    - Aggregated visit, billing, and recency metrics
    - Built from curated Phase 2 materialized views
    - Idempotent (safe to re-run)
=========================================================
*/

DROP TABLE IF EXISTS reporting.patient_summary;

CREATE TABLE reporting.patient_summary AS
SELECT
    p.patient_id,
    p.first_name,
    p.last_name,
    p.gender,
    p.date_of_birth,

    COUNT(DISTINCT v.visit_id)                     AS total_visits,
    COUNT(DISTINCT v.branch_id)                    AS branches_visited,

    MIN(v.visit_date)                              AS first_visit_date,
    MAX(v.visit_date)                              AS last_visit_date,

    ROUND(
        AVG(v.visit_amount)::NUMERIC,
        2
    )                                              AS avg_visit_amount,

    SUM(v.visit_amount)                            AS total_amount_spent,

    ROUND(
        SUM(v.visit_amount)
        / NULLIF(COUNT(DISTINCT v.visit_id), 0),
        2
    )                                              AS avg_spend_per_visit,

    CURRENT_DATE - MAX(v.visit_date)               AS days_since_last_visit

FROM core.patients p
LEFT JOIN analytics.mv_visit_summary v
    ON p.patient_id = v.patient_id
