CREATE TABLE IF NOT EXISTS raw.visits_raw (
    visit_id INT PRIMARY KEY,
    patient_id INT,
    visit_date DATE,
    reason VARCHAR(100),
    branch_id INT,
    FOREIGN KEY (patient_id) REFERENCES raw.patients_raw(patient_id),
    FOREIGN KEY (branch_id) REFERENCES raw.branches_raw(branch_id)
);
