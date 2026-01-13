CREATE INDEX IF NOT EXISTS idx_billing_visit_id
ON analytics.billing (visit_id);

-- Speed up revenue aggregations
CREATE INDEX IF NOT EXISTS idx_billing_amount
ON analytics.billing (amount);
