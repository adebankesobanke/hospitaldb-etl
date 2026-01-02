-- Data Quality Checks for raw.doctors_raw

-- 1. Check for null doctor IDs
SELECT *
FROM raw.doctors_raw
WHERE doctor_id IS NULL;

-- 2. Check for duplicate doctor IDs
SELECT doctor_id, COUNT(*) AS cnt
FROM raw.doctors_raw
GROUP BY doctor_id
HAVING COUNT(*) > 1;

-- 3. Check for invalid branch references
SELECT d.*
FROM raw.doctors_raw d
LEFT JOIN raw.branches_raw b
  ON d.branch_id = b.branch_id
WHERE b.branch_id IS NULL;

-- 4. Check for missing required fields
SELECT *
FROM raw.doctors_raw
WHERE first_name IS NULL
   OR last_name IS NULL
   OR specialty IS NULL;
