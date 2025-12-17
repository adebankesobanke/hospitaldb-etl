-- PURPOSE: High-level integrity checks for billing table

-- Check for missing foreign keys
SELECT bill_id
FROM raw_billing
WHERE appointment_id IS NULL;

-- Identify bills with unrealistic amounts (e.g., over $10,000)
SELECT bill_id, amount
FROM raw_billing
WHERE amount > 10000;

-- Flag mismatched insurance/payment_type entries
SELECT bill_id, payment_type, insurance_provider
FROM raw_billing
WHERE payment_type = 'Insurance' AND insurance_provider IS NULL;
