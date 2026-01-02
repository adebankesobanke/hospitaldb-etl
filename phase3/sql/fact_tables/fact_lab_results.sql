-- ==========================================
-- Fact Table: Lab Results
-- ==========================================
CREATE TABLE IF NOT EXISTS fact_lab_results (
    lab_result_id INT PRIMARY KEY,
    visit_id INT,
    test_name VARCHAR(100),
    result VARCHAR(100),
    cost DECIMAL(10,2),
    test_date DATE,
    FOREIGN KEY (visit_id) REFERENCES fact_visits(visit_id),
    FOREIGN KEY (test_date) REFERENCES dim_time(date_id)
);
