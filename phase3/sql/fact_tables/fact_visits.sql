-- ==========================================
-- Fact Table: Visits
-- ==========================================
CREATE TABLE IF NOT EXISTS fact_visits (
    visit_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    department_id INT,
    visit_date DATE,
    length_of_stay INT,
    diagnosis VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES dim_patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES dim_doctor(doctor_id),
    FOREIGN KEY (department_id) REFERENCES dim_department(department_id),
    FOREIGN KEY (visit_date) REFERENCES dim_time(date_id)
);
