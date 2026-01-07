<<<<<<< HEAD
COPY raw.patients_raw(
    patient_id,
    first_name,
    last_name,
    gender,
    dob,
    branch_id
)
=======
COPY raw.patients_raw(patient_id, first_name, last_name, gender, date_of_birth, phone, email, address, branch_id, created_at)
>>>>>>> 6af9b5afdd4ce94ec461b6cc25b17afbd2b33376
FROM 'C:/Users/user/Desktop/Projects/HospitalDB_ETL/phase1/csv/patients.csv'
CSV HEADER;