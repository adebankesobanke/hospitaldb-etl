<<<<<<< HEAD
COPY raw.doctors_raw(
    doctor_id,
    first_name,
    last_name,
    department,
    branch_id
)
FROM 'C:/Users/user/Desktop/Projects/HospitalDB_ETL/phase1/csv/doctors.csv'
CSV HEADER;

=======

COPY raw.raw_doctors(doctor_id, first_name, last_name, specialty, branch_id, created_at)
FROM 'C:/Users/user/Desktop/Projects/HospitalDB_ETL/phase1/csv/doctors.csv'
CSV HEADER;
>>>>>>> 6af9b5afdd4ce94ec461b6cc25b17afbd2b33376
