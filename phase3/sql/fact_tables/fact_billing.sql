-- ==========================================
-- Fact Table: Billing
-- ==========================================
CREATE TABLE IF NOT EXISTS fact_billing (
    billing_id INT PRIMARY KEY,
    visit_id INT,
    patient_id INT,
    billing_date DATE,
    amount DECIMAL(10,2),
    status VARCHAR(50),
    FOREIGN KEY (visit_id) REFERENCES fact_visits(visit_id),
    FOREIGN KEY (patient_id) REFERENCES dim_patient(patient_id),
    FOREIGN KEY (billing_date) REFERENCES dim_time(date_id)
);
