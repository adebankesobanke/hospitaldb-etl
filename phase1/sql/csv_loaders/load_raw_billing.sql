-- load_raw_billing.sql

COPY raw.raw_billing(
    appointment_id,
    amount,
    payment_method,
    payment_status,
    branch_id
)
FROM 'C:/Users/user/Desktop/Projects/HospitalDB_ETL/phase1/csv/billing.csv'
CSV HEADER;

