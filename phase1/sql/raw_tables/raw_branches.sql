DROP TABLE IF EXISTS raw.branches_raw;

CREATE TABLE raw.branches_raw (
    branch_id INTEGER,
    branch_name TEXT,
    address TEXT,
    city TEXT,
    state TEXT
);
