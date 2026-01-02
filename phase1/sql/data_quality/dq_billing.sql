-- Data Quality Checks for raw.billings_raw

-- 1. Check for null billing IDs
SELECT *
FROM raw.billings_raw
WHERE billing_id IS NULL;

-- 2. Check for duplicate billing IDs
SELECT billing_id, COUNT(*) AS cnt
FROM raw.billings_raw
GROUP BY billing_id
HAVING COUNT(*) > 1;

-- 3. Check for negative or zero amounts
SELECT *
FROM raw.billings_raw
WHERE amount <= 0;

-- 4. Check for invalid visit references
SELECT b.*
FROM raw.billings_raw b
LEFT JOIN raw.visits_raw v
  ON b.visit_id = v.visit_id
WHERE v.visit_id IS NULL;
