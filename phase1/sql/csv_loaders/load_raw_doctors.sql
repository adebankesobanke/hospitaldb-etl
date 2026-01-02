COPY raw.doctors_raw(
    doctor_id,
    first_name,
    last_name,
    department,
    branch_id
)
FROM 'C:/Users/user/Desktop/Projects/HospitalDB_ETL/phase1/csv/doctors.csv'
CSV HEADER;

