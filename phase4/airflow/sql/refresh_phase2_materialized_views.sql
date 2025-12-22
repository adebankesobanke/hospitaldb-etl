/*
=========================================================
File: refresh_phase2_materialized_views.sql
Purpose:
    Refresh all Phase 2 analytics materialized views
=========================================================
*/

REFRESH MATERIALIZED VIEW CONCURRENTLY analytics.mv_visit_summary;
REFRESH MATERIALIZED VIEW CONCURRENTLY analytics.mv_billing_summary;
REFRESH MATERIALIZED VIEW CONCURRENTLY analytics.mv_patient_summary;
REFRESH MATERIALIZED VIEW CONCURRENTLY analytics.mv_branch_billing_summary;
