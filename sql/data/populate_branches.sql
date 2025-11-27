INSERT INTO branches (branch_name, location)
SELECT
'Branch ' || g,
'City Area ' || g
FROM generate_series(1, 10) g;
