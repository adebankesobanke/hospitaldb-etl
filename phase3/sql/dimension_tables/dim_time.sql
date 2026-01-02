-- ==========================================
-- Dimension Table: Time
-- ==========================================
CREATE TABLE IF NOT EXISTS dim_time (
    date_id DATE PRIMARY KEY,
    day INT,
    month INT,
    quarter INT,
    year INT,
    day_of_week VARCHAR(20),
    is_weekend BOOLEAN
);
