COPY raw.visits_raw(
    visit_id,
    patient_id,
    doctor_id,
    visit_date,
    diagnosis,
    branch_id
)
FROM 'C:/Users/user/Desktop/Projects/HospitalDB_ETL/phase1/csv/visits.csv'
CSV HEADER;
