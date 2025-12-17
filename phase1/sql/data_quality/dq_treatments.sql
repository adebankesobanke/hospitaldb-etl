-- Data Quality Checks for raw.treatments_raw

-- 1. Check for null treatment IDs
SELECT *
FROM raw.treatments_raw
WHERE treatment_id IS NULL;

-- 2. Check for duplicate treatment IDs
SELECT treatment_id, COUNT(*) AS cnt
FROM raw.treatments_raw
GROUP BY treatment_id
HAVING COUNT(*) > 1;

-- 3. Check for invalid visit references
SELECT t.*
FROM raw.treatments_raw t
LEFT JOIN raw.visits_raw v
  ON t.visit_id = v.visit_id
WHERE v.visit_id IS NULL;

-- 4. Check for missing required fields
SELECT *
FROM raw.treatments_raw
WHERE treatment_name IS NULL
   OR treatment_date IS NULL
   OR doctor_id IS NULL;

-- 5. Check for invalid doctor references
SELECT t.*
FROM raw.treatments_raw t
LEFT JOIN raw.doctors_raw d
  ON t.doctor_id = d.doctor_id
WHERE d.doctor_id IS NULL;
