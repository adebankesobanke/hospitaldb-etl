-- ============================================================
-- Refresh HospitalDB Reporting Tables
-- ============================================================

DO $$
BEGIN
    RAISE NOTICE 'Starting reporting tables refresh...';

    ----------------------------------------------------------------
    -- Revenue Summary
    ----------------------------------------------------------------
    TRUNCATE TABLE revenue_summary;

    INSERT INTO revenue_summary (
        refresh_timestamp,
        total_revenue,
        total_transactions
    )
    SELECT
        NOW(),
        COALESCE(SUM(fb.amount), 0) AS total_revenue,
        COUNT(fb.billing_id) AS total_transactions
    FROM fact_billing fb;

    RAISE NOTICE 'Revenue summary refreshed';

    ----------------------------------------------------------------
    -- Branch Summary (Department-level aggregation)
    ----------------------------------------------------------------
    TRUNCATE TABLE branch_summary;

    INSERT INTO branch_summary (
        refresh_timestamp,
        department_id,
        department_name,
        total_revenue,
        total_visits
    )
    SELECT
        NOW(),
        d.department_id,
        d.department_name,
        COALESCE(SUM(fb.amount), 0) AS total_revenue,
        COUNT(DISTINCT fv.visit_id) AS total_visits
    FROM dim_department d
    LEFT JOIN fact_visits fv
        ON d.department_id = fv.department_id
    LEFT JOIN fact_billing fb
        ON fv.visit_id = fb.visit_id
    GROUP BY
        d.department_id,
        d.department_name;

    RAISE NOTICE 'Branch summary refreshed';

END $$;
