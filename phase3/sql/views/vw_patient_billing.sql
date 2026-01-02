-- View: Patient Billing Summary
CREATE OR REPLACE VIEW vw_patient_billing AS
SELECT
    p.patient_id,
    p.first_name,
    p.last_name,
    b.billing_id,
    b.amount,
    b.status,
    b.billing_date
FROM dim_patient p
JOIN fact_billing b
    ON p.patient_id = b.patient_id;
