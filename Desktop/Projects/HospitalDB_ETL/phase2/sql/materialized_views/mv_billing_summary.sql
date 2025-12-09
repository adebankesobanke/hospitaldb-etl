-- Materialized View: Billing Summary
DROP MATERIALIZED VIEW IF EXISTS mv_billing_summary;
CREATE MATERIALIZED VIEW mv_billing_summary AS
SELECT 
    b.billing_id,
    b.patient_id,
    p.first_name,
    p.last_name,
    p.gender,
    p.date_of_birth,
    v.visit_id,
    v.visit_date,
    b.billing_date,
    b.amount AS billed_amount,
    COALESCE(pay.total_paid, 0) AS amount_paid,
    (b.amount - COALESCE(pay.total_paid, 0)) AS outstanding_balance,
    CASE 
        WHEN b.status = 'PAID' THEN TRUE 
        ELSE FALSE 
    END AS is_fully_paid,
    CURRENT_TIMESTAMP AS refreshed_at
FROM staging_billing b
LEFT JOIN staging_visits v 
    ON b.visit_id = v.visit_id
LEFT JOIN staging_patients p 
    ON b.patient_id = p.patient_id
LEFT JOIN (
    SELECT 
        billing_id,
        SUM(amount_paid) AS total_paid
    FROM staging_payments
    GROUP BY billing_id
) pay 
    ON b.billing_id = pay.billing_id;
