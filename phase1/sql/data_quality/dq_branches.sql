-- Data Quality Checks for raw.branches_raw

-- 1. Check for null branch IDs
SELECT *
FROM raw.branches_raw
WHERE branch_id IS NULL;

-- 2. Check for duplicate branch IDs
SELECT branch_id, COUNT(*) AS cnt
FROM raw.branches_raw
GROUP BY branch_id
HAVING COUNT(*) > 1;

-- 3. Check for missing branch names
SELECT *
FROM raw.branches_raw
WHERE branch_name IS NULL;
