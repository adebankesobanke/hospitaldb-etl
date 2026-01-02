COPY raw.treatments_raw(
    treatment_id,
    visit_id,
    treatment_description,
    cost,
    branch_id
)
FROM 'C:/Users/user/Desktop/Projects/HospitalDB_ETL/phase1/csv/treatments.csv'
CSV HEADER;
