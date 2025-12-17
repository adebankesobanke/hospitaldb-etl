COPY raw.billing_raw(billing_id, patient_id, visit_id, appointment_id, amount, status, branch_id, billing_date, created_at)
FROM 'C:/Users/user/Desktop/Projects/HospitalDB_ETL/phase1/csv/billing.csv'
CSV HEADER;

