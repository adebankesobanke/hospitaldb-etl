<<<<<<< HEAD
COPY raw.branches_raw(
    branch_id,
    branch_name,
    address,
    city,
    state
)
FROM 'C:/Users/user/Desktop/Projects/HospitalDB_ETL/phase1/csv/branches.csv'
CSV HEADER;
=======
CREATE TABLE IF NOT EXISTS raw_branches (
    branch_id   INT PRIMARY KEY,
    branch_name VARCHAR(100),
    address     VARCHAR(255),
    city        VARCHAR(50),
    state       VARCHAR(50),
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
>>>>>>> 6af9b5afdd4ce94ec461b6cc25b17afbd2b33376
