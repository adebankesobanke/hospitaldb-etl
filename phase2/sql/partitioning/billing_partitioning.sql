CREATE TABLE IF NOT EXISTS stg_billing_partitioned (
    billing_id INT,
    visit_id INT,
    amount NUMERIC(12,2),
    billing_date DATE
)
PARTITION BY RANGE (billing_date);

CREATE TABLE IF NOT EXISTS stg_billing_2024
PARTITION OF stg_billing_partitioned
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');
