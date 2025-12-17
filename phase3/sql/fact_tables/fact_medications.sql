-- ==========================================
-- Fact Table: Medications
-- ==========================================
CREATE TABLE IF NOT EXISTS fact_medications (
    medication_id INT PRIMARY KEY,
    visit_id INT,
    drug_name VARCHAR(100),
    dose VARCHAR(50),
    cost DECIMAL(10,2),
    prescription_date DATE,
    FOREIGN KEY (visit_id) REFERENCES fact_visits(visit_id),
    FOREIGN KEY (prescription_date) REFERENCES dim_time(date_id)
);
