COPY raw.patients_raw(
    patient_id,
    first_name,
    last_name,
    gender,
    dob,
    branch_id
)
FROM 'C:/Users/user/Desktop/Projects/HospitalDB_ETL/phase1/csv/patients.csv'
CSV HEADER;