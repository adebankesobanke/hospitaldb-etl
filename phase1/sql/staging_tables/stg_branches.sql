CREATE TABLE IF NOT EXISTS staging.branches AS
SELECT
    branch_id,
    branch_name,
    city,
    state
FROM raw.branches_raw;