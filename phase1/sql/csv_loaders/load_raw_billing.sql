<<<<<<< HEAD
COPY raw.billing_raw(
    billing_id,
    visit_id,
    amount,
    status,
    billing_date,
    branch_id
)
FROM 'C:/Users/user/Desktop/Projects/HospitalDB_ETL/phase1/csv/billings.csv'
=======
-- load_raw_billing.sql

COPY raw.raw_billing(
    appointment_id,
    amount,
    payment_method,
    payment_status,
    branch_id
)
FROM 'C:/Users/user/Desktop/Projects/HospitalDB_ETL/phase1/csv/billing.csv'
>>>>>>> 6af9b5afdd4ce94ec461b6cc25b17afbd2b33376
CSV HEADER;

