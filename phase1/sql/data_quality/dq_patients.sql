-- Data Quality Checks for raw.patients_raw

-- 1. Check for null patient IDs
SELECT *
FROM raw.patients_raw
WHERE patient_id IS NULL;

-- 2. Check for duplicate patient IDs
SELECT patient_id, COUNT(*) AS cnt
FROM raw.patients_raw
GROUP BY patient_id
HAVING COUNT(*) > 1;

-- 3. Check for invalid branch references
SELECT p.*
FROM raw.patients_raw p
LEFT JOIN raw.branches_raw b
  ON p.branch_id = b.branch_id
WHERE b.branch_id IS NULL;

-- 4. Check for missing required fields
SELECT *
FROM raw.patients_raw
WHERE first_name IS NULL
   OR last_name IS NULL
   OR date_of_birth IS NULL;
