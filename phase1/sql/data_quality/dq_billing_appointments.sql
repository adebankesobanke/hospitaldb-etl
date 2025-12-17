
-- PURPOSE: Validate billing against appointments (duplicates, invalid status, etc.)

-- Duplicate billing entries for the same appointment
SELECT appointment_id, COUNT(*) AS count_bills
FROM raw_billing
GROUP BY appointment_id
HAVING COUNT(*) > 1;

-- Check bills with negative or zero amounts
SELECT bill_id, appointment_id, amount
FROM raw_billing
WHERE amount IS NULL OR amount <= 0;

-- Bills referencing appointments with mismatching dates
SELECT b.bill_id, b.appointment_id, b.bill_date, a.appointment_date
FROM raw_billing b
JOIN raw_appointments a ON b.appointment_id = a.appointment_id
WHERE b.bill_date < a.appointment_date;
