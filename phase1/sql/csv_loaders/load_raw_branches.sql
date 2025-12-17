CREATE TABLE IF NOT EXISTS raw_branches (
    branch_id   INT PRIMARY KEY,
    branch_name VARCHAR(100),
    address     VARCHAR(255),
    city        VARCHAR(50),
    state       VARCHAR(50),
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
