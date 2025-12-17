-- ==========================================
-- Dimension Table: Doctor
-- ==========================================
CREATE TABLE IF NOT EXISTS dim_doctor (
    doctor_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    specialty VARCHAR(100),
    department_id INT
);
