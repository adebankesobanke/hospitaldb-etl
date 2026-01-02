-- ==========================================
-- Dimension Table: Department
-- ==========================================
CREATE TABLE IF NOT EXISTS dim_department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    location VARCHAR(100)
);
