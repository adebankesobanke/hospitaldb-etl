<<<<<<< HEAD
COPY raw.visits_raw(
    visit_id,
    patient_id,
    doctor_id,
    visit_date,
    diagnosis,
    branch_id
)
=======
COPY raw.visits_raw(visit_id, patient_id, doctor_id, visit_date, branch_id, created_at)
>>>>>>> 6af9b5afdd4ce94ec461b6cc25b17afbd2b33376
FROM 'C:/Users/user/Desktop/Projects/HospitalDB_ETL/phase1/csv/visits.csv'
CSV HEADER;
