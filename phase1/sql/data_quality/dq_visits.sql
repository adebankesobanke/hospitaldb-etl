-- Data Quality Checks for raw.visits_raw

-- 1. Check for null visit IDs
SELECT *
FROM raw.visits_raw
WHERE visit_id IS NULL;

-- 2. Check for duplicate visit IDs
SELECT visit_id, COUNT(*) AS cnt
FROM raw.visits_raw
GROUP BY visit_id
HAVING COUNT(*) > 1;

-- 3. Check for invalid patient references
SELECT v.*
FROM raw.visits_raw v
LEFT JOIN raw.patients_raw p
  ON v.patient_id = p.patient_id
WHERE p.patient_id IS NULL;

-- 4. Check for missing visit dates
SELECT *
FROM raw.visits_raw
WHERE visit_date IS NULL;
