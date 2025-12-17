
COPY raw.raw_doctors(doctor_id, first_name, last_name, specialty, branch_id, created_at)
FROM 'C:/Users/user/Desktop/Projects/HospitalDB_ETL/phase1/csv/doctors.csv'
CSV HEADER;
