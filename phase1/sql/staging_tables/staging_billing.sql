CREATE SCHEMA IF NOT EXISTS staging;

DROP TABLE IF EXISTS staging.billing;

CREATE TABLE staging.billing AS
SELECT
    billing_id,
    visit_id,
    patient_id,
    amount,
    created_at
FROM raw.raw_billing
WHERE billing_id IS NOT NULL;