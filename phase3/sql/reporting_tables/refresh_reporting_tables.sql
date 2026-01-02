-- =====================================================
-- Procedure: refresh_reporting_tables
-- Purpose : Rebuild all reporting tables for dashboards
-- Author  : HospitalDB ETL Project
-- =====================================================

CREATE OR REPLACE PROCEDURE refresh_reporting_tables()
LANGUAGE plpgsql
AS $$
BEGIN
    RAISE NOTICE 'Starting reporting tables refresh...';

    -- ---------------------------------------------
    -- Revenue Summary
    -- ---------------------------------------------
    TRUNCATE TABLE revenue_summary;

    INSERT INTO revenue_summary (
        refresh_timestamp,
        total_revenue,
        total_transactions
    )
    SELECT
        NOW(),
        SUM(amount) AS total_revenue,
        COUNT(*) AS total_transactions
    FROM fact_billing;

    RAISE NOTICE 'Revenue summary refreshed';

    -- ---------------------------------------------
    -- Branch Summary
    -- ---------------------------------------------
    TRUNCATE TABLE branch_summary;

    INSERT INTO branch_summary (
        refresh_timestamp,
        branch_id,
        branch_name,
        total_revenue,
        total_visits
    )
    SELECT
        NOW(),
        b.branch_id,
        b.branch_name,
        SUM(fb.amount) AS total_revenue,
        COUNT(fv.visit_id) AS total_visits
    FROM fact_billing fb
    JOIN fact_visits fv ON fb.visit_id = fv.visit_id
    JOIN dim_department b ON fv.department_id = b.department_id
    GROUP BY b.branch_id, b.branch_name;

    RAISE NOTICE 'Branch summary refreshed';

    -- ---------------------------------------------
    -- Patient Summary
    -- ---------------------------------------------
    TRUNCATE TABLE patient_summary;

    INSERT INTO patient_summary (
        refresh_timestamp,
        patient_id,
        patient_name,
        total_spent,
        visit_count,
        last_visit_date
    )
    SELECT
        NOW(),
        p.patient_id,
        p.patient_name,
        SUM(fb.amount) AS total_spent,
        COUNT(fv.visit_id) AS visit_count,
        MAX(fv.visit_date) AS last_visit_date
    FROM dim_patient p
    LEFT JOIN fact_visits fv ON p.patient_id = fv.patient_id
    LEFT JOIN fact_billing fb ON fv.visit_id = fb.visit_id
    GROUP BY p.patient_id, p.patient_name;

    RAISE NOTICE 'Patient summary refreshed';

    RAISE NOTICE 'All reporting tables refreshed successfully';

END;
$$;
