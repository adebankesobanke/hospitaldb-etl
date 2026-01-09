CREATE SCHEMA IF NOT EXISTS staging;

DROP TABLE IF EXISTS staging.branches;

CREATE TABLE staging.branches AS
SELECT
    branch_id,
    branch_name,
    address,
    city,
    state,
    created_at
FROM raw.branches_raw
WHERE branch_id IS NOT NULL;
