/*
=========================================================
File: refresh_reporting_tables.sql
Phase: 3 – Procedures
Purpose:
    Refresh all Phase 3 reporting tables used for
    dashboards and analytics.

Design Choices:
    - Centralized refresh logic
    - Ensures reporting tables stay in sync
    - Safe to re-run
    - Can be scheduled via cron, Airflow, or pgAgent
=========================================================
*/

CREATE OR REPLACE PROCEDURE reporting.refresh_reporting_tables()
LANGUAGE plpgsql
AS $$
BEGIN

    RAISE NOTICE 'Refreshing reporting tables...';

    -- Patient-level reporting
    RAISE NOTICE 'Refreshing patient_summary...';
    EXECUTE 'DROP TABLE IF EXISTS reporting.patient_summary';
    EXECUTE 'CREATE TABLE reporting.patient_summary AS
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

            ROUND(AVG(v.visit_amount)::NUMERIC, 2)         AS avg_visit_amount,
            SUM(v.visit_amount)                            AS total_amount_spent,

            ROUND(
                SUM(v.v
