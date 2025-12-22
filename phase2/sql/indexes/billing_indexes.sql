CREATE INDEX IF NOT EXISTS idx_stg_billing_visit
ON stg_billing (visit_id);

CREATE INDEX IF NOT EXISTS idx_stg_billing_amount
ON stg_billing (amount);
