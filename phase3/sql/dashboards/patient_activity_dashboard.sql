/*
=========================================================
File: patient_activity_dashboard.sql
Phase: 3 – Dashboards
Purpose:
    Provide patient activity metrics for dashboards,
    including engagement, recency, and spending behavior.

Design Choices:
    - Read-only SELECT (no transformations)
    - Built on Phase 3 reporting tables
    - Optimized for BI tool consumption
    - One row per patient
=========================================================
*/

SELECT
    ps.patient_id,
    ps.first_name,
    ps.last_name,
    ps.gender,
    ps.date_of_birth,

    ps.total_visits,
    ps.branches_visited,

    ps.first_visit_date,
