CREATE TABLE IF NOT EXISTS raw.raw_treatments (
    treatment_id SERIAL PRIMARY KEY,
    visit_id INT NOT NULL,
    treatment_name TEXT,
    cost NUMERIC(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
