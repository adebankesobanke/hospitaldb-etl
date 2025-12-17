-- View: Department Revenue
CREATE OR REPLACE VIEW vw_department_revenue AS
SELECT
    dept.department_id,
    dept.department_name,
    SUM(fb.amount) AS total_revenue
FROM dim_department dept
JOIN fact_visits fv
    ON dept.department_id = fv.department_id
JOIN fact_billing fb
    ON fv.visit_id = fb.visit_id
GROUP BY dept.department_id, dept.department_name;
