COPY raw.billing_raw(
    billing_id,
    visit_id,
    amount,
    status,
    billing_date,
    branch_id
)
FROM 'C:/Users/user/Desktop/Projects/HospitalDB_ETL/phase1/csv/billings.csv'
CSV HEADER;

