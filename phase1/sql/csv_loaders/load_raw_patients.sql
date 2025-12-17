COPY raw.patients_raw(patient_id, first_name, last_name, gender, date_of_birth, phone, email, address, branch_id, created_at)
FROM 'C:/Users/user/Desktop/Projects/HospitalDB_ETL/phase1/csv/patients.csv'
CSV HEADER;