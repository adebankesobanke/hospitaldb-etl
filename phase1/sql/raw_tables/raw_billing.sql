CREATE TABLE IF NOT EXISTS raw.raw_billing (
    billing_id      SERIAL PRIMARY KEY,
    visit_id        INT,
    patient_id      INT,
    amount          NUMERIC(10,2),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
