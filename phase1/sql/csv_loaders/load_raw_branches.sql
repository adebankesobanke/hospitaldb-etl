COPY raw.branches_raw(
    branch_id,
    branch_name,
    address,
    city,
    state
)
FROM 'C:/Users/user/Desktop/Projects/HospitalDB_ETL/phase1/csv/branches.csv'
CSV HEADER;
